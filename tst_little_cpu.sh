#!/bin/bash
set -e
echo "### Verlating ###"
verilator --prof-cfuncs -CFLAGS -DVL_DEBUG --Wall --trace -cc little_cpu.sv --exe tb_little_cpu.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vlittle_cpu.mk Vlittle_cpu -j 4
echo "### SIMULATING ###"
./obj_dir/Vlittle_cpu
