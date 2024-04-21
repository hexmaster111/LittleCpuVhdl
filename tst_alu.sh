#!/bin/bash
echo "### Verlating ###"
verilator --Wall --trace -cc alu.sv --exe tb_alu.cpp
echo "### BUILDING ###"
make -C obj_dir -f Valu.mk Valu -j 4
echo "### SIMULATING ###"
./obj_dir/Valu
