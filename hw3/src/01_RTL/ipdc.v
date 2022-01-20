`include "define.v"
module ipdc(                       
	input         i_clk,
	input         i_rst_n,
	input         i_op_valid,
	input  [ 3:0] i_op_mode,
    output        o_op_ready,
	input         i_in_valid,
	input  [23:0] i_in_data,
	output        o_in_ready,
	output        o_out_valid,
	output [23:0] o_out_data
);
reg        op_valid;
reg [3:0]  op_mode;
reg [23:0] in_data;
always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) begin
		op_valid <= 0;
		op_mode  <= 0;
		in_data  <= 0;
	end else begin
		op_valid <= i_op_valid;
		op_mode  <= i_op_mode;
		in_data  <= i_in_data;
	end
end

// ====================== wire/reg ========================= //
reg        op_ready, op_ready_nxt;
reg  [7:0] sram_addr;
reg  [7:0] cnt_255;
reg  [2:0] dis_size, dis_size_nxt;
wire [7:0] q_R, q_G, q_B, d_R, d_G, d_B;
wire       sram_wen;
reg  [3:0] origin_row, origin_col;
reg  [3:0] op;

reg  [3:0] display_col, display_row;
reg  [3:0] filter_row, filter_col;
reg        is_filter, is_padding;
reg  [3:0] cnt_9;
// ========================= FSM =========================== //
reg [3:0] state, state_nxt;
parameter S_IDLE  = 4'd0;
parameter S_READY = 4'd1;
parameter S_BUF1  = 4'd2;
parameter S_BUF2  = 4'd3;
parameter S_LOAD  = 4'd4;
parameter S_FIRE  = 4'd6;
parameter S_BUF3  = 4'd7;
parameter S_BUF4  = 4'd8;
parameter S_GOP   = 4'd9;
parameter S_GETO  = 4'd10;
parameter S_DIS4  = 4'd11;
parameter S_DIS2  = 4'd12;
parameter S_DIS1  = 4'd13;
parameter S_BUF5  = 4'd14;
parameter S_BUF6  = 4'd5;

parameter DIS_4_4 = 3'b001;
parameter DIS_2_2 = 3'b010;
parameter DIS_1_1 = 3'b100;

always@(*) begin
	state_nxt = state;
	case(state)
		S_IDLE : state_nxt = S_READY;
		S_READY: state_nxt = S_BUF1;
		S_BUF1 : state_nxt = S_BUF2;
		S_BUF2 : state_nxt = S_LOAD;
		S_LOAD : if(&cnt_255) state_nxt = S_BUF6;
		S_FIRE : state_nxt = S_BUF3;
		S_BUF3 : state_nxt = S_GOP;
		S_GOP  : state_nxt = S_BUF4;
		S_BUF4 : state_nxt = S_GETO;
		S_GETO : begin
			if(dis_size == DIS_4_4) state_nxt = S_DIS4;
			else if(dis_size == DIS_2_2) state_nxt = S_DIS2;
			else if(dis_size == DIS_1_1) state_nxt = S_DIS1;
		end
		S_DIS4 : begin
			if(is_filter) begin
				if((&cnt_255[3:0]) && cnt_9 == 8'd9) state_nxt = S_BUF5;
			end
			else if(&cnt_255[3:0]) state_nxt = S_BUF5;
		end 
		S_DIS2 : begin
			if(is_filter) begin
				if((&cnt_255[1:0]) && cnt_9 == 8'd9) state_nxt = S_BUF5;
			end
			else if(&cnt_255[1:0]) state_nxt = S_BUF5;
		end 
		S_DIS1 : begin
			if(is_filter) begin
				if(cnt_9 == 8'd9) state_nxt = S_BUF5;
			end
			else state_nxt = S_BUF5;
		end 
		S_BUF5 : state_nxt = S_BUF6;
		S_BUF6 : state_nxt = S_FIRE;
	endcase
end

always@(*) begin
	op_ready_nxt = 0;
	case(state)
		S_IDLE : op_ready_nxt = 1;
		S_READY: op_ready_nxt = 0;
		S_FIRE : op_ready_nxt = 0;
		S_BUF6 : op_ready_nxt = 1;
	endcase
end

always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) begin
		state <= S_IDLE;
		op_ready <= 0;
	end 
	else begin
		state <= state_nxt;
		op_ready <= op_ready_nxt;
	end
end


// ================= counter ====================== //

always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) cnt_255 <= 0;
	else if(op_valid || state == S_GETO) cnt_255 <= 0;
	else if(is_filter) begin
		if(cnt_9 == 9) cnt_255 <= cnt_255 + 1;
	end	
	else cnt_255 <= cnt_255 + 1;
end


always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) cnt_9 <= 0;
	else if(state == S_GETO || cnt_9 == 9) cnt_9 <= 0;
	else cnt_9 <= cnt_9 + 1;
end
// ================= sram ====================== //
always@(*) begin
	sram_addr = cnt_255; // load images
	case(op)
		`OP_RIGHT, 
    	`OP_LEFT,  
    	`OP_UP,   
    	`OP_DOWN,  
    	`OP_SD,   
    	`OP_SU,
		`OP_COLOR: if(state == S_DIS4 || state == S_DIS2 || state == S_DIS1) 
				sram_addr = {display_row, display_col};
    	`OP_MED,
    	`OP_CENS:if(state == S_DIS4 || state == S_DIS2 || state == S_DIS1) 
				sram_addr = {filter_row, filter_col};  
	endcase
end

assign sram_wen = state != S_LOAD;
assign d_R = in_data[23:16];
assign d_G = in_data[15: 8];
assign d_B = in_data[ 7: 0];

sram_256x8 red  (.Q(q_R), .CLK(i_clk), .CEN(1'b0), .WEN(sram_wen), .A(sram_addr), .D(d_R));
sram_256x8 green(.Q(q_G), .CLK(i_clk), .CEN(1'b0), .WEN(sram_wen), .A(sram_addr), .D(d_G));
sram_256x8 blue (.Q(q_B), .CLK(i_clk), .CEN(1'b0), .WEN(sram_wen), .A(sram_addr), .D(d_B));

// ==================== Filter ========================= //
wire [23:0] in_filter, out_ycbcr, out_census, out_median;
wire [23:0] in_cense_med = is_padding ? 0 : in_filter;
assign in_filter = {q_R, q_G, q_B};
Color_trans YCbCr(
	.i_rgb(in_filter),
	.o_ycbcr(out_ycbcr)
);

wire median_clear = cnt_9 == 0;
reg  cens_start;
always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) cens_start <= 0;
	else cens_start <= median_clear;
end
Census census(
    .i_clk(i_clk),
    .i_start(cens_start), // one cycle
	.i_data(in_cense_med),
	.o_data(out_census)
);

Median sorter(
    .i_clk(i_clk),
    .i_clear(median_clear), // one cycle
	.i_data(in_cense_med),
	.o_median(out_median)
);

// =============== display size ================== //
always@(*) begin
	dis_size_nxt = dis_size;
	if(op_mode == `OP_SD) begin
		if(dis_size == DIS_4_4) dis_size_nxt = DIS_2_2;
		else if(dis_size == DIS_2_2) dis_size_nxt = DIS_1_1;
	end
	else if(op_mode == `OP_SU) begin
		if(dis_size == DIS_2_2 && origin_col != 4'b1101 && origin_row != 4'b1101)
			dis_size_nxt = DIS_4_4;
		else if(dis_size == DIS_1_1 && origin_col[3:1] != 3'b111 && origin_row[3:1] != 3'b111)
			dis_size_nxt = DIS_2_2;
	end
end

always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) dis_size <= DIS_4_4;
	else if(op_valid) dis_size <= dis_size_nxt;
end

// ============= origin =================== //
wire [4:0] ori_R, ori_L, ori_D, ori_U;
wire       R_vio, L_vio, D_vio, U_vio;

assign ori_R = origin_col + dis_size;
assign ori_L = origin_col - dis_size;
assign ori_D = origin_row + dis_size;
assign ori_U = origin_row - dis_size;

assign R_vio = dis_size == DIS_4_4 ? origin_col[3:2] == 2'b11   :
			   dis_size == DIS_2_2 ? origin_col[3:2] == 2'b11   :
			   dis_size == DIS_1_1 ? origin_col[3:2] == 2'b11   : 0;
assign L_vio = dis_size == DIS_4_4 ? origin_col      == 4'b0000 :
			   dis_size == DIS_2_2 ? origin_col[3:1] == 3'b000  :
			   dis_size == DIS_1_1 ? origin_col[3:2] == 2'b00   : 0;
assign D_vio = dis_size == DIS_4_4 ? origin_row[3:2] == 2'b11   :
			   dis_size == DIS_2_2 ? origin_row[3:2] == 2'b11   :
			   dis_size == DIS_1_1 ? origin_row[3:2] == 2'b11   : 0;
assign U_vio = dis_size == DIS_4_4 ? origin_row      == 4'b0000 :
			   dis_size == DIS_2_2 ? origin_row[3:1] == 3'b000  :
			   dis_size == DIS_1_1 ? origin_row[3:2] == 2'b00   : 0;
always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) begin
		origin_col <= 0;
		origin_row <= 0;
	end 
	else if(state == S_BUF4) begin
		if(op == `OP_RIGHT && !R_vio)     origin_col <= ori_R;
		else if(op == `OP_LEFT && !L_vio) origin_col <= ori_L;
		else if(op == `OP_DOWN && !D_vio) origin_row <= ori_D;
		else if(op == `OP_UP && !U_vio)   origin_row <= ori_U;
	end
end

// ========== display address ============== //
wire [1:0] offset_plus, offset_minus;
wire [3:0] col_plus  = display_col + offset_plus;
wire [3:0] col_minus = display_col - offset_minus;
wire [3:0] row_plus  = display_row + offset_plus;

assign offset_plus  = (dis_size == DIS_4_4) ? 2'd1 : 2'd2;
assign offset_minus = (dis_size == DIS_4_4) ? 2'd3 : 2'd2;

reg [3:0] display_col_nxt, display_row_nxt;

always @(*) begin
	display_col_nxt = display_col;
	display_row_nxt = display_row;
	if(state == S_GETO) begin
		display_col_nxt = origin_col;
		display_row_nxt = origin_row;
	end
	else if(!is_filter || cnt_9 == 9) begin
		if(dis_size == DIS_4_4) begin
			if(&cnt_255[1:0]) begin
				display_col_nxt = col_minus;
				display_row_nxt = row_plus;
			end
			else display_col_nxt = col_plus;
		end
		else if(dis_size == DIS_2_2) begin
			if(cnt_255[0]) begin
				display_col_nxt = col_minus;
				display_row_nxt = row_plus;
			end
			else display_col_nxt = col_plus;
		end
	end
end
always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) begin
		display_col <= 0;
		display_row <= 0;
	end 
	else begin
		display_col <= display_col_nxt;
		display_row <= display_row_nxt;
	end
end
// ========== filter address ============== //
wire [2:0] f_offset;
wire [3:0] f_col_plus  = display_col + f_offset;
wire [3:0] f_col_minus = display_col - f_offset;
wire [3:0] f_row_plus  = display_row + f_offset;
wire [3:0] f_row_minus = display_row - f_offset;

wire [1:0] shift_bit = (dis_size == DIS_4_4 ? 0 :
					    dis_size == DIS_2_2 ? 1 :
					    dis_size == DIS_1_1 ? 2 : 0);

assign f_offset = 1 << shift_bit;

reg [3:0] filter_row_nxt, filter_col_nxt;
always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) begin
		filter_col <= 0;
		filter_row <= 0;
	end
	else if(state == S_GETO) begin
		filter_col <= origin_col;
		filter_row <= origin_row;
	end
	else if(cnt_9 == 9) begin
		filter_col <= display_col_nxt;
		filter_row <= display_row_nxt;
	end
	else begin
		filter_col <= filter_col_nxt;
		filter_row <= filter_row_nxt;
	end
end


always@(*) begin
	filter_col_nxt = f_col_plus;
	filter_row_nxt = f_row_plus;
	case(cnt_9)
		0: begin
			filter_col_nxt = f_col_minus;
			filter_row_nxt = f_row_minus;
		end
		1: begin
		  	filter_col_nxt = display_col;
			filter_row_nxt = f_row_minus;
		end
		2: begin
		  	filter_col_nxt = f_col_plus;
			filter_row_nxt = f_row_minus;
		end
		3: begin
		  	filter_col_nxt = f_col_minus;
			filter_row_nxt = display_row;
		end
		4: begin
		  	filter_col_nxt = f_col_plus;
			filter_row_nxt = display_row;
		end
		5: begin
		  	filter_col_nxt = f_col_minus;
			filter_row_nxt = f_row_plus;
		end
		6: begin
		  	filter_col_nxt = display_col;
			filter_row_nxt = f_row_plus;
		end
		7: begin
		  	filter_col_nxt = f_col_plus;
			filter_row_nxt = f_row_plus;
		end
	endcase
end
// ============ padding =============== //

always@(*) begin
	is_padding = 0;
	case(cnt_9)
		2: is_padding = dis_size == DIS_4_4 ? display_row == 4'b0000     || display_col == 4'b0000     :
						dis_size == DIS_2_2 ? display_row[3:1] == 3'b000 || display_col[3:1] == 3'b000 :
						dis_size == DIS_1_1 ? display_row[3:2] == 2'b00  || display_col[3:2] == 2'b00  : 0;
		3: is_padding = dis_size == DIS_4_4 ? display_row == 4'b0000     :
						dis_size == DIS_2_2 ? display_row[3:1] == 3'b000 :
						dis_size == DIS_1_1 ? display_row[3:2] == 2'b00  : 0;
		4: is_padding = dis_size == DIS_4_4 ? display_row == 4'b0000     || display_col == 4'b1111 :
						dis_size == DIS_2_2 ? display_row[3:1] == 3'b000 || display_col[3:1] == 3'b111 :
						dis_size == DIS_1_1 ? display_row[3:2] == 2'b00  || display_col[3:2] == 2'b11 : 0;
		5: is_padding = dis_size == DIS_4_4 ? display_col == 4'b0000     :
						dis_size == DIS_2_2 ? display_col[3:1] == 3'b000 :
						dis_size == DIS_1_1 ? display_col[3:2] == 2'b00  : 0;
		6: is_padding = dis_size == DIS_4_4 ? display_col == 4'b1111     :
						dis_size == DIS_2_2 ? display_col[3:1] == 3'b111 :
						dis_size == DIS_1_1 ? display_col[3:2] == 2'b11  : 0;
		7: is_padding = dis_size == DIS_4_4 ? display_row == 4'b1111     || display_col == 4'b0000 :
						dis_size == DIS_2_2 ? display_row[3:1] == 3'b111 || display_col[3:1] == 3'b000 :
						dis_size == DIS_1_1 ? display_row[3:2] == 2'b11  || display_col[3:2] == 2'b00 : 0;
		8: is_padding = dis_size == DIS_4_4 ? display_row == 4'b1111     :
						dis_size == DIS_2_2 ? display_row[3:1] == 3'b111 :
						dis_size == DIS_1_1 ? display_row[3:2] == 2'b11  : 0;
		9: is_padding = dis_size == DIS_4_4 ? display_row == 4'b1111     || display_col == 4'b1111 :
						dis_size == DIS_2_2 ? display_row[3:1] == 3'b111 || display_col[3:1] == 3'b111 :
						dis_size == DIS_1_1 ? display_row[3:2] == 2'b11  || display_col[3:2] == 2'b11 : 0;
	endcase
end

// ============= op =================== //
wire   is_median = op == `OP_MED;
wire   is_cense  = op == `OP_CENS;

always@(posedge i_clk) begin
	if(op_valid) op <= op_mode;
end

// ============= out_valid / out_data =================== //
reg [23:0] out_data, out_data_nxt;
reg        out_valid, out_valid_2, out_valid_nxt;

always@(*) begin
	out_valid_nxt = 0;
	is_filter = 0;
	out_data_nxt = {q_R, q_G, q_B};
	case(op)
		`OP_RIGHT, 
    	`OP_LEFT,  
    	`OP_UP,   
    	`OP_DOWN,  
    	`OP_SD,   
    	`OP_SU:begin
			if(state == S_DIS4 || state == S_DIS2 || state == S_DIS1) begin
				out_valid_nxt = 1;
				out_data_nxt = {q_R, q_G, q_B};
				is_filter = 0;
			end
		end
		`OP_COLOR: begin
			if(state == S_DIS4 || state == S_DIS2 || state == S_DIS1 ) begin
				out_valid_nxt = 1;
				out_data_nxt = out_ycbcr;
				is_filter = 0;
			end
			else if(state == S_BUF5) begin
				out_data_nxt = out_ycbcr;
			end
		end

    	`OP_MED,
    	`OP_CENS:begin
			if(state == S_DIS4 || state == S_DIS2 || state == S_DIS1) begin
				if(cnt_9 == 8) out_valid_nxt = 1;
				is_filter = 1;
			end
		end
	endcase
end

always@(posedge i_clk) begin
	out_valid   <= out_valid_nxt;
	out_data    <= out_data_nxt;
end
always@(posedge i_clk or negedge i_rst_n) begin
	if(!i_rst_n) out_valid_2 <= 0;
	else out_valid_2 <= out_valid;
end
// ============= output assignment =================== //
assign o_in_ready  = 1;
assign o_op_ready  = op_ready;
assign o_out_valid = out_valid_2;
assign o_out_data  = is_cense  ? out_census : 
				     is_median ? out_median : out_data;

endmodule
