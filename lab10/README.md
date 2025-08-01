# Programming in the LC-3 machine language
## Overview
In this lab, you will write a simple program in LC-3 binary code that adds numbers from two arrays.

## Specification
- Your program will start at `x3000` as indicated by [lab10.bin](./lab10.bin)
- There are 10 integers starting at `x3100`, inclusive, [array_10.bin](./array_10.bin)
- There is an unknown # of integers starting at `x3200`, inclusive, [array_x.bin](./array_x.bin)
    - The array of numbers is terminated by a -1, do not include this number in your summation
- Your program should:
    - Add all the **positive** integers from the array of 10 integers and store the result in address `x4000`
    - Add all the **negative** integers from the array of unknown # of integers and store the result in `x4001`

## How to put data in a bin file instead of instructions
Technically speaking, there are no differences between instructions and data in memory. 
Instructions is just a special type of data that gets processed on the processor.

In [example.bin](../lab9/example.bin) from lab9,
```
0101 010 011 1 00000    ; R2 <- R2 AND R3
```
How does it know if this piece of data in memory is an instruction, or just some other data?

What the processor executes is determined by the behavior of the PC. You can design your program so that the PC stays contained within a segment of memory, which will be your instructions.

You can then simply write the data in binary in the `array_*.bin`.

## How to run multiple bin
### lc3sim
After you have compiled the binary code, use the `file` command to add them to the simulator.

### lc3sim-tk
After you have compiled the binary code, use the `Browse` button on the bottom right to add them to the simulator.

**Note that adding a file changes the starting `PC` to that of the file, so make sure to add the `lab10` file last.**

## Suggestions
- It is highly recommended to write the program in a higher level abstraction first (C, Flowchart, RTL, etc.)
- Refer back to lab9 on how to use the simulator for debugging

## Turn-ins

- `lab10.bin`

The `array_*.bin` files will **not** be used in grading, they are for your own testing purposes
