/* verilator lint_off UNUSED */
/* verilator lint_off UNDRIVEN */
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
    

localparam  //OS Overall State
    OS_Fetch    = 3'd0,
    OS_Execute  = 3'd1,
    OS_IncPc    = 3'd2;

localparam  //FS Fetch State
    FS_Idle     = 3'd0,
    FS_PcToMar  = 3'd1,
    FS_LdMar    = 3'd2;

localparam // IS Incriment Pc State
    IS_Idle     = 3'd0,
    IS_IrToP1   = 3'd0,
    IS_LdPc     = 3'd1;

reg [2:0] fetch_state;
reg [1:0] inc_state;
reg [2:0] overall_state;

reg [2:0] next_fetch_state;
reg [1:0] next_inc_state;
reg [2:0] next_overall_state;

initial fetch_state = FS_PcToMar;
initial inc_state = 0;
initial overall_state = 0;
initial next_fetch_state = 0;
initial next_inc_state = 0;
initial next_overall_state = 0;

always @(posedge i_clk) begin
    $display("CLICK");
    case (overall_state)
     OS_Fetch: begin        
        case (fetch_state)
            FS_Idle : begin
                next_fetch_state <= FS_Idle;
                $display("FS_IDLE");
            end 
            FS_PcToMar: begin
                next_fetch_state <= FS_LdMar;
                next_inc_state <= IS_Idle;
                next_overall_state <= OS_Fetch;
                $display("FS_PcToMar");
            end 
            FS_LdMar: begin
                next_fetch_state <= FS_Idle;
                next_inc_state <= IS_Idle;
                next_overall_state <= OS_Execute;
                $display("FS_LdMar");
            end 
            default: next_fetch_state <= FS_Idle;
        endcase
        end
     OS_Execute: begin
        $display("exe");
        next_overall_state <= OS_IncPc;
        end
     OS_IncPc: begin
        case (inc_state)
            IS_Idle : begin
                next_inc_state <= IS_Idle;
                $display("IS_Idle");
            end
            IS_IrToP1: begin
                next_inc_state <= IS_LdPc;
                next_overall_state <= OS_IncPc;
                $display("IS_IrToP1");
            end
            IS_LdPc: begin
                next_inc_state <= IS_Idle;
                next_overall_state <= OS_Fetch;
                $display("IS_LdPc");
            end 
            default: next_inc_state <= IS_Idle;
        endcase
        end
        
        default: begin
            fetch_state <= 0;
            inc_state <= 0;
            overall_state <= 0;
        end 
    endcase

    fetch_state <= next_fetch_state;
    overall_state <= next_overall_state;
    inc_state <= next_inc_state;
end

endmodule