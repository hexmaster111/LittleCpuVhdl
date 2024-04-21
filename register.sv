module register #(parameter BITS = 16) (
    input  wire            i_ld, 
    input  wire [BITS-1:0] i_data, 
    output wire [BITS-1:0] o_data
);

reg [BITS-1:0] value;

initial value <= 0;

always @(*) begin
    if(i_ld) value <= i_data;    
end    

assign o_data = value;

endmodule
