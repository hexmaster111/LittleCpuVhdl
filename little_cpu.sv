module little_cpu #(parameter BITS=16)(
    input wire i_clk,
    input wire i_rst
);

wire [BITS-1:0] mdr_reg_out,
/* verilator lint_off UNUSED */
inst_reg_out;
/* verilator lint_on UNUSED */

/* verilator lint_off UNOPTFLAT */
wire [7:0]  pc_mx_wire, pc_out, accum_out;
/* verilator lint_on UNOPTFLAT */
wire acc_zero;

wire ld_mdr, ld_mar, ld_pc, ld_acc, ld_ir, mem_rw;

wire mx_pc_ab, mx_mar_ab, mx_accum_ab;

wire alu_ctrl;



control ctrl (
    .i_opcode   (inst_reg_out[15:8]), //[3:0]
    .i_clk      (i_clk),
    .i_rst      (i_rst),
    .i_acc_zero (acc_zero),

    .o_mem_rw   (mem_rw),

    .o_ld_mdr   (ld_mdr),
    .o_ld_mar   (ld_mar),
    .o_ld_pc    (ld_pc),
    .o_ld_acc   (ld_acc),
    .o_ld_ir    (ld_ir),
    
    /*on mux, 0 = first*/
    .o_mux_PC_to_ir_p1      (mx_pc_ab),
    .o_mux_ACC_to_mdr_alur  (mx_accum_ab),
    .o_mux_MAR_to_pc_ird    (mx_mar_ab),
    .o_alu_ctrl             (alu_ctrl)
);

register #(BITS) inst_reg ( 
    .i_clk   (i_clk),
    .i_ld   (ld_ir),
    .i_data (mdr_reg_out),
    .o_data (inst_reg_out)
);

wire [7:0] p1_mx_wire;

p1 pc_plus_one ( 
    .in     (pc_out),
    .out    (p1_mx_wire)
);

mux_2 mx_p1_inst_rg ( 
    .i_ab_sw (mx_pc_ab),
    .i_a     (p1_mx_wire),
    .i_b     (inst_reg_out[BITS-2:7]),
    .o_out   (pc_mx_wire)
);

register #(8)prog_ctr (    
    .i_clk   (i_clk),        
    .i_ld    (ld_pc),
    .i_data  (pc_mx_wire),
    .o_data  (pc_out)
 );

wire [7:0] mx_ir_pc_mem_wire, mar_to_mem_module_wire;

wire [BITS-1:0] mem_to_mdr_reg_wire;

//#mar
mux_2 mx_ir_pc (
    .i_ab_sw (mx_mar_ab),
    .i_a     (inst_reg_out[BITS-2:7]),
    .i_b     (pc_out),
    .o_out   (mx_ir_pc_mem_wire)
 );
 
register mem_addr_reg ( 
    .i_clk  (i_clk),
    .i_ld   (ld_mar),
    .i_data (mx_ir_pc_mem_wire),
    .o_data (mar_to_mem_module_wire)
);

// memory mem ( 
dbg_tbctrled_mem mem ( 
    .i_clk  (i_clk),
    .i_rw   (mem_rw),
    // this truncates down so we only set the data side of the values from the alu
    /* verilator lint_off WIDTH */
    .i_data (accum_out), 
    /* verilator lint_on WIDTH */
    .i_addr (mar_to_mem_module_wire),
    .o_data (mem_to_mdr_reg_wire)
);


register#(BITS) mem_data_reg (
    .i_clk   (i_clk),
    .i_ld(ld_mdr),
    .i_data(mem_to_mdr_reg_wire),
    .o_data(mdr_reg_out)
 );
/* verilator lint_off UNOPTFLAT */
wire [7:0] mx_to_accum_wire, alu_out_wire;
/* verilator lint_on UNOPTFLAT */

mux_2 mx_alur_mdr ( 
    .i_ab_sw(mx_accum_ab),
    .i_a(alu_out_wire),
    .i_b(mdr_reg_out[7:0]), 
    .o_out(mx_to_accum_wire)
);

alu alu ( 
    .i_op(alu_ctrl),
    .i_l(mdr_reg_out[7:0]), 
    .i_r(accum_out),
    .o_out(alu_out_wire)
);

accum accum (
    .i_clk(i_clk),
    .i_ld(ld_acc),
    .i_data(mx_to_accum_wire),
    .o_data(accum_out),
    .o_zero(acc_zero)
);
  
endmodule;
