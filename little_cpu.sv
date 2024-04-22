module little_cpu #(parameter BITS=16)(
    input wire i_clk,
    input wire i_rst
);


control ctrl( 
    .i_opcode(), //8bit
    .i_clk(i_clk),
    .i_acc_zero(),
    .o_ld_mdr(),
    .o_ld_mar(),
    .o_ld_pc(),
    .o_ld_acc(),
    .o_alu_ctrl(),
    .o_mux_ir_p1(),
    .o_mux_mdr_alur(),
    .o_mux_pc_ird()
);

register #(BITS=16) inst_reg( );

p1       pc_plus_one        ( );

mux_2    mx_p1_inst_rg      ( );
register prog_ctr           ( );

mux_2    mx_ir_pc           ( );
register mem_addr_reg       ( );
memory   mem                ( );
register mem_data_reg       ( );

mux_2    mx_alu_ir          ( );
alu      alu                ( );
accum    accum              ( );
  
endmodule;
