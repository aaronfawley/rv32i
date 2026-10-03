.section .text
.globl _start
_start:
    addi x1, x0, 0      # sum = 0
    addi x2, x0, 1      # i = 1
    addi x3, x0, 6      # limit
loop:
    beq  x2, x3, done   # exit when i reaches 6
    add  x1, x1, x2     # sum += i
    addi x2, x2, 1      # i++
    beq  x0, x0, loop   # always equal, so always jumps back
done:
    addi x4, x0, 99     # marker
