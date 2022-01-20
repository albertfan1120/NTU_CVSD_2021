module alu(
    input               i_clk,
    input               i_rst_n,
    input               i_valid,
    input signed [11:0] i_data_a,
    input signed [11:0] i_data_b,
    input        [2:0]  i_inst,
    output              o_valid,
    output              o_overflow,
    output       [11:0] o_data
);
// ================================ ~ D1 ======================================= //
reg               valid_d1_r;
reg        [2:0]  inst_d1_r;
reg signed [11:0] data_a_d1_r, data_b_d1_r;
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        valid_d1_r  <= 0;
        inst_d1_r   <= 0;
        data_a_d1_r <= 0;
        data_b_d1_r <= 0;
    end else begin
        valid_d1_r  <= i_valid;
        inst_d1_r   <= i_inst;
        data_a_d1_r <= i_data_a;
        data_b_d1_r <= i_data_b;
    end
end

// =============================== D1 to D2 ======================================= //
reg                overflow_d2_w, overflow_d2_r;
reg                valid_d2_r;
reg                mac_overflow_d2_r, mac_overflow_d2_w;
reg         [11:0] alu_d2_w, alu_d2_r, mac_d2_w;
reg  signed [11:0] mac_d2_r;

wire               mul_overflow, mac_overflow;
wire        [11:0] abs_a, abs_b;
wire        [12:0] sum, diff;
wire signed [18:0] product_round;
wire        [19:0] mac_sum;
wire        [23:0] product;

parameter ADD  = 3'b000;
parameter SUB  = 3'b001;
parameter MUL  = 3'b010;
parameter MAC  = 3'b011;
parameter XNOR = 3'b100;
parameter RELU = 3'b101;
parameter MEAN = 3'b110;
parameter AMAX = 3'b111;

assign sum     = data_a_d1_r + data_b_d1_r;
assign diff    = data_a_d1_r - data_b_d1_r;
assign product = data_a_d1_r * data_b_d1_r;
assign abs_a   = data_a_d1_r[11] ? -data_a_d1_r : data_a_d1_r; 
assign abs_b   = data_b_d1_r[11] ? -data_b_d1_r : data_b_d1_r;
assign product_round = product[23:5] + product[4];
assign mul_overflow = !(&product_round[18:11] | !product_round[18:11]);
assign mac_sum = product_round + mac_d2_r;
assign mac_overflow = !(&mac_sum[19:11] | !mac_sum[19:11]) | mac_overflow_d2_r;

always@(*) begin
    mac_d2_w = 0;
    overflow_d2_w = 0;
    mac_overflow_d2_w = 0;
    case(inst_d1_r) 
        ADD: begin
            overflow_d2_w = sum[12] ^ sum[11];
            alu_d2_w = sum;
        end
        SUB: begin
            overflow_d2_w = diff[12] ^ diff[11];
            alu_d2_w = diff;
        end 
        MUL: begin
            overflow_d2_w = mul_overflow; 
            alu_d2_w = product_round[11:0];
        end
        MAC: begin
            overflow_d2_w = mac_overflow;
            mac_overflow_d2_w = mac_overflow;
            alu_d2_w = mac_sum[11:0];
            mac_d2_w = mac_sum[11:0];
        end
        XNOR: alu_d2_w = data_a_d1_r ~^ data_b_d1_r;
        RELU: alu_d2_w = data_a_d1_r[11] ? 0 : data_a_d1_r;
        MEAN: alu_d2_w = sum >>> 1;
        AMAX: alu_d2_w = (abs_a > abs_b) ? abs_a : abs_b;
    endcase
end

always@(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        alu_d2_r <= 0;
        overflow_d2_r <= 0;
        valid_d2_r <= 0;
        mac_d2_r <= 0;
        mac_overflow_d2_r <= 0;
    end else begin
        alu_d2_r <= alu_d2_w;
        overflow_d2_r <= overflow_d2_w;
        valid_d2_r <= valid_d1_r;
        if(valid_d1_r) begin
            mac_d2_r <= mac_d2_w;
            mac_overflow_d2_r <= mac_overflow_d2_w;
        end  
    end
end

// ================================ D2 ~ ======================================= //
// output assignment
assign o_valid    = valid_d2_r;
assign o_data     = alu_d2_r;
assign o_overflow = overflow_d2_r;

endmodule
