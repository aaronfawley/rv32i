module regfile (
    input clk,
    input [4:0] rs1_addr,
    output [31:0] rs1_data,
    input [4:0] rs2_addr,
    output [31:0] rs2_data,
    input [4:0] write_addr,
    input [31:0] write_data,
    input write_en
    );
reg [31:0] regs [31:0];
assign rs1_data = (rs1_addr == 0) ? 0 : regs[rs1_addr];
assign rs2_data = (rs2_addr == 0) ? 0 : regs[rs2_addr];

always @(posedge clk) begin
    if(write_en == 1 && write_addr != 0) begin
        regs[write_addr] <= write_data;
    end
end


endmodule
