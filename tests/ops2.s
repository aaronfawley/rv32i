.section .text
.globl _start
_start:
    addi x1, x0, 12     # x1 = 12  (binary 1100)
    addi x2, x0, 10     # x2 = 10  (binary 1010)
    sub  x3, x1, x2     # 12 - 10  = 2
    and  x4, x1, x2     # 1100 & 1010 = 1000 = 8
    or   x5, x1, x2     # 1100 | 1010 = 1110 = 14
    xor  x6, x1, x2     # 1100 ^ 1010 = 0110 = 6
    addi x7, x0, 2      # shift amount
    sll  x8, x1, x7     # 12 << 2 = 48
    srl  x9, x1, x7     # 12 >> 2 = 3
    slt  x10, x2, x1    # 10 < 12 → 1
