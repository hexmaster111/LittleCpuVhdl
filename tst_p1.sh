#!/bin/bash
echo "### Verlating ###"
verilator --Wall --trace -cc p1.sv --exe tb_p1.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vp1.mk Vp1 -j 4
echo "### SIMULATING ###"
./obj_dir/Vp1
