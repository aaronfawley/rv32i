.section .text
.globl _start
_start:
	addi x1, x0, 5
	addi x2, x0, 5
	beq x1, x2, skip
	addi x3, x0, 99

skip:
	addi x4, x0, 7

