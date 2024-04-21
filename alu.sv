module alu #(parameter BITS=8) (
    input  wire            i_add,
    input  wire [BITS-1:0] i_l,
    input  wire [BITS-1:0] i_r,
    output reg  [BITS-1:0] o_out
);
    
always @(*) begin
    if (i_add) begin
        assign o_out = i_l + i_r;    
    end     
end

endmodule
