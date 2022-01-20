`include "define.v"
module alu (
    input      [2:0]  i_aluop,
    input      [31:0] i_data1,
    input      [31:0] i_data2,
    output reg        o_alu_overflow,
    output reg        o_alu_branch,
    output reg [31:0] o_alu_out
);

wire [31:0] bit_or;
wire [32:0] sum, diff;

assign sum  = i_data1 + i_data2;
assign diff = i_data1 - i_data2;
assign bit_or = i_data1 | i_data2;

always@(*) begin
    o_alu_out = bit_or;
    o_alu_overflow = 0;
    o_alu_branch = 0;
    case(i_aluop)
        `ALU_ADD: begin
            o_alu_out = sum;
            o_alu_overflow = sum[32];
        end
        `ALU_SUB: begin
            o_alu_out = diff;
            o_alu_overflow = diff[32];
        end
        `ALU_AND: o_alu_out = i_data1 & i_data2;
        `ALU_OR : o_alu_out = bit_or;
        `ALU_NOR: o_alu_out = ~bit_or; 
        `ALU_SLT: o_alu_out = i_data1 < i_data2;
        `ALU_BEQ: o_alu_branch = i_data1 == i_data2;
        `ALU_BNE: o_alu_branch = i_data1 != i_data2;
    endcase
end

endmodule