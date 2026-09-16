#include "Vpc.h"
#include "verilated.h"
#include <cstdio>

Vpc* dut;
int failures = 0;

void check_pc(uint32_t expected, const char* name) {
    if (dut->pc_out != expected){
        printf("Fail %s, got %08x, expected %08x\n", name, dut->pc_out, expected);
        failures++;
    } else{
        printf("Succeeded at %s\n", name);
    }
}

int  main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vpc;
    dut->rst_n = 0;
    dut->clk = 0; dut->eval();
    dut->clk = 1; dut->eval();
    check_pc(0, "reset");

    dut->rst_n = 1;
    dut->take_branch = 0;
    dut->clk = 0; dut->eval();
    dut->clk = 1; dut->eval();
    check_pc(4, "first increment");

    dut->br_targ = 0x100;
    dut->take_branch = 1;
    dut->clk = 0; dut->eval();
    dut->clk = 1; dut->eval();
    check_pc(0x100, "branch taken");

    dut->take_branch = 0;
    dut->clk = 0; dut->eval();
    dut->clk = 1; dut->eval();
    check_pc(0x104, "resume from target");

    printf("%d failures\n", failures);

    dut->final();
    delete dut;
    return failures > 0 ? 1 : 0;
}