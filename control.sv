module control #(BITS=8)(
    input  wire [BITS-1:0] i_opcode,
    input  wire i_clk,
    input  wire i_acc_zero,

    output wire o_ld_mdr,
    output wire o_ld_mar,
    output wire o_ld_pc,
    output wire o_ld_acc,
    output wire o_alu_ctrl,
    output wire o_mux_ir_p1,
    output wire o_mux_mdr_alur,
    output wire o_mux_pc_ird
);
    



endmodule