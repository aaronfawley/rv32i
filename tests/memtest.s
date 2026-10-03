.section .text
.globl _start
_start:
    addi x1, x0, 42     # x1 = 42, the value to store
    addi x2, x0, 16     # x2 = 16, the address
    sw   x1, 0(x2)      # store x1 to memory[16]
    lw   x3, 0(x2)      # load it back into x3
    addi x4, x0, 7      # marker so you can see the program ran past
