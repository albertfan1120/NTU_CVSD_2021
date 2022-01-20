module Core (                       
	input          i_clk,
	input          i_reset,
//-------- for mul -----------	
	input   [31:0] i_inst_A,
    input   [15:0] i_inst_B,
    input   [ 1:0] i_idx,      // index of x need to update
    input          i_m_en,     // high when mul reciprocal
    input          i_s_en,
    input          i_s_last,   // last one need sub in one x
    input          i_zero, 
//-------- for x -------------
	input          i_b_ins,    // insert b to every x
    input  [ 63:0] i_b_ins_data,
    input          i_b_up,     // update b to x after x used all
    input  [  1:0] i_b_up_idx,
    input  [ 15:0] i_b_up_data,
    output [127:0] o_x_data,
//-------- for forwarding -------------
    output         o_sub_for_val,
    output [ 31:0] o_mul_forw,
    output [ 31:0] o_sub_forw
);
reg  [31:0] x     [0:3];
reg  [ 4:0] x_ext [0:3];
wire [36:0] x_com [0:3];
reg         x_mul_en  [0:3];
reg         x_sub_en  [0:3];
reg         x_b_up_en [0:3];
wire [ 2:0] cat;

//------------- D1 ------------------
reg  [ 1:0] idx_d1;
reg         m_en_d1;
reg         s_en_d1;
reg         s_last_d1;
reg         zero_d1;
reg  [31:0] inst_A_d1;
reg  [15:0] inst_B_d1;
wire [47:0] product_inst_d1;
wire        compute;

assign compute = i_m_en | i_s_en | !i_zero;
always@(posedge i_clk) begin
    m_en_d1 <= i_m_en;
    s_en_d1 <= i_s_en;
    s_last_d1 <= i_s_last;
    zero_d1 <= i_zero;
end

always@(posedge i_clk) begin
    if(compute) begin
        idx_d1  <= i_idx;
        inst_A_d1 <= i_inst_A;
        inst_B_d1 <= i_inst_B;
    end
end

assign product_inst_d1 = $signed(inst_A_d1) * $signed(inst_B_d1);
//------------- D2 ------------------
reg  [ 1:0] idx_d2;
reg         m_en_d2;
reg         s_en_d2;
reg         s_last_d2;
reg         zero_d2;
reg  [47:0] product_d2;
wire [47:0] product_t;
wire signed [36:0] sub_A_d2;
wire signed [31:0] sub_B_d2;
wire        [31:0] mul_inv_d2;
wire        [36:0] diff_inst_d2;
wire        [37:0] diff_inst_d2_38; 

always@(posedge i_clk) begin
    idx_d2    <= idx_d1;
    m_en_d2   <= m_en_d1;
    s_en_d2   <= s_en_d1;
    s_last_d2 <= s_last_d1;
    product_d2 <= product_inst_d1;
    zero_d2   <= zero_d1;
end

assign product_t = zero_d2 ? 0 : product_d2;
//------------- D3 ------------------
reg  [ 1:0] idx_d3;
reg         s_en_d3;
reg         s_last_d3;
reg  [36:0] diff_d3;
wire [31:0] diff32_d3;
wire        forward;

always@(posedge i_clk) begin
    diff_d3   <= diff_inst_d2;
    idx_d3    <= idx_d2;
    s_en_d3   <= s_en_d2;
    s_last_d3 <= s_last_d2;
end

//---------- Computation ---------------
IAS_48    ISA_mul(.i_data(product_t), .o_data(sub_B_d2));
IAS_37    ISA_sub(.i_data(diff_d3),   .o_data(diff32_d3));
IAS_Trun  ISA_inv(.i_data(product_t), .o_data(mul_inv_d2));

assign forward = (idx_d2 == idx_d3) && (s_en_d3 && s_en_d2);
assign sub_A_d2 = forward ? diff_d3 : x_com[idx_d2];
assign diff_inst_d2_38 = sub_A_d2 - sub_B_d2;
assign diff_inst_d2 = diff_inst_d2_38[36:0];

//-------- other -----------
assign cat = {s_en_d3, s_en_d2, s_en_d1};

genvar i;
generate
    for(i = 0; i < 4; i = i + 1) begin : x_com_gen
        assign x_com[i] = {x_ext[i], x[i]};
    end
endgenerate

generate
    for(i = 0; i < 4; i = i + 1) begin : x_gen // 0 ~ 15 
        always @(posedge i_clk or posedge i_reset) begin
            if(i_reset) x[i] <= 0;
            else if(i_b_ins) x[i] <= {i_b_ins_data[(16*i)+:16], 16'd0};
            else if(i_b_up && x_b_up_en[i])  x[i] <= {i_b_up_data, 16'd0};
            else if(m_en_d2 && x_mul_en[i])  x[i] <= mul_inv_d2;
            else if(s_en_d3 && x_sub_en[i])  begin
                if(s_last_d3) x[i] <= diff32_d3;
                else x[i] <= diff_d3[31:0];
            end
        end
    end
endgenerate

generate
    always @(posedge i_clk or posedge i_reset) begin
        if(i_reset) x_ext[0] <= 0;
        else if(i_b_ins) x_ext[0] <= {5{i_b_ins_data[15]}};
        else if(s_en_d3 && x_sub_en[0] && !s_last_d3) x_ext[0] <= diff_d3[36:32];
        else if(i_b_up && x_b_up_en[0]) x_ext[0] <= {5{i_b_up_data[15]}};
    end
    for(i = 1; i < 4; i = i + 1) begin : x_ext_gen // 1 ~ 15
        always @(posedge i_clk or posedge i_reset) begin
            if(i_reset) x_ext[i] <= 0;
            else if(s_en_d3 && x_sub_en[i] && !s_last_d3) x_ext[i] <= diff_d3[36:32];
            else if(i_b_up && x_b_up_en[i]) x_ext[i] <= {5{i_b_up_data[15]}};
        end
    end
endgenerate

always @(*) begin
    x_mul_en[0] = 0;
    x_mul_en[1] = 0;
    x_mul_en[2] = 0;
    x_mul_en[3] = 0;
    case(idx_d2)
        0: x_mul_en[0] = 1;
        1: x_mul_en[1] = 1;
        2: x_mul_en[2] = 1;
        3: x_mul_en[3] = 1;
    endcase
end

always @(*) begin
    x_sub_en[0] = 0;
    x_sub_en[1] = 0;
    x_sub_en[2] = 0;
    x_sub_en[3] = 0;
    case(idx_d3)
        0: x_sub_en[0] = 1;
        1: x_sub_en[1] = 1;
        2: x_sub_en[2] = 1;
        3: x_sub_en[3] = 1;
    endcase
end

always @(*) begin
    x_b_up_en[0] = 0;
    x_b_up_en[1] = 0;
    x_b_up_en[2] = 0;
    x_b_up_en[3] = 0;
    case(i_b_up_idx)
        0: x_b_up_en[0] = 1;
        1: x_b_up_en[1] = 1;
        2: x_b_up_en[2] = 1;
        3: x_b_up_en[3] = 1;
    endcase
end

// --------- output assignment ------------- //
assign o_x_data = {x[3], x[2], x[1], x[0]};
assign o_mul_forw = mul_inv_d2;
assign o_sub_forw = diff32_d3;
assign o_sub_for_val = &cat;

endmodule