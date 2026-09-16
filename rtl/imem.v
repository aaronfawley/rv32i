module imem(
input [31:0] addr,
output [31:0] imem_out
);
reg [31:0] mem [0:255];

initial begin
    $readmemh("tests/program.hex", mem);
end

assign imem_out = mem[addr[9:2]];
endmodule
