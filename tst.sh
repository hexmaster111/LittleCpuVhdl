#!/bin/bash
set -e

echo "### Verlating $1 ###"
verilator --prof-cfuncs -CFLAGS -DVL_DEBUG --Wall --trace -cc $1.sv --exe tb_$1.cpp
echo "### BUILDING $1 ###"
make -C obj_dir -f V$1.mk V$1 -j 4
echo "### SIMULATING $1 ###"
./obj_dir/V$1
