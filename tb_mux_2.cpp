#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Vmux_2.h"

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main(int argc, char **argv, char **env)
{
    srand(time(NULL));
    Verilated::commandArgs(argc, argv);
    Vmux_2 *dut = new Vmux_2;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("wv_mux_2.vcd");

    while (sim_time < MAX_SIM_TIME)
    {

        dut->i_a = 100;
        dut->i_b = 24;
        dut->i_ab_sw = (sim_time > MAX_SIM_TIME / 2) ? 0 : 1;
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
