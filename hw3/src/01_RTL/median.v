module Median(
    input         i_clk,
    input         i_clear, // one cycle
	input  [23:0] i_data,
	output [23:0] o_median
);

reg  [7:0] sort_R_r [0:8];
reg  [7:0] sort_G_r [0:8];
reg  [7:0] sort_B_r [0:8];
wire [7:0] sort_R_w [0:8];
wire [7:0] sort_G_w [0:8];
wire [7:0] sort_B_w [0:8];

wire [7:0] red, green, blue;
wire [8:0] tag_R, tag_G, tag_B;


assign red   = i_data[23:16];
assign green = i_data[15:8];
assign blue  = i_data[7:0];

genvar idx;
generate
    for(idx = 0; idx < 9; idx = idx + 1) begin
        assign tag_R[idx] = red   > sort_R_r[idx];
        assign tag_G[idx] = green > sort_G_r[idx];
        assign tag_B[idx] = blue  > sort_B_r[idx];
    end
    for(idx = 0; idx < 8; idx = idx + 1) begin
        assign sort_R_w[idx] = (tag_R[idx+:2] == 2'b10) ? red   : 
                               (tag_R[idx+:2] == 2'b11) ? sort_R_r[idx] : sort_R_r[idx+1];
        assign sort_G_w[idx] = (tag_G[idx+:2] == 2'b10) ? green : 
                               (tag_G[idx+:2] == 2'b11) ? sort_G_r[idx] : sort_G_r[idx+1];
        assign sort_B_w[idx] = (tag_B[idx+:2] == 2'b10) ? blue  : 
                               (tag_B[idx+:2] == 2'b11) ? sort_B_r[idx] : sort_B_r[idx+1];
    end
    assign sort_R_w[8] = tag_R[8] ? sort_R_r[8] : red;
    assign sort_G_w[8] = tag_G[8] ? sort_G_r[8] : green;                  
    assign sort_B_w[8] = tag_B[8] ? sort_B_r[8] : blue; 
endgenerate


always@(posedge i_clk) begin
    if(i_clear) begin
        sort_R_r[0] = 8'd255;
        sort_G_r[0] = 8'd255;
        sort_B_r[0] = 8'd255;

        sort_R_r[1] = 8'd255;
        sort_G_r[1] = 8'd255;
        sort_B_r[1] = 8'd255;

        sort_R_r[2] = 8'd255;
        sort_G_r[2] = 8'd255;
        sort_B_r[2] = 8'd255;

        sort_R_r[3] = 8'd255;
        sort_G_r[3] = 8'd255;
        sort_B_r[3] = 8'd255;

        sort_R_r[4] = 8'd255;
        sort_G_r[4] = 8'd255;
        sort_B_r[4] = 8'd255;

        sort_R_r[5] = 8'd255;
        sort_G_r[5] = 8'd255;
        sort_B_r[5] = 8'd255;

        sort_R_r[6] = 8'd255;
        sort_G_r[6] = 8'd255;
        sort_B_r[6] = 8'd255;

        sort_R_r[7] = 8'd255;
        sort_G_r[7] = 8'd255;
        sort_B_r[7] = 8'd255;

        sort_R_r[8] = 8'd255;
        sort_G_r[8] = 8'd255;
        sort_B_r[8] = 8'd255;
    end
    else begin
        sort_R_r[0] = sort_R_w[0];
        sort_G_r[0] = sort_G_w[0];
        sort_B_r[0] = sort_B_w[0];

        sort_R_r[1] = sort_R_w[1];
        sort_G_r[1] = sort_G_w[1];
        sort_B_r[1] = sort_B_w[1];

        sort_R_r[2] = sort_R_w[2];
        sort_G_r[2] = sort_G_w[2];
        sort_B_r[2] = sort_B_w[2];

        sort_R_r[3] = sort_R_w[3];
        sort_G_r[3] = sort_G_w[3];
        sort_B_r[3] = sort_B_w[3];

        sort_R_r[4] = sort_R_w[4];
        sort_G_r[4] = sort_G_w[4];
        sort_B_r[4] = sort_B_w[4];

        sort_R_r[5] = sort_R_w[5];
        sort_G_r[5] = sort_G_w[5];
        sort_B_r[5] = sort_B_w[5];

        sort_R_r[6] = sort_R_w[6];
        sort_G_r[6] = sort_G_w[6];
        sort_B_r[6] = sort_B_w[6];

        sort_R_r[7] = sort_R_w[7];
        sort_G_r[7] = sort_G_w[7];
        sort_B_r[7] = sort_B_w[7];

        sort_R_r[8] = sort_R_w[8];
        sort_G_r[8] = sort_G_w[8];
        sort_B_r[8] = sort_B_w[8];
    end
end

assign o_median = {sort_R_r[4], sort_G_r[4], sort_B_r[4]};

endmodule