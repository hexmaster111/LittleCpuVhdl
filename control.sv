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
    
localparam  //FS Fetch State
    FS_Inital  = 3'd0,
    FS_PcToMar = 3'd1,
    FS_LdMar   = 3'd2;

localparam  //OS Overall State
    OS_Fetch  = 3'd0,
    OS_Execute = 3'd1,
    OS_IncPc   = 3'd2;

reg [2:0] fetch_state;
reg [1:0] inc_state; //MX_IR_(P1), LD_PC
reg [2:0] overall_state;

reg [2:0] next_fetch_state;
reg [1:0] next_inc_state;
reg [2:0] next_overall_state;

initial fetch_state = 0;
initial inc_state = 0;
initial overall_state = 0;
initial next_fetch_state = 0;
initial next_inc_state = 0;
initial next_overall_state = 0;

always @(posedge i_clk) begin
    case (overall_state)
     /*fetch inst*/   0: begin
        // $display("fetch");        
        end
     /*exec  inst*/   1: begin
        // $display("exec");        
        end
     /*inc pc*/       2: begin
        // $display("inc");        
        end
        default: begin
            fetch_state <= 0;
            inc_state <= 0;
            overall_state <= 0;
        end 
    endcase
end

endmodule