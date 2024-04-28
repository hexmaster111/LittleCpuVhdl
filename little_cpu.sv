module little_cpu(
    input wire i_clk,
    input wire i_rst
);


control ctrl(
    i_opcode(), //[3:0]
    i_clk(),
    i_rst(),
    i_acc_zero(),

    o_ld_mdr(),
    o_ld_mar(),
    o_ld_pc(),
    o_ld_acc(),
    o_ld_ir(),
    
    /*on mux, 0 = first*/
    o_mux_ir_p1(),
    o_mux_mdr_alur(),
    o_mux_pc_ird(),
    o_alu_ctrl()
);

register #(16) inst_reg ( 
    i_ld(),
    i_data(),
    o_data()
);

p1 pc_plus_one ( 
    in(),
    out()
);

mux_2 mx_p1_inst_rg ( 
    i_ab_sw(),
    i_a(),
    i_b(),
    o_out()
);

register #(8)prog_ctr (
    i_ld(),
    i_data(),
    o_data()
 );

mux_2 mx_ir_pc (
    i_ab_sw(),
    i_a(),
    i_b(),
    o_out()
 );
 
register mem_addr_reg ( 
    i_ld(),
    i_data(),
    o_data()
);
memory mem ( 
    i_rw(),
    i_data(),
    i_addr(),
    o_data()
);

register mem_data_reg (
    i_ld(),
    i_data(),
    o_data()
 );

mux_2 mx_alu_ir ( 
    i_ab_sw(),
    i_a(),
    i_b(),
    o_out()
);

alu alu ( 
    i_op(),
    i_l(),
    i_r(),
    o_out()
);

accum accum (
    i_ld(),
    i_data(),
    o_data(),
    o_zero()
);
  
endmodule;
