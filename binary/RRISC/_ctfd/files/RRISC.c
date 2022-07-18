#include <stdio.h>
#include <unistd.h>
#include <stdlib.h>
#include <string.h>

#define MEM_SIZE 0x100

struct bracket {
	int offset;
	struct bracket * next;
};

void emulate_program(char * prog, unsigned int prog_len);
struct bracket * remove_at_head(struct bracket * head);

void setup() {
	setvbuf(stdin,NULL,_IONBF, 0);
	setvbuf(stdout,NULL,_IONBF, 0);
}


int main() {
	unsigned int prog_len = 0;
	char tmp[11];
	char * prog = NULL;

	setup();

	puts("How many bytes is your program?");
	fgets(tmp, 11, stdin);
	tmp[strcspn(tmp, "\n")] = '\0';
	prog_len = atoi(tmp);
	printf("prog_len is %d\n", prog_len);


	if (prog_len == 0) {
		puts("Invalid size entered");
		exit(-1);
	}

	prog = (char *)malloc(prog_len+1);

	puts("Enter your program:");
	fgets(prog, prog_len+1, stdin);
	prog[strcspn(prog, "\n")] = '\0';

	emulate_program(prog, prog_len);

}

void emulate_program(char * prog, unsigned int prog_len) {
	unsigned long prog_index = 0;
	unsigned long mem_index = 0;
	unsigned char memory[MEM_SIZE] = {0};

	struct bracket * cur_bracket = alloca(sizeof(struct bracket));
	cur_bracket->next = NULL;
	cur_bracket->offset = 0;

	while (prog_index < prog_len) {
		
		char inst = prog[prog_index];
		switch(inst) {

			case '+':
				memory[mem_index]++;
				break;
			case '-':
				memory[mem_index]--;
				break;

			case '>':
				mem_index++;

				if (mem_index >= MEM_SIZE) {
					mem_index = MEM_SIZE - 1;
				}

				break;
			case '<':
				mem_index--;

				if (mem_index < 0) {
					mem_index = 0;
				}

				break;

			case '[':
				;
				struct bracket * prev_bracket = alloca(sizeof(struct bracket));
				prev_bracket->offset = cur_bracket->offset;
				prev_bracket->next = cur_bracket->next;
				
				cur_bracket->offset = prog_index;
				cur_bracket->next = prev_bracket;

				break;
			case ']':
				if (memory[mem_index] == 0) {
					cur_bracket = remove_at_head(cur_bracket);
				}
				else {
					if (cur_bracket != NULL && cur_bracket->next != NULL) {
						prog_index = cur_bracket->offset;
					}
				}
				break;

			case ',':
				memory[mem_index] = (unsigned char)getchar();
				break;
			case '.':
				putchar(memory[mem_index]);
				break;

			default:
				puts("Invalid instruction detected. Moving past\n");
				break;
		}
		prog_index++;
		fflush(stdout);
	}

}

struct bracket * remove_at_head(struct bracket * head) {
	if (head != NULL && head->next != NULL) {
		struct bracket * tmp = head;
		head = head->next;
		free(tmp);
	}
	return head;

}

