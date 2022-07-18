#include <types.h>
#include <clock.h>
#include <copyinout.h>
#include <uio.h>
#include <vnode.h>
#include <kern/errno.h>
#include <kern/fcntl.h>
#include <current.h>
#include <vfs.h>
#include <proc.h>

#define MIN(A,B) ((A)<(B)?(A):(B))

#define MAX_MSG_LEN 256
struct message {
	struct message *next;
	size_t len;
	char *buf;
};

struct message_queue {
	struct message *front, *back;
};

/* Helper functions */
static struct message *msg_deque(struct message_queue *);
static struct message *msg_init(const_userptr_t, size_t);
static struct message_queue *id_to_mq(int);
static struct message_queue *msg_queue_create(void);
static void msg_destroy(struct message *);
static void msg_enqueue(struct message_queue *, struct message *);

int
sys_mq_open(int *retval)
{
	struct message_queue *mq;

	for (int i = 0; i < MAX_MQ; i++) {
		if (curproc->mq_list[i] == NULL) {
			mq = msg_queue_create();
			if (!mq)
				return ENOMEM;
			curproc->mq_list[i] = mq;
			*retval = i;
			return 0;
		}
	}

	return ENOMEM;
}

int
sys_mq_close(int mqid, int *retval)
{
	struct message_queue *mq;
	struct message *curr;

	mq = id_to_mq(mqid);
	if (!mq)
		return EINVAL;

	while ((curr = msg_deque(mq)) != NULL)
		msg_destroy(curr);

	mq = curproc->mq_list[mqid];
	kfree(mq);
	curproc->mq_list[mqid] = NULL;

	*retval = 0;
	return 0;
}

/* Push onto the queue */
int
sys_mq_send(int mqid, const_userptr_t buf, size_t len, int *retval)
{
	struct message_queue *mq;
	struct message *msg;

	mq = id_to_mq(mqid);
	if (mq == NULL)
		return EINVAL;

	msg = msg_init(buf, len);
	if (!msg)
		return ENOMEM;

	msg_enqueue(mq, msg);

	*retval = len;
	return 0;
}

int
sys_mq_recv(int mqid, userptr_t buf, size_t len, int *retval)
{
	int ret;
	size_t dest_len;
	struct message_queue *mq;
	struct message *msg;

	mq = id_to_mq(mqid);
	if (!mq)
		return EINVAL;

	msg = msg_deque(mq);
	if (!msg)
		return EINVAL;

	dest_len = MIN(len, msg->len);
	ret = copyout(msg->buf, buf, dest_len);
	if (ret)
		return ret;

	msg_destroy(msg);
	*retval = dest_len;
	return 0;
}

int
sys_mq_clear(int mqid, int *retval)
{
	struct message_queue *mq;
	struct message *curr, *temp;

	mq = id_to_mq(mqid);
	if (!mq)
		return EINVAL;

	*retval = 0;
	curr = mq->front;
	while (curr != NULL) {
		temp = curr;
		curr = curr->next;
		msg_destroy(temp);
		*retval += 1;
	}

	return 0;
}

static struct message *
msg_deque(struct message_queue *mq)
{
	struct message *msg;

	if (mq->front == NULL)
		return NULL;

	msg = mq->front;

	mq->front = mq->front->next;
	if (mq->front == NULL)
		mq->back = NULL;

	msg->next = NULL;
	return msg;
}

static struct message *
msg_init(const_userptr_t buf, size_t len)
{
	int ret;
	struct message *msg;

	if (len > MAX_MSG_LEN)
		return NULL;

	msg = kmalloc(sizeof(struct message));
	if (!msg)
		return NULL;

	msg->next = NULL;
	msg->len = len;
	msg->buf = kmalloc(sizeof(char) * len);
	if (!msg->buf) {
		kfree(msg);
		return NULL;
	}

	ret = copyin(buf, msg->buf, len);
	if (ret != 0) {
		kfree(msg->buf);
		kfree(msg);
		return NULL;
	}

	return msg;
}

static struct message_queue *
id_to_mq(int mqid)
{
	if (mqid < 0)
		return NULL;

	if (mqid >= MAX_MQ)
		return NULL;

	if (curproc->mq_list[mqid] == NULL)
		return NULL;

	return curproc->mq_list[mqid];
}

static void
msg_destroy(struct message *msg)
{
	kfree(msg->buf);
	kfree(msg);
}

static void
msg_enqueue(struct message_queue *mq, struct message *msg)
{
	if (mq->front == NULL) {
		mq->front = mq->back = msg;
	} else {
		mq->back->next = msg;
		mq->back = msg;
	}
}

static struct message_queue *
msg_queue_create(void)
{
	struct message_queue *mq;

	mq = kmalloc(sizeof(struct message_queue));
	if (!mq)
		return NULL;

	mq->front = mq->back = NULL;
	return mq;
}
