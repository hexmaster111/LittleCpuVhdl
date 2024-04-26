#!/bin/bash
set -e
echo "### Verlating ###"
verilator --Wall --trace -cc control.v --exe tb_control.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vcontrol.mk Vcontrol -j 4
echo "### SIMULATING ###"
./obj_dir/Vcontrol 
