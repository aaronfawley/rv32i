#include "Vregfile.h"
#include "verilated.h"
#include <cstdio>

Vregfile* dut;
int failures = 0;

void check_read(uint8_t addr, uint32_t testdata, const char* name) {
    dut->rs1_addr = addr;
    dut->eval();

    if (dut->rs1_data != testdata) {
        printf("Failed %s: got %08x, expected %08x, \n", name, dut->rs1_data, testdata);
        failures++;
    } else{
        printf("pass %s\n", name);
    }
}

void write_reg (uint8_t addr, uint32_t data){
    dut->write_addr = addr;
    dut->write_data = data;
    dut->write_en = 1;
    dut->clk = 0;
    dut->eval();
    dut->clk = 1;
    dut->eval();
    dut->write_en = 0;
}

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    dut = new Vregfile;
    write_reg(5,0xDEADBEEF);
    check_read(5, 0xDEADBEEF, "reading the written data");
    write_reg(0,0xAAAAAAAF);
    check_read(0, 0, "0th register should lways read 0");
    write_reg(21, 0xAAAAFFFF);
    check_read(21, 0xAAAAFFFF, "checking another register");
    printf("%d failures\n", failures);

    dut->final();
    delete dut;
    return failures > 0 ? 1 : 0;
}