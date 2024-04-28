module memory #(parameter BITS=8, MEMADDRS=256) 
(
    input  wire              i_rw, //LOW READ, HIGH WRITE
    input  wire [BITS-1:0]   i_data,
    input  wire [BITS-1:0]   i_addr,
    output wire [BITS-1:0]   o_data
);

reg [BITS-1:0] regmem [0:MEMADDRS-1];

always_latch begin
    if(i_rw) begin
        assign regmem[i_addr] = i_data;    
    end
    
end


assign o_data = regmem[i_addr];

endmodule
