#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vmemory.h"

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main(int argc, char **argv, char **env)
{
    srand(time(NULL));
    Verilated::commandArgs(argc, argv);
    Vmemory *dut = new Vmemory;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("wv_memory.vcd");

    while (sim_time < MAX_SIM_TIME)
    {

        dut->i_addr = 0;
        dut->i_data = 0;
        dut->i_rw = 0;

        if (sim_time > 10)
        {
            dut->i_addr = 0x05;
            dut->i_data = 0xAF;
        }

        if (sim_time > 12)
            dut->i_rw = 1;
        if (sim_time > 13)
        {
            dut->i_rw = 0;
            dut->i_data = 0x00;
        }

        if (sim_time > 14)
            dut->i_addr = 0x05;

        if (sim_time > 15)
            dut->i_addr = 0x06;

        if (sim_time > 20)
            dut->i_addr = 0x05;

        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
