module memory #(parameter BITS=16, MEMADDRS=256) 
(
    input  wire              i_clk,
    input  wire              i_rw, //LOW READ, HIGH WRITE
    input  wire [BITS-1:0]   i_data,
    input  wire [7:0]        i_addr,
    output wire [BITS-1:0]   o_data
);

reg [BITS-1:0] regmem [0:MEMADDRS-1];

              //       OP   V  DATA
initial begin //     FEDCBA9876543210
    regmem[00] = 16'b0000000010000001; //
    regmem[01] = 16'b0000000100000000;
    regmem[02] = 16'b0000010100000000; //jmp 0
    regmem[03] = 16'b0000000000000000;
    regmem[04] = 16'b0000000000000000;
    regmem[05] = 16'b0000000000000000;
    regmem[06] = 16'b0000000000000000;
    regmem[07] = 16'b0000000000000000;
    regmem[08] = 16'b0000000000000000;
    regmem[09] = 16'b0000000000000000;
    regmem[10] = 16'b0000000000000000;
    regmem[11] = 16'b0000000000000000;
    regmem[12] = 16'b0000000000000000;
    regmem[13] = 16'b0000000000000000;
    regmem[14] = 16'b0000000000000000;
    regmem[15] = 16'b0000000000000000;
    regmem[16] = 16'b0000000000000000;
    regmem[17] = 16'b0000000000000000;
    regmem[18] = 16'b0000000000000000;

end


always @(posedge i_clk) begin
    if(i_rw) begin
        regmem[i_addr] <= i_data;    
    end    
end 


assign o_data = regmem[i_addr];

endmodule
