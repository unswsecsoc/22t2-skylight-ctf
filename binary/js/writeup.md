# js

## Authors
- [@joooooooooooooooooooooooooooooooooooosh](https://github.com/joooooooooooooooooooooooooooooooooooosh)

## Category
- binary

## Description

Did you know that JavaScript lets you combine together types in all kinds of weird ways? I managed to get C to add strings and integers together too!


## Difficulty
- Easy
- Medium
- Hard

## Points
70

## Hints

## Files
- [js](./_ctfd/files/js): the binary to pwn
- [js.c](./_ctfd/files/js.c): redacted source code for the binary


## Solution
<details>
<summary>Spoiler</summary>

### Idea
Adding a user supplied number to a pointer allows the user to leak memory.

### Walkthrough

The important first steps when pwning a binary is to identify what you want to pwn. There are two places where we are asked for user input, so those are the best places to start looking in this case. Opening the source code, the first input seems pretty benign but the second input accidentally accepts up to 1000 bytes of input into a buffer only 10 bytes big - a classic (if somewhat contrived) buffer overflow!

With such a big buffer overflow we are able to choose exactly what code `do_maths` executes once it returns by overflowing the return address on the stack. If we can place the address of the `print_flag` function there, then that function will be called for us!

The first problem is finding out how much input we need to reach that return address. You could take a binary search approach (trying 500->250->125->188->... based on whether or not the program segfaults) or you could use a cyclic pattern.

#### side note: cyclic patterns

Cyclic patterns are patterns that don't repeat themselves (at least for a long time), so that you can take a section of that pattern and find out when in the pattern it appears.

For example, if you install the `pwntools` package then using `pwn cyclic` will give you the pattern "aaaabaaacaaadaaa..." etc, and if you were to look up a fragment of that pattern you can find out how much of the pattern came before it (e.g. `pwn cyclic -l daaa` returns 12 since there were 12 characters before `daaa` appeared).

If you feed a cyclic pattern of reasonable length into the program while it is running in a debugger such as `gdb`, when it segfaults `gdb` will tell you exactly which address it segfaulted at, which you can then look up in the cyclic pattern to find out how many bytes of padding you need to reach the return address.

#### end side note

Now we need to find the address of `print_flag`. Since this binary uses Position Independent Code, the exact address of `print_flag` changes every time the program runs. This means in order to get the address we need to leak some other address in memory and do some maths to find the address of `print_flag`, since the offsets between addresses in Position Independent Code will always stay the same.

Fortunately we have a memory leak - the `printf` function that contains it is a little complicated (if you're wondering what's in the format string, time for you to learn about ANSI Escape Codes), but the important part is that it's printing data from the set string `totally_a_num` added with our user-controlled number `a`.

#### side note: adding strings to numbers

The whole gimmick of this challenge is that in C, the string "-0.5" + the number 1 actually gives you the correct answer of "0.5", which seems very counter-intuitive at first until we realise what's going on.

In C, a string is just a pointer to a bunch of characters followed by a null terminator.
When we write `char *totally_a_num = "-0.5"`, the string itself is stored somewhere else and all that `totally_a_num` holds is the address of that string. If we print out `totally_a_num` as a string (i.e. `printf("%s\n", totally_a_num)`) the `printf` function just goes to the address stored in `totally_a_num` and prints out bytes until it finds a null terminator (byte with the value 0).

If we do `printf("%s\n", totally_a_num + 1)`, the exact same thing happens except the address that `printf` starts reading bytes from is incremented by 1, so we skip the first character of the string (the minus sign) and print from there. This "adding numbers and strings" trick therefore only works with this very specific combination of "-0.5" and 1.

#### end side note

Since we can control what number gets added to the `totally_a_num` pointer, we can get `printf` to leak memory from almost anywhere (within the limits of an integer).

If we open `gdb` and break right before `totally_a_num` is printed in that first `printf` call, we can inspect the stack to see what data would be valuable to leak. Example using regular `gdb`:

`gdb js` - launch `gdb` with the `js` program
  
`break *do_maths+54` - break just after the value of `totally_a_num` is pushed to the stack (this is discovered by reading the assembly code of the program)
  
`run` - run until the breakpoint is hit
  
`x $esp` - inspect the top value of the stack - this is the value of `totally_a_num`
  
`x/20x 0x56557046 + 2` - inspect 20 * 4 bytes of memory starting at the location of the string pointed to by `totally_a_num`. This pointer was found with the `x $esp` command. We are adding 2 to align the memory to the nearest multiple of 4, so that we can easily spot useful addresses in memory.

Now you can hit Enter repeatedly and `gdb` will continue to print out memory 80 bytes at a time, and will automatically move the starting address forward by 80 bytes so that you don't get the same bit of memory over and over again.
  

Continue searching through memory until you find a value that looks like the stack addresses you're seeing on the left (e.g. in this case values beginning with 0x5655). This may take a bit of searching, but eventually you'll find one (e.g. there's one that starts 7922 bytes after the string). In my case, the value there is `0x5655531c` and that's at the address `0x56558f38`.

The offset necessary to leak this value is `0x56558f38 - 0x56557046 = 0x1ef2` which is 7922 in decimal.

We also need to know how to find the address of `print_flag` from our leaked address. `print print_flag` in `gdb` tells us the address of `print_flag` in this instance - `0x56556209`. Therefore we will need to add `0x56556209 - 0x5655531c = 0xeed` to the leaked address.

See [the solve script](./solve.py) for the implementation of this exploit!

### Flag
`SKYLIGHT{c_may_b3_vuLn3rabL3_but_at_L3a5t_it_has_typ3s}`
</details>
