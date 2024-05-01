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

    //   int mem_values[] = {
    //         /** | OP | FEDCBA90 |
    //          *  |ADD | 00000000 |
    //          *  |XOR | 00000001 |
    //          *
    //          *
    //          *
    //          *       opcode v data    */
    //         /*       FEDCBA9076543210 */
    //         /*00*/ 0b0000000000000100,
    //         /*01*/ 0b0000000000000101,
    //         /*02*/ 0b0000000000000000,
    //         /*03*/ 0b0000000000000000,
    //         /*04*/ 0b0000000000000000, // hit here
    //         /*05*/ 0b0000000000000000,
    //         /*06*/ 0b0000000000000000,
    //         /*07*/ 0b0000000000000000,
    //         /*08*/ 0b0000000000000000,
    //         /*09*/ 0b0000000000000000,
    //         /*0A*/ 0b0000000000000000,
    //         /*0B*/ 0b0000000000000000,
    //         /*0C*/ 0b0000000000000000,
    //         /*0D*/ 0b0000000000000000,
    //         /*0E*/ 0b0000000000000000,
    //         /*0F*/ 0b0000000000000000, // exec halts here
    //         /*10*/ 0b0000000000000000,
    //         /*11*/ 0b0000000000000000,
    //         /*12*/ 0b0000000000000000,
    //         /*13*/ 0b0000000000000000,
    //         /*14*/ 0b0000000000000000,
    //         /*15*/ 0b0000000000000000,
    //         /*16*/ 0b0000000000000000,
    //         /*17*/ 0b0000000000000000,
    //         /*18*/ 0b0000000000000000,
    //         /*19*/ 0b0000000000000000,
    //         /*1A*/ 0b0000000000000000,
    //         /*1B*/ 0b0000000000000000,
    //         /*1C*/ 0b0000000000000000,
    //         /*1D*/ 0b0000000000000000,
    //         /*1E*/ 0b0000000000000000,
    //         /*1F*/ 0b0000000000000000,
    //         /*20*/ 0b0000000000000000,
    //         /*21*/ 0b0000000000000000 //
    //     };
    // const int mem_values_len = sizeof(mem_values) / sizeof(int);

    while (sim_time < MAX_SIM_TIME)
    {

        // dut->i_rst = 0;

        // if (sim_time <= VERIF_START_TIME)
        // {
        //     dut->i_rst = 1;
        // }
        // u_char rw = dut->little_cpu__DOT__mem_rw;
        // SData iaddr = dut->little_cpu__DOT__mem_addr_reg__DOT__value;
        // SData *dataOut = &dut->little_cpu__DOT__mem_to_mdr_reg_wire;

        // if (iaddr >= mem_values_len)
        // {
        //     fprintf(stdout, "WARN! out of range iaddr! @ %lu\n", sim_time);
        //     *dataOut = 0;
        // }
        // else
        // {
        //     *dataOut = mem_values[iaddr];
        // }

        // fprintf(stdout, "RW: %-1d ADDR: %-5d OUT: %-5d @ %-5lu\n",
        //         rw,
        //         iaddr,
        //         *dataOut,
        //         sim_time);

        dut->i_clk ^= 1;
        dut->eval();
        m_trace->dump(sim_time);
        sim_time++;
    }

    m_trace->close();
    delete dut;
    exit(EXIT_SUCCESS);
}
