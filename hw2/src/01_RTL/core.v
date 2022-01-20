`include "define.v"
module core #(                             //Don't modify interface
	parameter ADDR_W = 32,
	parameter INST_W = 32,
	parameter DATA_W = 32
)(
	input               i_clk,
	input               i_rst_n,
//---------- for inst_mem -------------	
	input  [INST_W-1:0] i_i_inst,
	output [ADDR_W-1:0] o_i_addr,
//---------- for data_mem -------------	
	output              o_d_wen,
	input  [DATA_W-1:0] i_d_rdata,
	output [DATA_W-1:0] o_d_wdata,
	output [ADDR_W-1:0] o_d_addr,
//---------- output signal ------------	
	output              o_status_valid,
	output [1:0]        o_status
);

// ================================= FSM ========================================== //
wire       overflow, eof;
reg        ud_pc, ud_reg_mem, terminate;
reg  [1:0] state, state_nxt;

parameter S_IDLE = 2'd0;
parameter S_CAL  = 2'd1;  // update pc
parameter S_UD   = 2'd2;  // update reg and mem
parameter S_END  = 2'd3;  

always@(*) begin
    case(state)
        S_IDLE: state_nxt = S_CAL;
        S_CAL:  state_nxt = (overflow | eof) ? S_END : S_UD;
        S_UD:   state_nxt = S_CAL;
        S_END:  state_nxt = S_END;
    endcase
end

always@(*) begin
    ud_pc = 0;
    ud_reg_mem = 0;
    terminate = 0;
    case(state)
        S_CAL: ud_pc = 1;
        S_UD:  ud_reg_mem = 1;
        S_END: terminate = 1;
    endcase
end

always@(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        state <= S_IDLE;
    end
    else begin
        state <= state_nxt;
    end       
end

// ================================= ~ D1 ======================================= //
reg  [ADDR_W-1:0] pc_d1_r; 
wire [ADDR_W-1:0] pc_d1_w;

always@(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        pc_d1_r <= 0;
    end
    else begin
        if(ud_pc)
            pc_d1_r <= pc_d1_w;
    end       
end

// =============================== D1 to D2 ======================================= //
// output assignment
assign o_i_addr = pc_d1_r;

// =============================== D2 to D3 ======================================= //
wire              reg_dst, branch, mem_write; 
wire              mem_reg, alusrc, reg_write;
wire              alu_overflow, alu_branch;
wire              d_mem_overflow, i_mem_overflow;
wire [1:0]        status;
wire [2:0]        aluop;
wire [4:0]        read_addr1, read_addr2, write_addr;
wire [5:0]        inst_op;
wire [DATA_W-1:0] read_data1, read_data2, alu_in2, alu_out, write_data_d4_w;
wire [ADDR_W-1:0] pc_add4, branch_addr;

reg          status_valid_d3_r; 
reg    [1:0] status_d3_r;
wire         status_valid_d3_w;
wire   [1:0] status_d3_w;

assign inst_op = i_i_inst[31:26];
assign read_addr1 = i_i_inst[25:21];
assign read_addr2 = i_i_inst[20:16];
assign write_addr = reg_dst ? i_i_inst[15:11] : read_addr2;
assign alu_in2 = alusrc ? i_i_inst[15:0] : read_data2;

assign pc_add4 = pc_d1_r + 4;
assign branch_addr = pc_add4 + i_i_inst[15:0];
assign pc_d1_w = (branch & alu_branch) ? branch_addr : pc_add4;

assign i_mem_overflow = |pc_d1_r[ADDR_W-1:12];
assign d_mem_overflow = (mem_reg | mem_write) && (|o_d_addr[ADDR_W-1:8]);
assign overflow = i_mem_overflow | d_mem_overflow | alu_overflow;

assign status_d3_w = (overflow & (!eof)) ? `MIPS_OVERFLOW : status;
assign status_valid_d3_w = ud_reg_mem | terminate;

control u_control(
    .i_opcode(inst_op),
    .o_reg_dst(reg_dst),
    .o_mem_write(mem_write),
    .o_mem_reg(mem_reg),
    .o_alusrc(alusrc),
    .o_reg_write(reg_write),
    .o_branch(branch),
    .o_eof(eof),
    .o_status(status),
    .o_aluop(aluop)
);

reg_file u_reg(  
    .i_clk(i_clk), 
    .i_rst_n(i_rst_n), 
    .i_read_addr1(read_addr1),
	.i_read_addr2(read_addr2),
	.o_read_data1(read_data1),
    .o_read_data2(read_data2),
    .i_wen(reg_write & ud_reg_mem),
    .i_write_addr(write_addr),
    .i_write_data(write_data_d4_w)
);

alu u_alu(
    .i_aluop(aluop),
    .i_data1(read_data1),
    .i_data2(alu_in2),
    .o_alu_overflow(alu_overflow),
    .o_alu_branch(alu_branch),
    .o_alu_out(alu_out)
);

always@(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        status_d3_r <= 0;
        status_valid_d3_r <= 0;
    end
    else begin
        status_d3_r <= status_d3_w;
        status_valid_d3_r <= status_valid_d3_w;
    end       
end

// output assignment
assign o_d_wen = mem_write & ud_reg_mem;
assign o_d_addr = alu_out;
assign o_d_wdata = read_data2;
assign o_status = status_d3_r;
assign o_status_valid = status_valid_d3_r;

// =============================== D3 to D4 ======================================= //
assign write_data_d4_w = mem_reg ? i_d_rdata : alu_out;


endmodule
