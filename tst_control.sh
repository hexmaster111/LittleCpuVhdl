#!/bin/bash
echo "### Verlating ###"
verilator --Wall --trace -cc control.sv --exe tb_control.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vcontrol.mk Vcontrol -j 4
echo "### SIMULATING ###"
./obj_dir/Vcontrol
