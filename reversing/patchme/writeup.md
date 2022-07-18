# patchme

## Authors
- [@joooooooooooooooooooooooooooooooooooosh](https://github.com/joooooooooooooooooooooooooooooooooooosh)

## Category
- reversing

## Description

this program has code to print the flag, but can you get to that code?


## Difficulty
- Medium

## Points
60

## Hints
1. You might want to look into a reversing tool that can patch programs, such as Binary Ninja (the demo version will be plenty)

## Files
- [patchme](./_ctfd/files/patchme): the binary you need to reverse engineer


## Solution
<details>
<summary>Spoiler</summary>

### Idea
You can use tools such as `gdb` or Binary Ninja to affect the flow of execution in a program however you like.

### Walkthrough

Upon downloading and inspecting the binary (e.g. by opening it in Binary Ninja) you should see that there is a `print_flag` function - and you are told that if you can get that function to execute it will print the flag. This isn't *quite* true, but it's mostly correct..

There are two main approaches to this problem.

#### Statically patching the binary

The first problem is calling `print_flag` in the first place - you can do this by editing one of the `puts` calls to call `print_flag` instead, e.g. by pressing `e` to edit a `puts` call when in Disassembly view.

By saving to a new file, you can create a modified version of the binary and try running it! However it won't work just yet.. if you run it the program immediately exists with an assertion failure.

An easy way to decipher program flow in assembly is in Binary Ninja's graph view. We can see in the graph view that there is a `jg` instruction which takes us to the assertion - we can modify this jump to never trigger the assert by right clicking the `jg` instruction and selecting `Patch -> Always Branch`. This turns the conditional jump instruction into an unconditional `jmp` that always triggers and never goes to the assert code.

Similarly, we want to change the `je` instruction to Never Jump, which converts it into a `nop` instruction so that the flag printing part of the code will always execute.

If we try running this new binary, we find that we now get a segfault :(

If we look at the first few instructions of the flag printing code, we can see there's an intentional `NULL` dereference which is what's causing our problem. If we simply get rid of those instructions with `Patch -> Convert to NOP` and then save + rerun the patched binary, it prints the flag!


#### Dynamically modifying execution

Using a tool like `gdb`, we can change the behaviour of a program at runtime. For example:
`gdb patchme` - launch `gdb` with our program
`break main`  - stop execution when we reach the `main` function
`run` - start the program
`jump print_flag` jump straight to the `print_flag` function and execute from there

However this doesn't immediately work due to the assertion + early return + `NULL` dereferences outlined in "Statically patching the binary".

We can fix this by simply jumping straight to the start of the flag printing code and skipping the problematic code earlier on in the function.

To find where the real flag printing code starts, either read the raw assembly with `disassemble print_flag` or read the assembly in something like Binary Ninja's graph view.

We can then find out the offset of the right instruction (`disassemble` in `gdb` tells us it's +76, if you were using Binary Ninja you'd have to do some maths (`0x11d1 - 0x1185`)).

We can't just `jump` straight to this code, since we need the start of `print_flag` to execute in order to set up the stack. Our sequence of instructions is then as follows:


`gdb patchme` - launch `gdb` with our program
  
`break main`  - stop execution when we reach the `main` function
  
`break print_flag` - stop execution when we reach the `print_flag` function
  
`run` - start the program
  
`jump print_flag` jump straight to the `print_flag` function and execute from there (this time hitting our breakpoint)
  
`next`
  
`next` - execute the two instructions necessary to set up `print_flag`'s stack frame properly
  
`jump *print_flag+76` - continue execution at the instruction at the address of print_flag + 76 (our flag printing code)
  


#### Approach number 3: reverse engineering the flag printing code

If you *really* wanted, you could ignore the patching part of this program and just try to figure out how the flag is being printed by reading and understanding the assembly code. However, this is *much* more effort than some simple static or dynamic patching.

### Flag
`SKYLIGHT{p4tch_aLL_th3_th1ng5}`
</details>
