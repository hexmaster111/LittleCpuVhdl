module memory #(parameter BITS=8, MEMADDRS=256) 
(
    input  wire              i_rw, //LOW READ, HIGH WRITE
    input  wire [BITS-1:0]   i_data,
    input  wire [BITS-1:0]   i_addr,
    output wire [BITS-1:0]   o_data
);

reg [BITS-1:0] mem [0:MEMADDRS-1];

always_latch begin
    if(i_rw) begin
        assign mem[i_addr] = i_data;    
    end
    
end


assign o_data = mem[i_addr];

endmodule
