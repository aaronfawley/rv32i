module dmem(
input clk,
input [31:0] addr,
input [31:0] write_data,
input mem_write,
output [31:0] read_data
);
reg [31:0] mem [0:255];
assign read_data = mem[addr[9:2]];
always @(posedge clk) begin
    if (mem_write) begin
        mem[addr[9:2]] <= write_data;
    end

end
endmodule
