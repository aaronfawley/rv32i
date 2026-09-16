#include "Valu.h"
#include "verilated.h"
#include <cstdio>

const uint8_t ALU_ADD = 0;
const uint8_t ALU_SUB = 1;
const uint8_t ALU_AND = 2;
const uint8_t ALU_OR  = 3;
const uint8_t ALU_XOR = 4;
const uint8_t ALU_SLT = 5;
const uint8_t ALU_SLL = 6;
const uint8_t ALU_SRL = 7;
const uint8_t ALU_SRA = 8;
const uint8_t ALU_SLTU = 9;
Valu* dut;
int failures = 0;

void check(uint32_t a, uint32_t b, uint8_t op, uint32_t expected, const char* name) {
    dut->a = a;
    dut->b = b;
    dut->alu_op = op;
    dut->eval();
    if (dut->out != expected){
        printf("FAIL %s: a=%08x b=%08x got %08x expected %08x\n",
        name, a, b, dut->out, expected);
        failures++;
        } else {
            printf("pass%s\n", name);
    }
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Valu;

    check(7, 5, ALU_ADD, 12, "add");
    check(50,1, ALU_SUB, 49, "sub");
    check(0xF0F0F0F0, 0x0FF00FF0, ALU_AND, 0x00F000F0,  "and");
    check(0xF0F0F0F0, 0x0FF00FF0, ALU_OR, 0xFFF0FFF0, "or");
    check(0xF0F0F0F0, 0x0FF00FF0, ALU_XOR, 0xFF00FF00, "xor");
    check(0xFFFFFFFF, 1, ALU_SLT, 1, "slt -1 < 1");
    check(0xFFFFFFFF, 1, ALU_SLTU, 0, "sltu huge > 1");
    check(0x80000000, 4, ALU_SRL, 0x08000000, "srl sign bit");
    check(0x80000000, 4, ALU_SRA, 0xF8000000, "sra sign bit");
    check(0x00000010, 33, ALU_SRL, 0x00000008, "srl shift by 33");
    check(0xFFFFFFFF, 0, ALU_SRL, 0xFFFFFFFF, "srl by zero");
    check(0x00000001, 31, ALU_SLL, 0x80000000, "sll to top bit");
    check(0xFFFFFFFF, 1, ALU_SLTU, 0, "sltu huge > 1");
    check(0, 0, ALU_SLTU, 0, "sltu zero vs zero");

    printf("%d failures\n", failures);

    dut->final();
    delete dut;
    return failures > 0 ? 1 : 0;
}