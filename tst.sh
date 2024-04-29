#!/bin/bash
set -e

echo "### Verlating $1 ###"
FILE_PATH=""
if test -f $1.sv; then
    FILE_PATH="$1.sv"
fi

if test -f $1.v; then
    FILE_PATH="$1.v"
fi

verilator --prof-cfuncs -CFLAGS -DVL_DEBUG --Wall --trace -cc $FILE_PATH --exe tb_$1.cpp
echo "### BUILDING $1 ###"
make -C obj_dir -f V$1.mk V$1 -j 4
echo "### SIMULATING $1 ###"
./obj_dir/V$1
