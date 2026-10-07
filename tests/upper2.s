.section .text
.globl _start
_start:
    lui   x1, 0x12345     # x1 = 0x12345000
    addi  x2, x1, 0x678   # x2 = 0x12345678
    auipc x3, 0x0         # x3 = PC of this instruction = 8
    addi  x4, x0, 7       # marker
