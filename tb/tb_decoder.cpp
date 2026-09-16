#include "Vdecoder.h"
#include "verilated.h"
#include <cstdio>

Vdecoder* dut;
int failures = 0;

void check_sig (uint8_t got, uint8_t expected, const char* name) {
    
    if (got != expected){
        printf("FAIL %s:  got %08x expected %08x\n",
        name, got, expected);
        failures++;
        } else {
            printf("passed %s\n", name);
    }
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vdecoder;

    dut-> inst = 0x00500093;
    dut->eval();
    check_sig(dut-> reg_write,  1, "addi reg_write");
    check_sig(dut-> alu_src,    1, "addi alu_src");
    check_sig(dut->alu_op,      0, "addi alu_op");
    check_sig(dut->mem_write,   0, "addi mem_write");
    check_sig(dut->branch,      0, "addi branch");

    dut-> inst = 0x002081b3;
    dut->eval();
    check_sig(dut-> reg_write,  1, "add reg_write");
    check_sig(dut-> alu_src,    0, "add alu_src");
    check_sig(dut->alu_op,      0, "add alu_op");
    check_sig(dut->mem_write,   0, "add mem_write");
    check_sig(dut->branch,      0, "add branch");


    dut-> inst = 0x00000003;
    dut->eval();
    check_sig(dut-> reg_write,  1, "lw reg_write");
    check_sig(dut-> alu_src,    1, "lw alu_src");
    check_sig(dut->alu_op,      0, "lw alu_op");
    check_sig(dut->mem_write,   0, "lw mem_write");
    check_sig(dut->branch,      0, "lw branch");

    dut-> inst = 0x00000023;
    dut->eval();
    check_sig(dut-> reg_write,  0, "sw reg_write");
    check_sig(dut-> alu_src,    1, "sw alu_src");
    check_sig(dut->alu_op,      0, "sw alu_op");
    check_sig(dut->mem_write,   1, "sw mem_write");
    check_sig(dut->branch,      0, "sw branch");

    dut-> inst = 0x00000063;
    dut->eval();
    check_sig(dut-> reg_write,  0, "beq reg_write");
    check_sig(dut-> alu_src,    0, "beq alu_src");
    check_sig(dut->alu_op,      1, "beq alu_op");
    check_sig(dut->mem_write,   0, "beq mem_write");
    check_sig(dut->branch,      1, "beq branch");
    
    dut-> inst = 0x00000000;
    dut->eval();
    check_sig(dut-> reg_write,  0, "default reg_write");
    check_sig(dut-> alu_src,    0, "default alu_src");
    check_sig(dut->alu_op,      0, "default alu_op");
    check_sig(dut->mem_write,   0, "default mem_write");
    check_sig(dut->branch,      0, "default branch");
    
    printf("%d failures\n", failures);

    dut->final();

    delete dut;
    return failures > 0 ? 1 : 0;
}