`include "global.vh"

/* verilator lint_off UNUSED */
/* verilator lint_off UNDRIVEN */
module control (
    input  wire [7:0] i_opcode,
    input  wire i_clk,
    input  wire i_rst,
    input  wire i_acc_zero,

    output reg o_mem_rw,

    output reg o_ld_mdr,
    output reg o_ld_mar,
    output reg o_ld_pc,
    output reg o_ld_acc,
    output reg o_ld_ir,
    /*on mux, 0 = first*/
    output reg o_mux_PC_to_ir_p1, // 0 = ir
    output reg o_mux_ACC_to_mdr_alur, // 0 = mdr
    output reg o_mux_MAR_to_pc_ird,

    output reg o_alu_ctrl
);
    

localparam  //State
    S_Fetch_0    = 8'd0,
    S_Fetch_1    = 8'd1,
    S_Fetch_2    = 8'd2,
    S_Fetch_3    = 8'd3,
    S_Fetch_4    = 8'd4,
    
    S_Inc_0      = 8'd10,
    S_Inc_1      = 8'd11,

    S_Exe_Alu_0  = 8'd20,
    S_Exe_Alu_1  = 8'd21,
    S_Exe_Alu_2  = 8'd22,
    S_Exe_Alu_3  = 8'd23,
    S_Exe_Alu_4  = 8'd24;


reg [7:0] current_state, next_state;

initial begin
    current_state = S_Fetch_0;
end

always @(posedge i_clk) begin
    if(i_rst) current_state <= S_Fetch_0;
    else current_state <= next_state;
end

always @(*) begin
    next_state = current_state;

    case (current_state)
        S_Fetch_0:begin
           next_state = S_Fetch_1;
           o_ld_pc = 0;      //STOP PC LOAD FROM INC
           o_mux_PC_to_ir_p1 = 0;  //set PC
           
           o_mux_MAR_to_pc_ird = 0; //set MAR
        end

        S_Fetch_1:begin
           next_state = S_Fetch_2;
           o_ld_mar = 1;    
        end

        S_Fetch_2:begin
           next_state = S_Fetch_3;
           o_mux_MAR_to_pc_ird = 0;
           o_ld_mar = 0;
           o_ld_mdr = 1;
        end

        S_Fetch_3:begin
            next_state = S_Fetch_4;
            o_ld_mdr = 0;
            o_ld_ir = 1;
        end

        S_Fetch_4:begin
            o_ld_ir = 0;
            case (i_opcode)
                OP_add : next_state = S_Exe_Alu_0; 
                OP_xor : next_state = S_Exe_Alu_0;
                default: begin
                    $display("INVALID OPCODE! %d -- noop", i_opcode);
                    next_state = S_Inc_0;
                end
            endcase
        end

        S_Exe_Alu_0:begin 
            next_state = S_Exe_Alu_1;
            o_mux_MAR_to_pc_ird = 1;
        end
        S_Exe_Alu_1:begin 
            next_state = S_Exe_Alu_2;
            o_ld_mar = 1;
        end
        S_Exe_Alu_2:begin
            o_ld_mar = 0;
            o_ld_mdr = 1;

            case (i_opcode)
                OP_add : o_alu_ctrl = ALU_ADD;
                OP_xor : o_alu_ctrl = ALU_XOR;  
                default: o_alu_ctrl = ALU_ADD; 
            endcase
             
            o_mux_ACC_to_mdr_alur = 1;
            next_state = S_Exe_Alu_3;
            o_mux_MAR_to_pc_ird = 0;
        end
        S_Exe_Alu_3:begin 
            next_state = S_Exe_Alu_4;
            o_ld_mdr = 0;
            o_ld_acc = 1;
        end
        S_Exe_Alu_4:begin
            o_ld_acc = 0; 
            o_mux_ACC_to_mdr_alur = 0;
            next_state = S_Inc_0;
        end
        
    
        S_Inc_0:begin 
            next_state = S_Inc_1;
            o_mux_PC_to_ir_p1 = 1;
        end
        S_Inc_1:begin
            o_ld_pc = 1;
            next_state = S_Fetch_0;
        end

        default: next_state = S_Fetch_0;
    endcase
end


endmodule
