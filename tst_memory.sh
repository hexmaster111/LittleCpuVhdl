#!/bin/bash
echo "### Verlating ###"
verilator --Wall --trace -cc memory.sv --exe tb_memory.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vmemory.mk Vmemory -j 4
echo "### SIMULATING ###"
./obj_dir/Vmemory
