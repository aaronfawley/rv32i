ADD adds rs1 and rs2                                                                                 code: 0000
SUB subtracts rs1 - rs2                                                                              code: 0001
AND performs bitwise and on rs1 and rs2                                                              code: 0010
OR performs bitwise OR on rs1 and rs2                                                                code: 0011
XOR performs bitwise xor on rs1 and rs2                                                              code: 0100
SLT performs signed comparison if rs1 < rs2 then returns 1                                           code: 0101
SLL slide left logically and vacated bits are 0's                                                    code: 0110
SRL slide right logically vacated high bits are 0's                                                  code: 0111
SRA slide right arithmetically so vacated signed bits are filled with copies of the original top bit code: 1000
SLTU performed unsigned comparison same return                                                       code: 1001