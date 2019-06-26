# A Compiler from C to VerySimpleCPU

The compiler is adapted from Peter Sestoft's MicroC.

## Object Code

The compiler produces a VerySimpleCPU object code.
The object is structured as below:

```
   +-------------------+
0: | BZJi "globalinit" |
   |-------------------|
1: | Stack pointer     |------------------+
   |-------------------|                  |
2: | Base pointer      |----------------+ |
   |-------------------|                | |
3: | Zero              |                | |
   |-------------------|                | |
4: | NegativeOne       |                | |
   |-------------------|                | |
5: | VSCPU Special     |                | |
   |-------------------|                | |
6: | VSCPU Special     |                | |
   |-------------------|                | |
7: | VSCPU Special     |                | |
   |-------------------|                | |
8: | VSCPU Special     |                | |
   |-------------------|                | |
9: | VSCPU Special     |                | |
   |-------------------|                | |
10:| VSCPU Special     |                | |
   |-------------------|                | |
11:| Scratch mem 1     |                | |
   |-------------------|                | |
12:| Scratch mem 2     |                | |
   |-------------------|                | |
13:| Scratch mem 3     |                | |
   |-------------------|                | |
14:| Scratch mem 4     |                | |
   |-------------------|                | |
15:| Scratch mem 5     |                | |
   |-------------------|                | |
16:| Scratch mem 6     |                | |
   |-------------------|                | |
17:| Global            |                | |
   | variables         |                | |
   |                   |                | |
   |                   |                | |
   |-------------------|: "globalinit"  | |
   | Code for          |                | |
   | initializing      |                | |
   | global vars       |                | |
   |                   |                | |
   |-------------------|                | |
   | BZJi "main"       |                | |
   |-------------------|: "mainreturn"  | |
   | Code for copying  |                | |
   | main's return val |                | |
   |-------------------|                | |
   | HALT              |                | |
   |-------------------|: "foo"         | |
   | Code for          |                | |
   | function foo      |                | |
   |-------------------|: "baz"         | |
   | Code for          |                | |
   | function baz      |                | |
   |                   |                | |
   |                   |                | |
   |                   |                | |
   |                   |                | |
   |-------------------|: "main"        | |
   | Code for          |                | |
   | function main     |                | |
   |                   |                | |
   |===================|                | |
   | Frame             |                | |
   | stack             |                | |
   |         .         |                | |
   |         .         |                | |
   |         .         |                | |
 --|-------------------|--              | |
   | return address    | caller's       | |
   |-------------------| AR             | |
   | old BP            |                | |
   |-------------------| <-----------+  | |
   | local vars        |             |  | |
   |                   |             |  | |
   |-------------------|             |  | |
   | temps             |             |  | |
   |                   |             |  | |
 --|-------------------|--           |  | |
   | return address    | callee's    |  | |
   |-------------------| AR          |  | |
   | old BP            |-------------+  | |
   |-------------------| <--------------+ |
   | local vars        |                  |
   |                   |                  |
   |-------------------|                  |
   | temps             |                  |
   |                   |                  |
   |                   |                  |
   |-------------------| <----------------+
   |                   |
```

The frame stack is a stack of function activation records (AR).
It grows and shrinks as new function calls are made or functions return.
In a function activation record (i.e. a single stack frame),
the following values are stored:

* The return address; i.e. which address to jump back when
  the active function finishes execution.
* Old BP: the address in the previous activation record
  where local data starts. This is used to restore the BP value
  when the function finishes execution.
* Local data: the data for local variables and temporaries.

Because each VerySimpleCPU program starts by setting PC to 0,
at address 0 we have an unconditional jump to
the code section where we set global variables.
At the end of global initialization, there is an unconditional jump
to the "main" function's address.

At addresses 1-12 we keep the stack pointer (SP), base pointer (BP), zero value, negative 1,
two VSCPU-specific cells,
and a few cells as "scratch memory":

* SP is the address of the top of the frame stack.
* BP is the base address of the current activation record.
* Zero always stores the value 0.
* NegativeOne always stores the value -1 (i.e. 2's complement of 1). Useful when decrementing values, especially the stack pointer.
* Bank and Black Hole are VerySimpleCPU-specific values to determine from/to which memory bank to read/write data.
* Scratch memory can be used freely to move data,
typically from/to the top of the stack.

CPUs or microprocessors usually have registers
dedicated for SP and BP, and sometimes for zero.
However, VerySimpleCPU does not have any registers (except for the PC).
So, we use fixed addresses in the memory for the PC, BP, and Zero,
and also we allocate two more slots to imitate general purpose registers.

Upon termination, the return value of the process (i.e. the value returned
by `main`) is placed in the `scratchMem1` cell. This is useful for
debugging purposes.
If `main` is declared as `void`,
the value left in `scratchMem1` is undefined
(but most typically it will be
the most recent value left on the stack).

NOTE: 
Allocating more cells for scratch memory may give some optimization opportunities because
scratch cells have fixed addresses whereas
local data have relative, and hence address calculation is needed
each time we need to access local data.
We will think about this in the future.