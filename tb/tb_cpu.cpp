#include "Vcpu.h"
#include "verilated.h"
#include <cstdio>

Vcpu* dut;
int failures = 0;
void tick(){
    dut->clk = 0; dut->eval();
    dut->clk = 1; dut->eval(); 
}



int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vcpu;

    dut->rst_n = 0;
    tick();

    dut->rst_n = 1;
    for (int i = 0; i < 6; i++) {
        printf("pc = %08x   result = %08x\n", dut->debug_pc, dut->debug_reg);
        tick();
        printf("pc = %08x   result = %08x\n", dut->debug_pc, dut->debug_reg);
    }



    dut->final();
    delete dut;
    return 0;
}