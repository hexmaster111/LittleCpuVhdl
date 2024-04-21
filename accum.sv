module accum #(parameter BITS=8)
(
    input  wire             i_ld,
    input  wire [BITS-1:0]  i_data,
    output wire [BITS-1:0]  o_data,
    output wire             o_zero
);

reg [BITS-1:0] value;

initial value = 0;

always_latch begin
    if(i_ld) begin
        assign value = i_data;
    end
end

assign o_zero = (value == 0) ? 1 : 0;
assign o_data = value;
    
endmodule
