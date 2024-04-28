module little_cpu #(parameter BITS=16)(
    input wire i_clk,
    input wire i_rst
);

wire [BITS-1:0] mdr_reg_out, inst_reg_out;
wire [7:0] alu_o;
wire acc_zero_o;

wire ld_mdr, ld_mar, ld_pc, ld_acc, ld_ir;

wire mx_pc_ab, mx_mar_ab, mx_accum_ab;

wire alu_ctrl;

control ctrl(
    .i_opcode   (inst_reg_out[7:0]), //[3:0]
    .i_clk      (i_clk),
    .i_rst      (i_rst),
    .i_acc_zero (acc_zero_o),

    .o_ld_mdr   (ld_mdr),
    .o_ld_mar   (ld_mar),
    .o_ld_pc    (ld_pc),
    .o_ld_acc   (ld_acc),
    .o_ld_ir    (ld_ir),
    
    /*on mux, 0 = first*/
    .o_mux_ir_p1    (mx_pc_ab),
    .o_mux_mdr_alur (mx_accum_ab),
    .o_mux_pc_ird   (mx_mar_ab),
    .o_alu_ctrl     (alu_ctrl)
);

register #(BITS) inst_reg ( 
    .i_ld(ld_ir),
    .i_data(acc_zero_o),
    .o_data(inst_reg_out)
);

p1 pc_plus_one ( 
    .in(),
    .out()
);

mux_2 mx_p1_inst_rg ( 
    .i_ab_sw(),
    .i_a(),
    .i_b(),
    .o_out()
);

register #(8)prog_ctr (
    .i_ld(),
    .i_data(),
    .o_data()
 );

mux_2 mx_ir_pc (
    .i_ab_sw(),
    .i_a(),
    .i_b(),
    .o_out()
 );
 
register mem_addr_reg ( 
    .i_ld(),
    .i_data(),
    .o_data()
);
memory mem ( 
    .i_rw(),
    .i_data(),
    .i_addr(),
    .o_data(mdr_reg_out)
);

register mem_data_reg (
    .i_ld(),
    .i_data(),
    .o_data()
 );

mux_2 mx_alu_ir ( 
    .i_ab_sw(),
    .i_a(),
    .i_b(),
    .o_out()
);

alu alu ( 
    .i_op(alu_ctrl),
    .i_l(),
    .i_r(),
    .o_out(alu_o)
);

accum accum (
    .i_ld(),
    .i_data(),
    .o_data(),
    .o_zero()
);
  
endmodule;
