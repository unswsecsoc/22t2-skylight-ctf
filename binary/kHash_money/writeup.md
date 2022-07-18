# kHash_money

## Authors
- @ItsIronicIInsist

## Category
- Binary Exploit

## Description
I've stuck my hashing program into the kernel - the minimal interface should prevent any worrisome bugs.

## Difficulty
- Extreme

## Points
180

## Hints
1. Most hash algorithms (perhaps, all) can't decode.
2. Is there anything that breaks the separation between user and kernel, address wise? 

## Files
- bzImage: Kernel image
- rootsfs.cpio: file system for the challenge

## Solution
<details>
<summary>Spoiler</summary>

### Idea
Aimed as an introduction to kernel exploitation, it features a basic NULL-derefence bug allowing arbitrary code execution as kernel.

### Walkthrough
1. With the files we're given, the first thing to do is to look through the filesystem.
2. Init script shows that a device is created as /dev/hasher - read/write perms for everyone
3. Otherwise, we're just initialised as a user with uid/gid 1000
4. Next, the source files. hasher.c is the main one - it exposes an ioctl interface allowing us to hash inputs with various algorithms
5. The IOCTL command of most interest is HASH_DECODE, as you should know hashing algorithms are a one-way operation.
6. Base64 can decode, but no other algorithm can. We see that a decode function isnt implemented for these algorithms. So what happens if we try to call it?
7. A segmentation fault probably happens. If we run it and inspect via gdb, we should see the decode function is equal to NULL
8. For a userland program, this is unexploitable. But for a kernel program, this breaks the isolation between kernel and userland - NULL is just an address, and it is one that the user controls.
9. So, what if we map in a function at NULL? That function is executed. The most straightforward one calls commit_cred(prepare_kernel_creds(0)) to make the process have root privileges. Then we can wrie a bash script to /tmp, and execute anything that way.


### Flag
`SKYLIGHT{nu11_deReFeRencEs_ar3_s0_sc4ry!}`
</details>
