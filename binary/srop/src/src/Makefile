CC         := gcc
CFLAGS     := -O0 -std=gnu99 -m32 -no-pie
VULN_STACK := -fno-stack-protector
INTEL_ASM  := -masm=intel

all: clean build

build:
	$(CC) $(VULN_STACK) $(CFLAGS)  -o srop srop.c

clean:
	rm -f srop



