.section .text
.globl _start
_start:
    addi x1, x0, 5
    addi x2, x0, 10
    blt  x1, x2, t1       # 5 < 10, should branch
    addi x9, x0, 99       # skipped
t1: addi x3, x0, 1        # marker
    bge  x1, x2, t2       # 5 >= 10 false, should NOT branch
    addi x4, x0, 2        # should execute
t2: addi x5, x0, 3
    addi x6, x0, -1       # 0xFFFFFFFF
    bltu x6, x1, t3       # unsigned: huge < 5 is false, no branch
    addi x7, x0, 4        # should execute
t3: blt  x6, x1, t4       # signed: -1 < 5 is true, branch
    addi x8, x0, 88       # skipped
t4: addi x10, x0, 7       # final marker
