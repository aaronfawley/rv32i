.section .text
.globl _start
_start:
    beq  x1, x2, target
    bne  x1, x2, target
    blt  x1, x2, target
    bge  x1, x2, target
    bltu x1, x2, target
    bgeu x1, x2, target
target:
    addi x3, x0, 1
