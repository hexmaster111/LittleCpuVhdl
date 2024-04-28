module register #(parameter BITS = 8) (
    input  wire            i_ld, 
    input  wire [BITS-1:0] i_data, 
    output wire [BITS-1:0] o_data
);
/* verilator lint_off UNOPTFLAT */
reg [BITS-1:0] value;
/* verilator lint_on UNOPTFLAT */
initial value = 0;

always_ff begin
    if(i_ld) value = i_data;    
end    

assign o_data = value;

endmodule
