`include "define.v"
module IOTDF(
    input          clk,
    input          rst,
    input          in_en,
    input  [7:0]   iot_in,
    input  [2:0]   fn_sel,
    output         busy,
    output         valid,
    output [127:0] iot_out
);
reg [2:0] fn;
reg [7:0] iot_d;
always@(posedge clk or posedge rst) begin
    if(rst) begin
        iot_d <= 0;
        fn <= 0;
    end
    else begin
        iot_d <= iot_in;
        fn <= fn_sel;
    end
end
// ================================= FSM ========================================== //
reg [2:0] state, state_nxt;
reg [6:0] cnt127;
wire      is_AVG;

parameter S_IDLE  = 0;
parameter S_BUF1  = 1;
parameter S_GETD  = 2;
parameter S_CLEAN = 3;
parameter S_AVGC  = 4;

always@(*) begin
    state_nxt = state;
    case(state)
        S_IDLE:  state_nxt = S_BUF1;
        S_BUF1:  state_nxt = S_GETD;
        S_GETD:  begin
            if(&cnt127) begin
                if(is_AVG) state_nxt = S_AVGC;
                else state_nxt = S_CLEAN;
            end 
        end 
        S_CLEAN: state_nxt = S_GETD;
        S_AVGC:  if(&cnt127[3:0]) state_nxt = S_CLEAN;
    endcase
end

always@(posedge clk or posedge rst) begin
    if(rst) state <= S_IDLE;
    else state <= state_nxt;
end

parameter EXT_LOW  = 8'h6F;
parameter EXT_HIGH = 8'hAF;
parameter EXC_LOW  = 8'h7F;
parameter EXC_HIGH = 8'hBF;
parameter ALL_FF   = 16'hFFFF;

wire         clean, cal_update, need_update, bigger, smaller;
wire         is_EX, between, exclude, reverse, add_valid, sum_c;
wire [7:0]   sum_8, init_pat, com_max, com_min, low_th, high_th, add_data;
wire [15:0]  cat_th;
wire [127:0] answer, mean;

reg          carry_d, continue, stop;
reg  [2:0]   sum_carry;
reg  [7:0]   sum_buff [0:15];
reg  [7:0]   ans_buff [0:15];

genvar i;

assign answer = {ans_buff[15], ans_buff[14], ans_buff[13], ans_buff[12],
                 ans_buff[11], ans_buff[10], ans_buff[09], ans_buff[08],
                 ans_buff[07], ans_buff[06], ans_buff[05], ans_buff[04],
                 ans_buff[03], ans_buff[02], ans_buff[01], ans_buff[00]};
assign mean = {sum_carry,    sum_buff[15], sum_buff[14], sum_buff[13],
               sum_buff[12], sum_buff[11], sum_buff[10], sum_buff[09],
               sum_buff[08], sum_buff[07], sum_buff[06], sum_buff[05],
               sum_buff[04], sum_buff[03], sum_buff[02], sum_buff[01],
               sum_buff[00][7:3]};

assign clean = (fn != `FN_PMAX && fn != `FN_PMIN && state == S_CLEAN) ||
               (state == S_BUF1);
assign init_pat = (fn == `FN_MAX || fn == `FN_PMAX) ? 8'd0 : 8'd255;

assign com_max  = is_EX ? low_th  : ans_buff[15]; 
assign com_min  = is_EX ? high_th : ans_buff[15]; 

assign bigger  = iot_d > com_max;
assign smaller = iot_d < com_min;
assign between = bigger & smaller;
assign exclude = !between;
assign cal_update = (fn == `FN_MAX || fn == `FN_PMAX) ? bigger  :
                    (fn == `FN_MIN || fn == `FN_PMIN) ? smaller :
                    fn == `FN_EXT ? between : exclude;
assign need_update = stop     ? 0 :
                     continue ? 1 : cal_update;

wire [1:0] condition = (fn == `FN_MAX || fn == `FN_PMAX) ? {bigger, smaller} : 
                       (fn == `FN_MIN || fn == `FN_PMIN) ? {smaller, bigger} :
                       fn == `FN_EXT ? {between, exclude} : {exclude, between};

wire cond_conti = condition[1] & !stop; 
wire cond_stop  = condition[0] & !continue;

assign cat_th = fn == `FN_EXT ? {EXT_LOW, EXT_HIGH} : {EXC_LOW, EXC_HIGH};
assign {low_th, high_th} = !cnt127[3:0] ? cat_th : ALL_FF;
assign is_EX = fn == `FN_EXT || fn == `FN_EXC;
assign reverse = cnt127[4];
assign is_AVG = fn == `FN_AVG;
assign add_data = reverse ? ans_buff[0] : ans_buff[15];
assign add_valid = |cnt127[6:4] | state == S_AVGC;
assign {sum_c, sum_8} = add_data + sum_buff[0] + carry_d;


always@(posedge clk or posedge rst) begin
    if(rst) cnt127 <= 0;
    else if(state == S_BUF1 || state == S_CLEAN) cnt127 <= 0;
    else cnt127 <= cnt127 + 1;
end


always@(posedge clk or posedge rst) begin // 0
    if(rst) ans_buff[0] <= 0;
    else if(is_AVG) begin
        if(reverse) ans_buff[0] <= ans_buff[1];
        else ans_buff[0] <= iot_d;
    end
    else begin
        if(clean) ans_buff[0] <= init_pat;
        else if(need_update) ans_buff[0] <= iot_d;
        else if(state != S_CLEAN) ans_buff[0] <= ans_buff[15];
    end
end
always@(posedge clk or posedge rst) begin
    if(rst) begin
        ans_buff[1]  <= 0;
        ans_buff[2]  <= 0;
        ans_buff[3]  <= 0;
        ans_buff[4]  <= 0;
        ans_buff[5]  <= 0;
        ans_buff[6]  <= 0;
        ans_buff[7]  <= 0;
        ans_buff[8]  <= 0;
        ans_buff[9]  <= 0;
        ans_buff[10] <= 0;
        ans_buff[11] <= 0;
        ans_buff[12] <= 0;
        ans_buff[13] <= 0;
        ans_buff[14] <= 0;
    end 
    else if(is_AVG) begin
        if(reverse) begin
            ans_buff[1]  <= ans_buff[2];
            ans_buff[2]  <= ans_buff[3];
            ans_buff[3]  <= ans_buff[4];
            ans_buff[4]  <= ans_buff[5];
            ans_buff[5]  <= ans_buff[6];
            ans_buff[6]  <= ans_buff[7];
            ans_buff[7]  <= ans_buff[8];
            ans_buff[8]  <= ans_buff[9];
            ans_buff[9]  <= ans_buff[10];
            ans_buff[10] <= ans_buff[11];
            ans_buff[11] <= ans_buff[12];
            ans_buff[12] <= ans_buff[13];
            ans_buff[13] <= ans_buff[14];
            ans_buff[14] <= ans_buff[15];
        end 
        else begin
            ans_buff[1]  <= ans_buff[0];
            ans_buff[2]  <= ans_buff[1];
            ans_buff[3]  <= ans_buff[2];
            ans_buff[4]  <= ans_buff[3];
            ans_buff[5]  <= ans_buff[4];
            ans_buff[6]  <= ans_buff[5];
            ans_buff[7]  <= ans_buff[6];
            ans_buff[8]  <= ans_buff[7];
            ans_buff[9]  <= ans_buff[8];
            ans_buff[10] <= ans_buff[9];
            ans_buff[11] <= ans_buff[10];
            ans_buff[12] <= ans_buff[11];
            ans_buff[13] <= ans_buff[12];
            ans_buff[14] <= ans_buff[13];
        end 
    end
    else begin
        if(clean) begin
            ans_buff[1]  <= init_pat;
            ans_buff[2]  <= init_pat;
            ans_buff[3]  <= init_pat;
            ans_buff[4]  <= init_pat;
            ans_buff[5]  <= init_pat;
            ans_buff[6]  <= init_pat;
            ans_buff[7]  <= init_pat;
            ans_buff[8]  <= init_pat;
            ans_buff[9]  <= init_pat;
            ans_buff[10] <= init_pat;
            ans_buff[11] <= init_pat;
            ans_buff[12] <= init_pat;
            ans_buff[13] <= init_pat;
            ans_buff[14] <= init_pat;
        end 
        else if(state != S_CLEAN) begin
            ans_buff[1]  <= ans_buff[0];
            ans_buff[2]  <= ans_buff[1];
            ans_buff[3]  <= ans_buff[2];
            ans_buff[4]  <= ans_buff[3];
            ans_buff[5]  <= ans_buff[4];
            ans_buff[6]  <= ans_buff[5];
            ans_buff[7]  <= ans_buff[6];
            ans_buff[8]  <= ans_buff[7];
            ans_buff[9]  <= ans_buff[8];
            ans_buff[10] <= ans_buff[9];
            ans_buff[11] <= ans_buff[10];
            ans_buff[12] <= ans_buff[11];
            ans_buff[13] <= ans_buff[12];
            ans_buff[14] <= ans_buff[13];
        end 
    end
end

always@(posedge clk or posedge rst) begin // 15
    if(rst) ans_buff[15] <= 0;
    else if(is_AVG) begin
        if(reverse) ans_buff[15] <= iot_d;
        else ans_buff[15] <= ans_buff[14];
    end
    else begin
        if(clean) ans_buff[15] <= init_pat;
        else if(state != S_CLEAN) ans_buff[15] <= ans_buff[14];
    end
end

always@(posedge clk or posedge rst) begin
    if(rst) continue <= 0;
    else if(&cnt127[3:0] || state == S_BUF1 || state == S_CLEAN) continue <= 0;
    else if(!continue & cond_conti) continue <= 1;
end
always@(posedge clk or posedge rst) begin 
    if(rst) stop <= 0;
    else if(&cnt127[3:0] || state == S_BUF1 || state == S_CLEAN) stop <= 0;
    else if(!stop & cond_stop) stop <= 1;
end

reg need_output_r;
wire need_output_w = need_output_r | continue;
always@(posedge clk or posedge rst) begin
    if(rst) need_output_r <= 0;
    else if(state == S_BUF1 || state == S_CLEAN) need_output_r <= 0;
    else if(is_EX && &cnt127[3:0]) need_output_r <= 0;
    else if(continue) need_output_r <= need_output_w;
end


reg out_valid; 
always@(posedge clk or posedge rst) begin 
    if(rst) out_valid <= 0;
    else if(is_AVG) begin
        if(state == S_AVGC && &cnt127[3:0]) out_valid <= 1;
        else out_valid <= 0;
    end 
    else if(&cnt127 || (is_EX && &cnt127[3:0])) out_valid <= need_output_w;
    else out_valid <= 0;
end

reg out_busy; 
always@(posedge clk or posedge rst) begin 
    if(rst) out_busy <= 0;
    else if(is_AVG) begin
        if((&cnt127[6:2] && |cnt127[1:0]) || (state == S_AVGC && !(&cnt127[3:1]))) 
            out_busy <= 1;
        else out_busy <= 0;
    end
    else if(cnt127 == 125) out_busy <= 1;
    else out_busy <= 0;
end

// ========= sum_buff ============ //
wire avg_clk = is_AVG ? clk : 0;

always@(posedge avg_clk) begin
	if(clean) begin
        sum_buff[0]  <= 0;
		sum_buff[1]  <= 0;
		sum_buff[2]  <= 0;
		sum_buff[3]  <= 0;
		sum_buff[4]  <= 0;
		sum_buff[5]  <= 0;
		sum_buff[6]  <= 0;
		sum_buff[7]  <= 0;
		sum_buff[8]  <= 0;
		sum_buff[9]  <= 0;
		sum_buff[10] <= 0;
		sum_buff[11] <= 0;
		sum_buff[12] <= 0;
		sum_buff[13] <= 0;
		sum_buff[14] <= 0;
	end 
	else if(add_valid) begin
        sum_buff[0]  <= sum_buff[1];
		sum_buff[1]  <= sum_buff[2];
		sum_buff[2]  <= sum_buff[3];
		sum_buff[3]  <= sum_buff[4];
		sum_buff[4]  <= sum_buff[5];
		sum_buff[5]  <= sum_buff[6];
		sum_buff[6]  <= sum_buff[7];
		sum_buff[7]  <= sum_buff[8];
		sum_buff[8]  <= sum_buff[9];
		sum_buff[9]  <= sum_buff[10];
		sum_buff[10] <= sum_buff[11];
		sum_buff[11] <= sum_buff[12];
		sum_buff[12] <= sum_buff[13];
		sum_buff[13] <= sum_buff[14];
		sum_buff[14] <= sum_buff[15];
	end 
end

always@(posedge avg_clk) begin // 15
	if(clean) sum_buff[15] <= 0;
	else if(add_valid) sum_buff[15] <= sum_8;
end


always@(posedge avg_clk) begin
	if(clean) sum_carry <= 0;
	else if(add_valid && &cnt127[3:0]) sum_carry <= sum_carry + sum_c;
end

always@(posedge avg_clk) begin
	if(clean) carry_d <= 0;
	else if(&cnt127[3:0]) carry_d <= 0;
	else if(add_valid) carry_d <= sum_c;
end

// =============== Output assignment ================== //
assign valid = out_valid;
assign busy = out_busy; 
assign iot_out = is_AVG ? mean : answer; 


endmodule
