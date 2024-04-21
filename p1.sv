module p1 #(parameter BITS = 8) (
    input  wire [BITS-1:0] in,
    output wire [BITS-1:0] out
);
    assign out = in + 1;
endmodule
