    addi  x1, x0, -1
    addi  x5, x6, 2047
    lui   x7, 0xABCDE
    auipc x8, 0x1
    jal   x1, .+16
    beq   x2, x3, .+8
    lw    x9, -4(x10)
    sw    x11, 8(x12)
    slli  x13, x14, 5
    srai  x15, x16, 31
    add   x17, x18, x19
    sltiu x20, x21, -1
