#!/bin/bash
echo "### Verlating ###"
verilator --Wall --trace -cc accum.sv --exe tb_accum.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vaccum.mk Vaccum -j 4
echo "### SIMULATING ###"
./obj_dir/Vaccum
