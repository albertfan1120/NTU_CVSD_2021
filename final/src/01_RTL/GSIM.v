module GSIM (                       
	input          i_clk,
	input          i_reset,
	input          i_module_en,
	input  [  4:0] i_matrix_num,
	output         o_proc_done,
//------ for matric_mem -----------	
	output         o_mem_rreq,
	output [  9:0] o_mem_addr,
	input          i_mem_rrdy,
	input  [255:0] i_mem_dout,
	input          i_mem_dout_vld,
//------- for sol_mem -----------	
	output         o_x_wen,
	output [  8:0] o_x_addr,
	output [ 31:0] o_x_data  
);
reg [4:0] matrix_num;
reg  	  data_val;
reg       module_en;
wire      mem_dout_vld = i_mem_dout_vld;
always @(posedge i_clk) begin
	matrix_num <= i_matrix_num - 1;
	data_val   <= i_mem_rrdy;
	module_en  <= i_module_en;
end
// ----------- wire / reg ------------ //
wire [31:0] x [0:15];
reg  [ 9:0] addr;
reg  [ 9:0] b_addr;
reg  [ 3:0] row;
reg  [ 3:0] col, col_nxt;
reg  [ 3:0] row_d1, row_d2;
reg  [ 3:0] col_d1, col_d2;
wire [ 3:0] row_p, col_p, row_p2;
wire [ 9:0] abs_row;

reg  	    b_valid_r;
reg  	    a0_valid_r, a1_valid_r;
reg  	    compute;
reg         m_e       [0:3];
reg         m_e_d1    [0:3];
reg         m_e_d2    [0:3];
reg         s_e       [0:3];
reg         s_e_d1    [0:3];
reg         s_e_d2    [0:3];
reg         s_l       [0:3];
reg         s_l_d1    [0:3];
reg         s_l_d2    [0:3];
reg         b_u       [0:3];
reg         b_u_d1    [0:3];
reg         b_u_d2    [0:3];
reg  [ 15:0] inst_B_r  [0:3];
wire [255:0] a_data_sel;
reg  [  2:0] com_num;
reg          taken;
wire         switch;
wire         change_row;
wire [  3:0] row_m_col;
wire [  1:0] b_sel;
reg  [ 15:0] b_up_data_r [0:3];
wire [  2:0] com_num_m1;
wire [  3:0] col_p4, col_p8;
reg  [ 31:0] inst_A_r;
reg          forward_sub;
reg  [  3:0] iter;
wire         x_wen;
reg  [  8:0] x_addr_cnt;
wire         sub_for_val;
wire         B_zero[0:3];
reg  [  4:0] mat_th;
wire         com_num_no0;
wire         use_p2;
wire [  3:0] row_plus;

// Core
wire [ 31:0] inst_A;
wire [ 15:0] inst_B     [0:3];
wire [  1:0] idx;
wire 		 m_en       [0:3];
wire 		 s_en       [0:3];
wire 		 s_last 	[0:3];
wire         b_ins;
wire [ 63:0] b_ins_data [0:3];
wire 		 b_up       [0:3];
wire [  1:0] b_up_idx;
wire [ 15:0] b_up_data  [0:3];
wire [127:0] x_data     [0:3];
wire [ 31:0] mul_forw   [0:3];
wire [ 31:0] sub_forw;
 

// Buffer
wire 		 a_valid [0:1];
wire 		 b_valid;
wire [255:0] a_data  [0:1];
wire [255:0] b_data;

// ------------- FSM ------------------- //
parameter S_IDLE  = 4'd0;
parameter S_SENDB = 4'd1;
parameter S_TAKEB = 4'd2;
parameter S_INIT  = 4'd3;
parameter S_BUF1  = 4'd4;
parameter S_LOW   = 4'd5;
parameter S_BUF2  = 4'd6;
parameter S_BUF3  = 4'd7;
parameter S_REC   = 4'd8;
parameter S_BUF4  = 4'd9;
parameter S_TER   = 4'd10;
parameter S_BUF5  = 4'd11;
parameter S_BUF6  = 4'd12;
parameter S_BUF7  = 4'd13;
parameter S_BUF8  = 4'd14;

reg [3:0] state, state_nxt;
reg       takeb, init, low, rec, done;

always@(*) begin
	state_nxt = state;
	case(state)
		S_IDLE:  if(i_module_en) state_nxt = S_SENDB;
		S_SENDB: state_nxt = S_TAKEB;
		S_TAKEB: if(i_mem_rrdy) state_nxt = S_INIT;
		S_INIT:  if(i_mem_rrdy && &row) state_nxt = S_BUF1;
		S_BUF1:  state_nxt = S_BUF2;
		S_BUF2:  if(i_mem_rrdy) state_nxt = S_LOW;
		S_LOW :  if(change_row && &row) state_nxt = S_REC;
		S_REC : begin
				if(change_row && iter == 15 && &row) begin
				    if(mat_th == matrix_num) state_nxt = S_BUF4;
				 	else state_nxt = S_BUF5;
				end  
		end 
		S_BUF5: state_nxt = S_BUF6;
		S_BUF6: state_nxt = S_BUF7;
		S_BUF7: state_nxt = S_BUF8;
		S_BUF8: state_nxt = S_SENDB;
		S_BUF4: if(!i_module_en) state_nxt = S_IDLE;
	endcase
end

always@(*) begin
	takeb = 0;
	init  = 0;
	low   = 0;
	rec   = 0;
	done  = 0;
	case(state)
		S_TAKEB: takeb = 1;
		S_INIT:  init  = 1;
		S_BUF2:  low   = 1;
		S_LOW:   low   = 1;
		S_REC :  rec   = 1;
		S_BUF4:  done  = 1;
	endcase
end

always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) state <= S_IDLE;
	else state <= state_nxt;
end
// ---------- b addr ------------------- //
always@(posedge i_clk or posedge i_reset) begin
	if(i_reset) b_addr <= 16;
	else if(state == S_SENDB) b_addr <= b_addr + 17;
end
// ---------- row ------------------- //
assign row_p  = row + 1;
assign row_p2 = row + 2;
assign use_p2 = low || rec;
assign row_plus = use_p2 ? row_p2 : row_p;
assign abs_row = mat_th + {mat_th, row_plus};


always@(posedge i_clk or posedge i_reset) begin
	if(i_reset) row <= 0;
	else if(takeb || init || state == S_BUF2) begin
		if(i_mem_rrdy) row <= row_p;
	end else if(low || rec) begin
		if(change_row) row <= row_p;
	end
end

// ---------- col ------------------- //
assign col_p  = col + 1;
assign col_p4 = col + 4;
assign col_p8 = col + 8;
always @(*) begin
	col_nxt = col;
	case(state)
		S_TAKEB: if(i_mem_rrdy) col_nxt = col_p;
		S_INIT:  if(i_mem_rrdy) col_nxt = col_p;
		S_LOW:  begin
		   if(change_row) col_nxt = 0;
		   else if(compute) col_nxt = col_p4;
		end 
		S_REC: begin
			if(com_num != 5 && com_num != 6) begin
				if(compute) begin
					if(&row[1:0] && change_row) col_nxt = row_p;
					else col_nxt = col_p4;
				end 
				else if(&row[1:0] && change_row) col_nxt = row_p;
			end
		end
	endcase
end

always@(posedge i_clk or posedge i_reset) begin
	if(i_reset) col <= 0;
	else col <= col_nxt;
end

// ---------- compute ------------------- //
assign com_num_no0 = |com_num;
always @(*) begin
	compute = 0;
	case(state)
		S_INIT: begin
			if(i_mem_rrdy) begin
				compute = 1;
			end 
		end 
		S_LOW: begin
			compute = com_num_no0;
		end
		S_REC: begin
			compute = com_num_no0 && (com_num != 5);
		end
	endcase
end
// ---------- compute num ------------------- //
assign com_num_m1 = com_num - 1;
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) com_num <= 0;
	else if(state == S_BUF2 && state_nxt == S_LOW) com_num <= 1;
	else if(low) begin
		if(change_row && &row) com_num <= 6;
		else if(change_row) com_num <= row[3:2] + 1;
		else if(com_num != 0) com_num <= com_num_m1;
	end
	else if(rec) begin
		if(change_row) com_num <= 6;
		else if(com_num != 0) com_num <= com_num_m1;
	end
end
// ---------- taken ------------------- //
assign change_row = (switch && taken) || (switch && i_mem_rrdy);
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) taken <= 0;
	else if(state == S_LOW || state == S_REC) begin
		if(change_row) taken <= 0;
		else if(i_mem_rrdy) taken <= 1;
	end
end

// ---------- switch ------------------- //
assign switch = com_num == 1 || com_num == 0;

// ---------- row / col delay ----------- //
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) begin
		row_d1 <= 0;
		col_d1 <= 0;
	end
	else if(compute) begin
		row_d1 <= row;
		col_d1 <= col;
	end
end

always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) begin
		row_d2 <= 0;
		col_d2 <= 0;
	end else begin
		row_d2 <= row_d1;
		col_d2 <= col_d1;
	end
end
// ---------- forward_sub ------------------- //
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) forward_sub <= 0;
	else if(rec && row == 3) forward_sub <= 1;
	else if(state == S_SENDB) forward_sub <= 0;
end
// ---------- iter ------------------- //
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) iter <= 0;
	else if(rec && change_row && &row) iter <= iter + 1;
	else if(state == S_SENDB) iter <= 0;
end

// ---------- mem addr ------------------- //
always@(posedge i_clk or posedge i_reset) begin
	if(i_reset) addr <= 0;
	else if(state == S_SENDB) addr <= b_addr;
	else if(state == S_TAKEB || state == S_INIT) begin if(i_mem_rrdy) addr <= abs_row; end
	else if(state == S_BUF1) addr <= abs_row;
	else if(state == S_BUF2)  begin if(i_mem_rrdy) addr <= abs_row; end
	else if(state == S_LOW || state == S_REC) begin if(change_row) addr <= abs_row; end
end

// ---------- x_out ------------------- //
assign x_wen = (iter == 15) && (com_num == 1);

always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) x_addr_cnt <= 0;
	else if(x_wen) x_addr_cnt <= x_addr_cnt + 1;
end
// ---------- mat_th ------------------- //
always@(posedge i_clk or posedge i_reset) begin
	if(i_reset) mat_th <= 0;
	else if(change_row && iter == 15 && &row) mat_th <= mat_th + 1;
end
// ---------- m_e ------------------- //
always @(*) begin
	m_e[0] = 0;
	m_e[1] = 0;
	m_e[2] = 0;
	m_e[3] = 0;
	case(state)
		S_INIT: begin
			if(compute) begin
				m_e[0] = (col[1:0] == 2'b00);
				m_e[1] = (col[1:0] == 2'b01);
				m_e[2] = (col[1:0] == 2'b10);
				m_e[3] = (col[1:0] == 2'b11);
			end
		end
		S_REC: begin
			if(com_num == 6) begin
				m_e[0] = (row[1:0] == 2'b00);
				m_e[1] = (row[1:0] == 2'b01);
				m_e[2] = (row[1:0] == 2'b10);
				m_e[3] = (row[1:0] == 2'b11);
			end
		end
		default: begin
			m_e[0] = 0; m_e[1] = 0; m_e[2] = 0; m_e[3] = 0;
		end
	endcase
end
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) begin
		m_e_d1[0] <= 0;
		m_e_d1[1] <= 0;
		m_e_d1[2] <= 0;
		m_e_d1[3] <= 0;
		m_e_d2[0] <= 0;
		m_e_d2[1] <= 0;
		m_e_d2[2] <= 0;
		m_e_d2[3] <= 0;
	end else begin
		m_e_d1[0] <= m_e[0];
		m_e_d1[1] <= m_e[1];
		m_e_d1[2] <= m_e[2];
		m_e_d1[3] <= m_e[3];
		m_e_d2[0] <= m_e_d1[0];
		m_e_d2[1] <= m_e_d1[1];
		m_e_d2[2] <= m_e_d1[2];
		m_e_d2[3] <= m_e_d1[3];
	end
end
// ---------- s_e ------------------- //
wire [4:0] row_m_col_5 = row - col;
assign row_m_col = row_m_col_5[3:0];

always @(*) begin
	s_e[0] = 0; s_e[1] = 0; s_e[2] = 0; s_e[3] = 0;
	case(state)
		S_LOW: begin
			if(compute) begin
				s_e[0] = 1;
				s_e[1] = 1;
				s_e[2] = 1;
				s_e[3] = 1;
				if(row_m_col == 1) begin
					s_e[1] = 0;
					s_e[2] = 0;
					s_e[3] = 0;
				end
				else if(row_m_col == 2) begin
					s_e[2] = 0;
					s_e[3] = 0;
				end
				else if(row_m_col == 3) begin
					s_e[3] = 0;
				end
			end
		end
		S_REC: begin
			if(compute && com_num != 5 && com_num != 6) begin
				s_e[0] = 1;
				s_e[1] = 1;
				s_e[2] = 1;
				s_e[3] = 1;
				if(com_num == 4) begin
					if(row[1:0] == 0) s_e[0] = 0;
					else if(row[1:0] == 1) s_e[1] = 0;
					else if(row[1:0] == 2) s_e[2] = 0;
					else if(row[1:0] == 3) s_e[3] = 0;
				end
			end
		end
		default: begin
		  	s_e[0] = 0; s_e[1] = 0; s_e[2] = 0; s_e[3] = 0;
		end
	endcase
end
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) begin
		s_e_d1[0] <= 0;
		s_e_d1[1] <= 0;
		s_e_d1[2] <= 0;
		s_e_d1[3] <= 0;
		s_e_d2[0] <= 0;
		s_e_d2[1] <= 0;
		s_e_d2[2] <= 0;
		s_e_d2[3] <= 0;
	end else begin
		s_e_d1[0] <= s_e[0];
		s_e_d1[1] <= s_e[1];
		s_e_d1[2] <= s_e[2];
		s_e_d1[3] <= s_e[3];
		s_e_d2[0] <= s_e_d1[0];
		s_e_d2[1] <= s_e_d1[1];
		s_e_d2[2] <= s_e_d1[2];
		s_e_d2[3] <= s_e_d1[3];
	end
end
// ---------- s_last ------------------- //
always @(*) begin
	s_l[0] = 0; s_l[1] = 0; s_l[2] = 0; s_l[3] = 0;
	case(state)
		S_LOW: begin
			if(compute) begin
				if(!col && &row) s_l[0] = 1;
			end
		end
		S_REC: begin
			if(compute) begin
				if(com_num == 4) begin
					if(row[1:0] == 0) s_l[1] = 1;
					else if(row[1:0] == 1) s_l[2] = 1;
					else if(row[1:0] == 2) s_l[3] = 1;
				end
				else if(com_num == 3 && &row[1:0]) s_l[0] = 1;
			end
		end
		default: begin
			s_l[0] = 0; s_l[1] = 0; s_l[2] = 0; s_l[3] = 0;
		end
	endcase
end
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) begin
		s_l_d1[0] <= 0;
		s_l_d1[1] <= 0;
		s_l_d1[2] <= 0;
		s_l_d1[3] <= 0;
		s_l_d2[0] <= 0;
		s_l_d2[1] <= 0;
		s_l_d2[2] <= 0;
		s_l_d2[3] <= 0;
	end else begin
		s_l_d1[0] <= s_l[0];
		s_l_d1[1] <= s_l[1];
		s_l_d1[2] <= s_l[2];
		s_l_d1[3] <= s_l[3];
		s_l_d2[0] <= s_l_d1[0];
		s_l_d2[1] <= s_l_d1[1];
		s_l_d2[2] <= s_l_d1[2];
		s_l_d2[3] <= s_l_d1[3];
	end
end
// ---------- b_up ------------------- //
always @(*) begin
	b_u[0] = 0; b_u[1] = 0; b_u[2] = 0; b_u[3] = 0;
	case(state)
		S_LOW:begin
			if(compute) begin
				if(row_m_col == 1) b_u[1] = 1;
				else if(row_m_col == 2) b_u[2] = 1;
				else if(row_m_col == 3) b_u[3] = 1;
				else if(row_m_col == 4) b_u[0] = 1;
			end
		end
		S_REC:begin
			if(compute && com_num == 1) begin
				if(row[1:0] == 0) b_u[0] = 1;
				else if(row[1:0] == 1) b_u[1] = 1;
				else if(row[1:0] == 2) b_u[2] = 1;
				else if(row[1:0] == 3) b_u[3] = 1;
			end
		end
		default: begin
			b_u[0] = 0; b_u[1] = 0; b_u[2] = 0; b_u[3] = 0;
		end
	endcase
end
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) begin
		b_u_d1[0] <= 0;
		b_u_d1[1] <= 0;
		b_u_d1[2] <= 0;
		b_u_d1[3] <= 0;
		b_u_d2[0] <= 0;
		b_u_d2[1] <= 0;
		b_u_d2[2] <= 0;
		b_u_d2[3] <= 0;
	end else begin
		b_u_d1[0] <= b_u[0];
		b_u_d1[1] <= b_u[1];
		b_u_d1[2] <= b_u[2];
		b_u_d1[3] <= b_u[3];
		b_u_d2[0] <= b_u_d1[0];
		b_u_d2[1] <= b_u_d1[1];
		b_u_d2[2] <= b_u_d1[2];
		b_u_d2[3] <= b_u_d1[3];
	end
end
// ---------- b_up_data ------------------- //
assign b_sel = row_d2[3:2];
always @(*) begin
	case(b_sel)
		2'b00: {b_up_data_r[3], b_up_data_r[2], b_up_data_r[1], b_up_data_r[0]} = 
			   {b_data[  0+:64]};
		2'b01: {b_up_data_r[3], b_up_data_r[2], b_up_data_r[1], b_up_data_r[0]} = 
			   {b_data[ 64+:64]};
		2'b10: {b_up_data_r[3], b_up_data_r[2], b_up_data_r[1], b_up_data_r[0]} = 
			   {b_data[128+:64]};
		2'b11: {b_up_data_r[3], b_up_data_r[2], b_up_data_r[1], b_up_data_r[0]} = 
			   {b_data[192+:64]};
	endcase
end
// ---------- inst_A ------------------- //
always @(*) begin
	inst_A_r = x[row_d2];
	if(rec) begin
		if(com_num == 2) begin
			if(row_d2[1:0] == 0) inst_A_r = mul_forw[0];
			else if(row_d2[1:0] == 1) inst_A_r = mul_forw[1];
			else if(row_d2[1:0] == 2) inst_A_r = mul_forw[2];
			else if(row_d2[1:0] == 3) inst_A_r = mul_forw[3];
		end
		else if(row_d2[1:0] == 0 && forward_sub && com_num == 4) begin
			if(sub_for_val) inst_A_r = sub_forw;
		end
	end
end

// ---------- inst_B ------------------- //
assign a_data_sel = row_d2[0] ? a_data[1] : a_data[0];
always @(*) begin
	case(col_d2[3:2])
		2'b00: {inst_B_r[3], inst_B_r[2], inst_B_r[1], inst_B_r[0]} = a_data_sel[  0+:64];
		2'b01: {inst_B_r[3], inst_B_r[2], inst_B_r[1], inst_B_r[0]} = a_data_sel[ 64+:64];
		2'b10: {inst_B_r[3], inst_B_r[2], inst_B_r[1], inst_B_r[0]} = a_data_sel[128+:64];
		2'b11: {inst_B_r[3], inst_B_r[2], inst_B_r[1], inst_B_r[0]} = a_data_sel[192+:64];
	endcase
end

genvar i;
generate
    for(i = 0; i < 4; i = i + 1) begin : zero_gen
        assign B_zero[i] = !inst_B_r[i];
    end
endgenerate
// ---------- core var ------------------- //
generate
    for(i = 0; i < 16; i = i + 1) begin : x_gen
        assign x[i] = x_data[i%4][(i[3:2]*32)+:32];
    end
endgenerate

generate
    for(i = 0; i < 4; i = i + 1) begin : gen_b_ins_data
        assign b_ins_data[i] = {i_mem_dout[((12+i)*16)+:16], i_mem_dout[((8+i)*16)+:16], 
						        i_mem_dout[(( 4+i)*16)+:16], i_mem_dout[i*16+:16]};
    end
endgenerate

generate
    for(i = 0; i < 4; i = i + 1) begin : gen_core_sig
        assign b_up_data[i] = b_up_data_r[i];
		assign m_en[i] = m_e_d2[i];
		assign s_en[i] = s_e_d2[i];
		assign b_up[i] = b_u_d2[i];
		assign s_last[i] = s_l_d2[i];
		assign inst_B[i] = inst_B_r[i];
    end
endgenerate

assign b_ins = b_valid_r;
assign inst_A = inst_A_r;

assign idx = col_d2[3:2]; 
assign b_up_idx = row_d2[3:2];
// ---------- buffer var ------------------- //
assign b_valid = b_valid_r;
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) b_valid_r <= 0;
	else if(state == S_TAKEB && i_mem_rrdy) b_valid_r <= 1;
	else b_valid_r <= 0;
end

assign a_valid[0] = a0_valid_r;
assign a_valid[1] = a1_valid_r;
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) a0_valid_r <= 0;
	else if(init) begin
		if(!row[0]) a0_valid_r <= i_mem_rrdy;
		else a0_valid_r <= 0;
	end
	else if(low | rec) begin
	  	if(row[0]) a0_valid_r <= i_mem_rrdy;
		else a0_valid_r <= 0;
	end 
	else a0_valid_r <= 0;
end
always @(posedge i_clk or posedge i_reset) begin
	if(i_reset) a1_valid_r <= 0;
	else if(init) begin
		if(row[0]) a1_valid_r <= i_mem_rrdy;
		else a1_valid_r <= 0;
	end
	else if(low | rec) begin
		if(!row[0]) a1_valid_r <= i_mem_rrdy;
		else a1_valid_r <= 0;
	end 
	else a1_valid_r <= 0;
end

//----------------- core ------------------- //
Core core0(                       
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_inst_A(inst_A),
	.i_inst_B(inst_B[0]),
	.i_idx(idx),
	.i_m_en(m_en[0]),
	.i_s_en(s_en[0]),
	.i_s_last(s_last[0]), 
	.i_zero(B_zero[0]),
	.i_b_ins(b_ins), 
	.i_b_ins_data(b_ins_data[0]),
	.i_b_up(b_up[0]),   
	.i_b_up_idx(b_up_idx),
	.i_b_up_data(b_up_data[0]),
	.o_sub_for_val(sub_for_val),
	.o_mul_forw(mul_forw[0]),
	.o_sub_forw(sub_forw),
	.o_x_data(x_data[0])
);
Core core1(                       
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_inst_A(inst_A),
	.i_inst_B(inst_B[1]),
	.i_idx(idx),   
	.i_m_en(m_en[1]),  
	.i_s_en(s_en[1]),
	.i_s_last(s_last[1]),
	.i_zero(B_zero[1]),
	.i_b_ins(b_ins),  
	.i_b_ins_data(b_ins_data[1]),
	.i_b_up(b_up[1]),  
	.i_b_up_idx(b_up_idx),
	.i_b_up_data(b_up_data[1]),
	.o_mul_forw(mul_forw[1]),
	.o_x_data(x_data[1])
);
Core core2(                       
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_inst_A(inst_A),
	.i_inst_B(inst_B[2]),
	.i_idx(idx),   
	.i_m_en(m_en[2]),  
	.i_s_en(s_en[2]),
	.i_s_last(s_last[2]), 
	.i_zero(B_zero[2]),
	.i_b_ins(b_ins),  
	.i_b_ins_data(b_ins_data[2]),
	.i_b_up(b_up[2]),   
	.i_b_up_idx(b_up_idx),
	.i_b_up_data(b_up_data[2]),
	.o_mul_forw(mul_forw[2]),
	.o_x_data(x_data[2])
);
Core core3(                       
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_inst_A(inst_A),
	.i_inst_B(inst_B[3]),
	.i_idx(idx),   
	.i_m_en(m_en[3]),  
	.i_s_en(s_en[3]),
	.i_s_last(s_last[3]), 
	.i_zero(B_zero[3]),
	.i_b_ins(b_ins),  
	.i_b_ins_data(b_ins_data[3]),
	.i_b_up(b_up[3]),   
	.i_b_up_idx(b_up_idx),
	.i_b_up_data(b_up_data[3]),
	.o_mul_forw(mul_forw[3]),
	.o_x_data(x_data[3])
);

// --------------- buffer ---------------- //
Buffer a0(
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_valid(a_valid[0]),
	.i_data(i_mem_dout),
	.o_data(a_data[0])
);
Buffer a1(
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_valid(a_valid[1]),
	.i_data(i_mem_dout),
	.o_data(a_data[1])
);
Buffer b(
	.i_clk(i_clk),
	.i_reset(i_reset),
	.i_valid(b_valid),
	.i_data(i_mem_dout),
	.o_data(b_data)
);

// ------------- output assignment ------------------ //
assign o_mem_addr  = addr;
assign o_proc_done = done;
assign o_mem_rreq  = 1;
assign o_x_data = x[row];
assign o_x_wen  = x_wen;
assign o_x_addr = x_addr_cnt;

endmodule
