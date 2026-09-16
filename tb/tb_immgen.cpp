#include "Vimmgen.h"
#include "verilated.h"
#include <cstdio>

Vimmgen* dut;
int failures = 0;

void check(uint32_t input, uint32_t expected, uint8_t selector, const char* name) {
    dut->sel = selector;
    dut-> instr = input;
    dut->eval();
    if (dut->out != expected){
        printf("FAIL %s:  got %08x expected %08x\n",
        name, dut->out, expected);
        failures++;
        } else {
            printf("pass%s\n", name);
    }
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vimmgen;
    check(0x00500093, 0x00000005, 0, "I-Type positive");
    check(0xFFF00093, 0xFFFFFFFF, 0, "I-Type negative");
    check(0x123450B7, 0x12345000, 3, "U-Type");
    printf("%d failures\n", failures);

    dut->final();
    delete dut;
    return failures > 0 ? 1 : 0;
}