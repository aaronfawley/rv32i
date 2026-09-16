module pc (
input [31:0] br_targ,
input clk,
input rst_n,
input take_branch,
output reg [31:0] pc_out
);
always @(posedge clk) begin
    if (!rst_n) begin
        pc_out <= 32'd0;
    end else begin
        pc_out <= take_branch ? br_targ : pc_out + 4;
    end 
end


endmodule
