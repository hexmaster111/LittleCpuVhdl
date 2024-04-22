#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vaccum.h"

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main(int argc, char **argv, char **env)
{
    srand(time(NULL));
    Verilated::commandArgs(argc, argv);
    Vaccum *dut = new Vaccum;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("wv_accum.vcd");

    while (sim_time < MAX_SIM_TIME)
    {
        dut->i_data = 0x69;
        dut->i_ld = 0;

        if (sim_time > 15)
            dut->i_data = 0x6A;

        if (sim_time > 30)
            dut->i_ld = 1;
        if (sim_time > 31)
            dut->i_ld = 0;

        if (sim_time > 33)
            dut->i_data = 0xFF;

        if (sim_time > 35)
            dut->i_ld = 1;
        if (sim_time > 36)
            dut->i_ld = 0;
        if (sim_time > 37)
            dut->i_data = 0xF2;

        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
