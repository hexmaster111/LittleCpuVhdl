module little_cpu (
    input wire i_clk,
    input wire i_rst
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
