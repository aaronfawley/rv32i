#include "Vimem.h"
#include "verilated.h"
#include <cstdio>

Vimem* dut;
int failures = 0;

void check_imem(uint32_t addr, uint32_t expected, const char* name) {
    dut->addr = addr;
    dut->eval();
    if (dut->imem_out != expected){
        printf("Failed %s, got %08x, expected %08x.\n", name, dut->imem_out, expected);
        failures++;
    } else {
        printf("Success.\n");
    }
}

int  main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vimem;
    printf("%d failures\n", failures);

    dut->final();
    delete dut;
    return failures > 0 ? 1 : 0;
}