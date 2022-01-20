`include "define.v"
module control (
    input      [5:0] i_opcode,
    output reg       o_reg_dst,
    output reg       o_mem_write,
    output reg       o_mem_reg,
    output reg       o_alusrc,
    output reg       o_reg_write,
    output reg       o_branch,
    output reg       o_eof,
    output reg [1:0] o_status,
    output reg [2:0] o_aluop
);

always@(*) begin
    o_reg_dst = 0;
    o_eof = 0;
    o_mem_write = 0;
    o_mem_reg = 0;
    o_alusrc = 0;
    o_reg_write = 0;
    o_branch = 0;
    o_aluop = 0;
    o_status = 0;
    case(i_opcode)
        `OP_ADD: begin
            o_reg_dst = 1;
            o_reg_write = 1;
            o_aluop = `ALU_ADD;
            o_status = `R_TYPE_SUCCESS;
        end
        `OP_SUB:begin
            o_reg_dst = 1;
            o_reg_write = 1;
            o_aluop = `ALU_SUB;
            o_status = `R_TYPE_SUCCESS;
        end
        `OP_ADDI:begin
            o_alusrc = 1;
            o_reg_write = 1;
            o_aluop = `ALU_ADD;
            o_status = `I_TYPE_SUCCESS;
        end
        `OP_LW:begin
            o_mem_reg = 1;
            o_alusrc = 1;
            o_reg_write = 1;
            o_aluop = `ALU_ADD;
            o_status = `I_TYPE_SUCCESS;
        end
        `OP_SW:begin
            o_mem_write = 1;
            o_alusrc = 1;
            o_aluop = `ALU_ADD;
            o_status = `I_TYPE_SUCCESS;
        end
        `OP_AND:begin
            o_reg_dst = 1;
            o_reg_write = 1;
            o_aluop = `ALU_AND;
            o_status = `R_TYPE_SUCCESS;
        end
        `OP_OR:begin
            o_reg_dst = 1;
            o_reg_write = 1;
            o_aluop = `ALU_OR;
            o_status = `R_TYPE_SUCCESS;
        end
        `OP_NOR:begin
            o_reg_dst = 1;
            o_reg_write = 1;
            o_aluop = `ALU_NOR;
            o_status = `R_TYPE_SUCCESS;
        end
        `OP_BEQ:begin
            o_branch = 1;
            o_aluop = `ALU_BEQ;
            o_status = `I_TYPE_SUCCESS;
        end
        `OP_BNE:begin
            o_branch = 1;
            o_aluop = `ALU_BNE;
            o_status = `I_TYPE_SUCCESS;
        end
        `OP_SLT:begin
            o_reg_dst = 1;
            o_reg_write = 1;
            o_aluop = `ALU_SLT;
            o_status = `R_TYPE_SUCCESS;
        end
        `OP_EOF:begin
            o_eof = 1;
            o_status = `MIPS_END;
        end 
    endcase
end

endmodule