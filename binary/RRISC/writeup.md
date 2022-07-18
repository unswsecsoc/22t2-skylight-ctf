# RRISC (Really Reduced Instruction Set Computer)

## Authors
- @ItsIronicIInsist

## Category
- Binary Exploit

## Description
With so few instructions, what could even go wrong?

## Difficulty
- Hard

## Points
120

## Hints
1. What's the key difference between alloca and malloc?
2. There's little difference between 0xffffffffffffffff and -1 to a CPU.

## Files
- filename: description

## Solution
<details>
<summary>Spoiler</summary>

### Idea
This challenge interacted with the user in a unique format - namely the brainfuck language - rather than something more traditional to CTFs.
THis would emphasise the importance of tooling/helper functons when developing complicated exploits.
The bug itself is in regards to the handling of the memory index and the '<' command.

### Walkthrough
1. THe program takes in a program coded as 'brainfuck'
2. Then loops through, executing each instruction. There are only 8 different commands
3. The main ones of interest are the '[', ']', '>', and '<' commands
4. THe brackets are a weirdly implemented stack that uses alloca (think malloc, but it allocates to the stack)
5. The arrows control the index into the memory array, and are of interest because we want to write out of bounds.
6. The '>' has proper safety checks, but the '<' command doesnt.
7. The if conditional in the '<' command handler may lead people to believe its safe, but because the mem_index variable is unsigned,
8. Decrementing from 0 leads to a large unsigned number, not a negative number.
9. However, the difference between a large unsigned number and a negative number when indexing into the memory array is non-existant, because of how addition works in CPUs
10. First, we aim to defeat ASLR. In the solve scrpt, we have two '[' commands to get a stack address onto the stack. We read that out, then notice a libc address further back, and read that out too.
11. Next, we want a way to write after the array (In the direction of '>'), and thus must overcome the safety checks for its command
12. This is where the bracket-stack comes in. We can write the current program index whenever we push a bracket onto the stack. If we could forge a stack-entry pointing to mem_index, we could write the program index to mem_index 
13. In our exploit, we overwrite the cur_bracket variables bottom 4 bytes to point to mem_index, then a '[' causes the write to occur
14. All thats left is to use '<' to traverse the stack until we get to the saved instruction-pointer for emulate_program. With the libc leak, we can overwrite it to the address of a oneshot_gadget. Then, when the program finishes, we have shell.

### Flag
`SKYLIGHT{irr3duc1bly_b4d_c0de}`
</details>
