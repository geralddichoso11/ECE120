# Introduction to LC-3 assembly language

## Overview
In this lab, you will learn the LC-3 assembly language and debug a given program

## Introduction
**"Why do we have to do this when no one in the real world does it?"**
- This is a common sentiment expressed by students in almost all engineering courses, not just ECE 120
    - But how can you innovate as engineers when you don't even understand the problem
    - Ideas do not get created in a vacuum
- We understand that writing code in binary can be painful and small mistakes can trip you up
- However, it is incredibly important to understanding how the LC-3 works 
- It's important to understand that LC-3 is ***not*** a language, but an ISA
    - Languages like Python and C does not need to care *much* about the underlying hardware architecture, but LC-3 does
- Regardless, the good news is that we are done with writing binary code in **labs** for the rest of the semester. You will be working with the LC-3 assembly, a much more friendly way to program for LC-3


## What's the difference?
Here is the [example from lab9](../lab9/example.bin)
```
0011 0000 0000 0000
0101 010 011 1 00000
1001 010 010 1 11111
1111 0000 0010 0101
```

Do you have any idea what it does? Because I don't.

Binary language is not meant to be comprehensible to humans.

This is where assembly comes in, as the next level of abstraction.

Here is that exact same program in LC-3 assembly.

```
.ORIG x3000
AND R2, R2, R3
NOT R2, R2
HALT
.END
```

Notice how this is much more readable.

Refer to [appendix A of the LC-3 ISA](https://www.jmeiners.com/lc3-vm/supplies/lc3-isa.pdf) for a list of instructions in their syntaxes.

## Assembly directives
Other than being easily read, assembly language has a couple of powerful features that make life easy for the programmer.

### Labels
Calculating offsets for branches, loads, stores, etc is a pain and prone to errors. This is where labels come in.

Consider this simple assembly program.

```
    AND R1, R1, R1
    BRn SKIP
    NOT R1, R1
SKIP:
    [Rest of program]
```

The program inverts the content in R1 if it is non-negative.

Instead of specifying an offset, we use the `SKIP` label here and the assembler will automatically calculate the offset.

### Macros
Macros are powerful directives that saves time and effort when programming.

You have already seen two of them in [the example program in What's the difference](#whats-the-difference): `.ORIG` and `.END`

`.ORIG` is self-explanatory and appeared in previous labs

`.END` tells the assembler where the "end" of the assembly is, anything appearing after will be ignored

Here are some more macros:

`.FILL [value]` specifies `value` to be placed in memory at the macro's location, useful for constants

`.BLKW [value]` specifies `value` amount of empty memory addresses, useful for storing data

`.STRINGZ "[string]"` species `string` in ascii with a null terminator


## Compilation
Recall that you use `lc3convert` for binary files. For assembly files, you will instead use `lc3as`. 

It will also produce an `obj` file but also a `sym` (symbol) file that contains the memory location of the symbols.

## Assignment
We have provided partially completed [assembly program](./lab11.asm) with bugs. Your job is to fix the bugs.

The program will get the value to calculate the factorial of, which is at `x4000`, and store the factorial result in `x30FF`

Reminder to not assume the initial value of registers.

## Turn-in
- `lab11.asm`