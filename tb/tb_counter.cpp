#include "Vcounter.h"
#include "verilated.h"
#include "verilated_vcd_c.h"

int main(int argc, char** argv) {
    Verilated::commandArgs(argc, argv);
    Verilated::traceEverOn(true);

    Vcounter* dut = new Vcounter;
    VerilatedVcdC* trace = new VerilatedVcdC;
    dut->trace(trace, 5);
    trace->open("dump.vcd");

    dut->rst_n = 0;
    for (int t = 0; t < 40; t++) {
        if (t == 4) dut->rst_n = 1;
        dut->clk = 0; dut->eval(); trace->dump(t * 10);
        dut->clk = 1; dut->eval(); trace->dump(t * 10 + 5);
    }

    trace->close();
    dut->final();
    printf("done, count = %d\n", dut->count);
    delete dut;
}
