module memory #(parameter BITS=16, MEMADDRS=256) 
(
    input  wire              i_clk,
    input  wire              i_rw, //LOW READ, HIGH WRITE
    input  wire [BITS-1:0]   i_data,
    input  wire [7:0]        i_addr,
    output wire [BITS-1:0]   o_data
);

reg [BITS-1:0] regmem [0:MEMADDRS-1];


initial begin
    regmem[0] = 16'd0;
    regmem[1] = 16'd0;
    regmem[2] = 16'd0;
    regmem[3] = 16'd6490;
    regmem[4] = 16'd0;
    regmem[5] = 16'd0;
    regmem[6] = 16'd0;
    regmem[7] = 16'd0;
    regmem[8] = 16'd0;
    regmem[9] = 16'd0;
    regmem[10] = 16'd0;
    regmem[11] = 16'd0;
    regmem[12] = 16'd0;

end


always @(posedge i_clk) begin
    if(i_rw) begin
        regmem[i_addr] <= i_data;    
    end    
end 


assign o_data = regmem[i_addr];

endmodule
