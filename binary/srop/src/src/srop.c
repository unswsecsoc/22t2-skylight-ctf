#include <stdio.h>
#include <stdlib.h>
#include "colours.h"

static char* dodgy = "/bin/sh";


void func() {
    __asm__(
        "mov $0x77, %eax;"
        "ret;"
        "int $0x80"
    );
}
void vuln() {
    char buf[4];
    gets(buf);
}

int main() {
    setbuf(stdout, NULL);
    puts(
	"This challenge is an extension to ROP called " KRED "SROP" KNRM "!\n"
	"\nSROP is a form of ROP using " KMAG "syscall 119" KNRM ": sigreturn.\n"
        "What it formally does is the following:\n\n"
	"\t\"Using  the  information that was earlier saved on the userspace\n"
	"\tstack sigreturn() restores the process's signal mask, switches stacks,\n"
	"\tand restores the process's context (processor flags and registers, \n"
	"\tincluding the stack pointer and instruction pointer)\"\n\n\n"

	"Why SROP? Consider the case where you don't have enough gadgets to tinker with the \n"
        "registers to pop a shell."
        "With SROP, we only need " KRED "3" KNRM " things!. One gadget to set " KMAG "eax" KNRM ", \n"
        "one gadget to do a " KMAG "syscall" KNRM ", and finally a ");
    fflush(stdout);

    printf(KMAG "%s" KNRM " string. \n", dodgy);
    fflush(stdout);

    puts(
        "\nHow SROP works: The hacker, you, ROPs to call " KMAG "syscall 119" KNRM " aka sigreturn.\n"
	"As stated above, \"Using  the  information that was earlier\n"
	"saved on the userspace stack sigreturn() restores the process's signal\n"
	"mask, switches  stacks,  and restores the process's context (processor\n"
	"flags and registers, including the stack pointer and instruction pointer)\"\n"
	KBOLDWHT "meaning " KNRM "the sigreturn syscall reads data from the stack then sets every\n"
	"register in the program from that data! " KRED "In other words, if we can control\n"
	"the stack and can execute a sigreturn we can set every register of the program" KNRM "!\n\n"

	"Here is an " KYEL "example" KNRM " visual of what the stack could look like after\n"
	KMAG "gets(buf) " KNRM", addresses will vary:\n"
	"\n--------                     --------------------                                                \n"
	"0x804e00              " KCYN "esp" KNRM " -> |                  |                                  \n"
	"--------                     --------------------                                                  \n"
	"0x804e08              " KBLU "buf" KNRM " -> |                  |                                  \n"
	"--------                     --------------------                                                  \n"
	"    .                        |         .        |                                                  \n"
	"    .                        |         .        |                                                  \n"
	"    .                        |         .        |                                                  \n"
	"--------                     --------------------                                                  \n"
	"0x804e28   " KBLU "return address " KNRM "-> |          " KGRN "--------" KNRM "|" KGRN "--------> " KYEL " gadget: " KRED "mov eax, 119; ret " KNRM "\n"
	"--------                     --------------------                                                  \n"
	"0x804e30                     |          " KGRN "--------" KNRM "|" KGRN "--------> " KYEL " gadget: " KRED "int 0x80" KNRM "\n"
	"--------                     --------------------                                                  \n"
	"0x804e08                     |                  |    \\                                            \n"
	"--------                     --------------------      \\                                          \n"
	"    .                        |         .        |        \\                                        \n"
	"    .                        |         .        |         | - " KBLU "Saved register values" KNRM "\n"
	"    .                        |         .        |        /                                         \n"
	"--------                     --------------------      /                                           \n"
	"0x804f00                     |                  |    /                                             \n"
	"--------                     --------------------                                                  \n\n"

	"Remember, we are calling a sigreturn without receiving a corresponding signal. So we fake \n"
	"the signal by setting up the stack exactly as receiving a signal would. " KMAG "pwntools" KNRM " will be \n"
        "very useful and you will want to use " KBLU "pwn.SigreturnFrame(kernel='amd64')" KNRM ". You can read more \n"
	"on it here: " KCYN "http://docs.pwntools.com/en/stable/rop/srop.html" KNRM "\n"
	KRED "\nDon't" KNRM " forget to set " KMAG "context.arch" KNRM "...\n");
    fflush(stdout);

    vuln();
}

