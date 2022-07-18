# string_cheese

## Authors
- @ItsIronicIInsist

## Category
- Binary Exploit

## Description
Welcome to the state-of-the-art for password checking, according to like, this one 1521 student we asked.

## Difficulty
- Easy

## Points
50

## Hints
1. Are there any special bytes regarding strings? 
2. How is string length determined?

## Files
- string_cheese.c: the source code

## Solution
<details>
<summary>Spoiler</summary>

### Idea
C-strings are very old, and insecurely implemented compared to more modern representations. This challenge aimed to show a common pitfall of working with them.

### Walkthrough
1. The c file is given to the participants. In it, we generate a random password for the admin.
2. Then, the user can enter their own password, and if it matches the random password, they get the flag.
3. The password is 64 bytes long, so a user would have a 1/(256^64) chance in guessing right. (256 possible values for a byte. ^ represents an exponent)
4. Some participants might suspect some way to affect the password-generation code regarding /dev/urandom, but this is done in a pretty standard manner, and is not vulnerable (to my knowledge).
5. Thus, with no way to affect the password-generation, and the low chance for guessing, the main thing left to inspect is the check itself, and what constitutes strings being equal.
6. For two strings to be equal, they must match for each byte, up to & including the null-terminator. But there are no checks after the null-terminator (as thats when a string ends, right?)
7. And a null-terminator is just the byte 0. /dev/urandom can generated this value.  
8. So, the solution, which requires a bit of bruteforcing, is to provide the password '\0' (literally just the null terminator), and keep trying until the first-byte of the admin password is randomly set to 0. On average, only 100-200 tries.

### Flag
`SKYLIGHT{nu11_byt3s_5uck_r1gh7?}`
</details>
