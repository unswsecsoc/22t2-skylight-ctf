#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <err.h>
#include <string.h>
#include <errno.h>

/* Forward declaration */
int mq_open(void);
int mq_send(int, const void *, size_t);
int mq_recv(int, void *, size_t);
int mq_clear(int);
int mq_close(int);
int readflag(char *, size_t);

int
main (void)
{

	char buf[300] = {0};
	int mq, ret;

	printf("* Opening message queue\n");
	mq = mq_open();

	printf("* Sending message\n");
	mq_send(mq, "Hello World!", 13);

	printf("* Receiving message\n");
	mq_recv(mq, buf, sizeof(buf));

	printf("* Message = \"%s\"\n", buf);

	mq_close(mq);
	printf("* Closing message queue\n");

	ret = readflag(buf, sizeof(buf));
	if (ret != 0)
		printf("* readflag() = %d (errno=%d)\n", ret, errno);
	else
		printf("* readflag() = \"%s\"\n", buf);

	return 0;
}
