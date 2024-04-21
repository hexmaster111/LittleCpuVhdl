#!/bin/bash
echo "### Verlating ###"
verilator --Wall --trace -cc mux_2.sv --exe tb_mux_2.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vmux_2.mk Vmux_2 -j 4
echo "### SIMULATING ###"
./obj_dir/Vmux_2
