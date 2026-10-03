module decoder (
input [31:0] inst,
output reg [3:0] alu_op,
output reg [2:0] imm_sel,
output reg reg_write,
output reg alu_src, 
output reg mem_read,
output reg mem_write,
output reg mem_to_reg,
output reg branch
);
always @(*) begin 
    case (inst[6:0]) 
    7'b0010011: begin   
        //alu_op = 4'b0000;
        imm_sel = 3'b000;
        reg_write = 1'b1;
        alu_src   = 1'b1;
        mem_read  = 1'b0;
        mem_write = 1'b0;
        mem_to_reg= 1'b0;
        branch    = 1'b0;
    end

    7'b0110011: begin 
        imm_sel =  3'b000;
        reg_write  = 1'b1;
        alu_src    = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        mem_to_reg = 1'b0;
        branch     = 1'b0;
        case (inst[14:12])
        3'b000: alu_op = inst[30] ? 4'b0001 : 4'b0000; //add and sub
        3'b111: alu_op = 4'b0010; //and
        3'b110: alu_op = 4'b0011; //or
        3'b100: alu_op = 4'b0100; //xor
        3'b001: alu_op = 4'b0110; //sll
        3'b101: alu_op = inst[30] ? 4'b1000 : 4'b0111; //srl and sla
        3'b010: alu_op = 4'b0101; //slt
        3'b011: alu_op = 4'b1001; //sltu
        default: alu_op = 4'b0000;//default to add
        endcase
    end

    7'b0000011: begin     //lw
        alu_op  = 4'b0000;
        imm_sel =  3'b000;
        reg_write  = 1'b1;
        alu_src    = 1'b1;
        mem_read   = 1'b1;
        mem_write  = 1'b0;
        mem_to_reg = 1'b1;
        branch     = 1'b0;

    end

    7'b0100011: begin     //sw
        alu_op  = 4'b0000;
        imm_sel =  3'b001;
        reg_write  = 1'b0;
        alu_src    = 1'b1;
        mem_read   = 1'b0;
        mem_write  = 1'b1;
        mem_to_reg = 1'b0;
        branch     = 1'b0;
    end

    7'b1100011: begin     //beq
        alu_op  = 4'b0001;
        imm_sel =  3'b010;
        reg_write  = 1'b0;
        alu_src    = 1'b0;
        mem_read   = 1'b0;
        mem_write  = 1'b0;
        mem_to_reg = 1'b0;
        branch     = 1'b1;
    end
    default: begin
        alu_op = 4'b0000;
        imm_sel = 3'b000;
        reg_write = 1'b0;
        alu_src = 1'b0;
        mem_read = 1'b0;
        mem_write = 1'b0;
        mem_to_reg = 1'b0;
        branch = 1'b0;
    end
    endcase
end
endmodule
