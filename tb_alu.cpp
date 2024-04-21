#include <stdlib.h>
#include <iostream>
#include <cstdlib>
#include <verilated.h>
#include <verilated_vcd_c.h>
#include "Valu.h"
#include "Valu___024root.h"

#define MAX_SIM_TIME 300
#define VERIF_START_TIME 7
vluint64_t sim_time = 0;
vluint64_t posedge_cnt = 0;

int main(int argc, char **argv, char **env)
{
    srand(time(NULL));
    Verilated::commandArgs(argc, argv);
    Valu *dut = new Valu;

    Verilated::traceEverOn(true);
    VerilatedVcdC *m_trace = new VerilatedVcdC;
    dut->trace(m_trace, 5);
    m_trace->open("wv_alu.vcd");

    while (sim_time < MAX_SIM_TIME)
    {

        dut->i_add = (sim_time >= 20) ? 1 : 0;

        if (sim_time >= 10)
        {
            dut->i_l = 2;
            dut->i_r = 10;
        }

        if (sim_time >= 30)
        {
            dut->i_l = 200;
            dut->i_r = 40;
        }

        if (sim_time >= 50)
        {
            dut->i_l = 5;
            dut->i_r = 4;
            dut->i_add = 0;
        }

        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
