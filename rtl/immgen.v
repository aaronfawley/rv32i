module immgen (
input [31:0] instr,
input [2:0] sel,
output reg [31:0] out
);
always @(*) begin
    case(sel)
    3'b000: out = {{20{instr[31]}}, instr[31:20]}; //I-type
    3'b001: out = {{20{instr[31]}}, instr[31:25], instr[11:7]}; //S-type
    3'b010: out = {{19{instr[31]}}, instr[31], instr[7], instr[30:25], instr[11:8], 1'b0}; //B-type
    3'b011: out = {instr[31:12],12'b0}; //U-type
    3'b100: out = {{11{instr[31]}}, instr[31], instr[19:12], instr[20], instr[30:25], instr[24:21], 1'b0}; //J-type
    default:out = 32'b0;
    endcase 
end
  
endmodule
