/* verilator lint_off UNUSED */
/* verilator lint_off UNDRIVEN */
module dbg_tbctrled_mem #(parameter BITS=16, MEMADDRS=256) 
(
    input  wire              i_clk,
    input  wire              i_rw, //LOW READ, HIGH WRITE
    input  wire [BITS-1:0]   i_data,
    input  wire [7:0]        i_addr,
    output wire [BITS-1:0]   o_data
);


endmodule
