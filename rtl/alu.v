module alu(
input [31:0] a,
input [31:0] b,
input [3:0] alu_op,
output reg [31:0] out,
output zero_flag
);
always @(*) begin
case(alu_op) 
    4'b0000: out = a + b;
    4'b0001: out = a - b;
    4'b0010: out = a & b;
    4'b0011: out = a | b;
    4'b0100: out = a ^ b;  
    4'b0101: out = {31'b0, $signed(a) < $signed(b)};
    4'b0110: out = a << b[4:0]; 
    4'b0111: out = a >> b[4:0];
    4'b1000: out = $signed(a) >>> b[4:0];
    4'b1001: out = {31'b0, a < b};
    default: out = 32'bx;
endcase
assign zero_flag = (out == 32'b0);
end
endmodule
