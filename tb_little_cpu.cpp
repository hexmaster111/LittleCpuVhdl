#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vlittle_cpu.h"

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main(int argc, char **argv, char **env)
{
    srand(time(NULL));
    Verilated::commandArgs(argc, argv);
    Vlittle_cpu *dut = new Vlittle_cpu;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("wv_little_cpu.vcd");

    while (sim_time < MAX_SIM_TIME)
    {

        dut->i_rst = 0;

        if (sim_time <= VERIF_START_TIME)
        {
            dut->i_rst = 0;
        }

        dut->i_clk ^= 1;
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
