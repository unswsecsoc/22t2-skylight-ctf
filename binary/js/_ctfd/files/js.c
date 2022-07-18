#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>

/* gcc js.c -fno-stack-protector -m32 -o js */

void print_flag() {
    [[REDACTED]]
}

void do_maths() {
    char *totally_a_num = "-0.500000";

    puts("I can do math with strings! Look!");
    printf("\"%s\" + 1 = ", totally_a_num);
    puts(totally_a_num + 1);

    puts("Now you try:");
    char *prompt = "\"-0.500000\" + ";
    printf(prompt);

    int a;
    scanf("%d", &a);

    char prompt1[100];
    snprintf(prompt1, sizeof(prompt1), "%s%d", prompt, a);
    int len = strlen(prompt1);

    printf("M[%dC = %s\n", len, totally_a_num + a);


    printf("was the answer accurate? yes/no: ");

    // clear newline from the scanf
    fgets(prompt1, 2, stdin);

    char prompt2[10];
    fgets(prompt2, 1000, stdin);
}

int main(int argc, char **argv) {
    setbuf(stdin, NULL);
    setbuf(stdout, NULL);

    do_maths();

    return EXIT_SUCCESS;
}
