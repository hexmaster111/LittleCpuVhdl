#!/bin/bash
set -e
echo "### Verlating ###"
verilator --Wall --trace -cc register.sv --exe tb_register.cpp
echo "### BUILDING ###"
make -C obj_dir -f Vregister.mk Vregister -j 4
echo "### SIMULATING ###"
./obj_dir/Vregister