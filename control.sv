module control #(BITS=8)(
    input  wire [BITS-1:0] i_opcode,
    input  wire i_clk,
    input  wire i_acc_zero,

    output wire o_ld_mdr,
    output wire o_ld_mar,
    output wire o_ld_pc,
    output wire o_ld_acc,
    
    output wire o_mux_ir_p1,
    output wire o_mux_mdr_alur,
    output wire o_mux_pc_ird,
    
    output wire o_alu_ctrl
);
    
reg [2:0] fetch_state; //MX_(PC)_IDR, LD_MAR, LD_MDR, LD_IR
reg [1:0] inc_state; //MX_IR_(P1), LD_PC
reg [2:0] overall_state; // fetch inst, exec, inc pc

initial fetch_state = 0;
initial inc_state = 0;
initial overall_state = 0;

endmodule