module cpu(
    input clk,
    input rst_n,
    output [31:0] debug_pc,
    output [31:0] debug_reg
);
wire [31:0] pc_out;
wire [31:0] instruction;
wire [31:0] rs1_data, rs2_data;
wire [31:0] imm;
wire [31:0] alu_result;
wire [31:0] alu_b = alu_src ? imm : rs2_data;
wire [31:0] write_back = mem_to_reg ? mem_read_data : alu_result;
wire [3:0] alu_op;
wire [31:0] mem_read_data;
wire [31:0] br_targ = pc_out + imm;
wire [2:0] imm_sel;
wire take_branch = branch && zero_flag;
wire       reg_write, alu_src, mem_read, mem_write, mem_to_reg, branch;
wire        zero_flag;
assign debug_pc = pc_out;
assign debug_reg = alu_result;
pc pc_inst (
    .clk        (clk),
    .rst_n      (rst_n),
    .br_targ    (br_targ),
    .take_branch(take_branch),
    .pc_out     (pc_out)
);

imem imem_inst(
    .addr       (pc_out),
    .imem_out   (instruction)
);

regfile regfile_inst(
    .clk        (clk),
    .rs1_data   (rs1_data),
    .rs2_data   (rs2_data),
    .rs1_addr   (instruction[19:15]),
    .rs2_addr   (instruction[24:20]),
    .write_addr (instruction[11:7]),
    .write_data (write_back),
    .write_en   (reg_write)
);

immgen immgen_inst(
    .instr  (instruction),
    .sel    (imm_sel),
    .out    (imm)
);

decoder decoder_inst(
    .inst       (instruction),
    .alu_op     (alu_op),
    .alu_src    (alu_src),
    .imm_sel    (imm_sel),
    .reg_write  (reg_write),
    .mem_read   (mem_read),
    .mem_write  (mem_write),
    .mem_to_reg (mem_to_reg),
    .branch     (branch)
);

alu alu_inst(
    .a          (rs1_data),
    .b          (alu_b),
    .alu_op     (alu_op),
    .out        (alu_result),
    .zero_flag  (zero_flag)
);

dmem dmem_inst(
    .clk    (clk),
    .addr   (alu_result),
    .write_data (rs2_data),
    .mem_write (mem_write),
    .read_data (mem_read_data)
);

endmodule
