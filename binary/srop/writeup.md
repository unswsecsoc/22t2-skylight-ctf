# srop

## Authors
- @stevenp2

## Category
- Binary Exploit

## Description
[This challenge is about srop which has now been patched (glibc 2.27 was used here), but nevertheless is still interesting. The exploitations follows from having access to 2 special gadgets, the ability to write 300 bytes onto the stack, and the ability to control the instruction pointer.]

## Difficulty
- Medium

## Points
80

## Hints
1. `/bin/sh` is located in the big wall of text

## Files
- srop: the exploitable binary

## Solution
<details>
<summary>Spoiler</summary>

### Idea
A simple SROP challenge that would align nicely for when ROP is being taught in COMP6447. The challenge is simple as it is intended to guide the player into solving it.

### Walkthrough
1. run `ropper --file srop | grep "eax, 0x77"` and find that there is the gadget that moves 119 (sigreturn) into `eax` at `0x08048513`
2. run `ropper --file srop | grep "0x80"` and we see our syscall at address `0x08048519`
3. next we need to find where `/bin/sh`is and it turns out that it was secretly located inside that wall of text printed (highlighted in magenta)
4. read the pwntools documentation ("http://docs.pwntools.com/en/stable/rop/srop.html") to figure out how to construct the sigreturn frame
5. now all that's left to do is overflow the buffer and call sigreturn 
6. we find that the offset to the EIP is 16 bytes 
7. construct the rop chain by first running our moving our sigreturn, `0x77`, into `eax`
8. chain that with our syscall and add our forged frame at the end

### Flag
`SKYLIGHT{W0W_4DAM_w1LL_b3_s0_Pr0Ud_oF_m3}`
</details>
