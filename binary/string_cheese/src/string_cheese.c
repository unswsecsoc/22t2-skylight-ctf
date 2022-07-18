#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_NAME_LEN 64
#define MAX_PASS_LEN 64

struct user {
	char name[MAX_NAME_LEN];
	char pass[MAX_PASS_LEN];
};

struct user * init_admin();
void read_flag();

int main(void) {
	setvbuf(stdout, NULL, _IONBF, 0);
	setvbuf(stdin, NULL, _IONBF, 0);

	struct user new_user;
	struct user * admin = init_admin();

	puts("Welcome to my humble password checker!");
	puts("Please enter your name!");
	fgets(new_user.name, MAX_NAME_LEN, stdin);

	puts("Please enter your password!");
	fgets(new_user.pass, MAX_PASS_LEN, stdin);
	
	if (strncmp(new_user.pass, admin->pass, MAX_PASS_LEN) == 0 ) {
		puts("Password authenticated succesfully!");
		read_flag();
	}
	else {
		puts("Invalid password! Try again next time!");
	}
}


struct user * init_admin() {
	FILE * rand_fd = fopen("/dev/urandom", "r");
	if (rand_fd == NULL) {
		puts("Error opening urandom. Please contact an organiser\n");
		exit(-1);
	}

	struct user * new = malloc(sizeof(struct user));
	
	strncpy(new->name, "ADMIN", 5);
	fgets(new->pass, MAX_PASS_LEN, rand_fd);

	return new;
}

void read_flag() {
	puts("Heres the flag!\n");
	FILE * flag_fd = fopen("/home/ctf/flag", "r");
	if (flag_fd == NULL) {
		puts("Error opening flag. Please contact an organiser\n");
		exit(-1);
	}

	char flag_buf[64];
	fgets(flag_buf, 64, flag_fd);

	printf("%s\n", flag_buf);
	fflush(stdout);
}
