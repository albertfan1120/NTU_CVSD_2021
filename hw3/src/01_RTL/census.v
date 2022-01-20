module Census(
    input         i_clk,
    input         i_start, // one cycle
	input  [23:0] i_data,
	output [23:0] o_data
);

wire [ 7:0] red, green, blue;
wire [23:0] result;

reg  [ 7:0] center_R, center_G, center_B;
reg         result_R [0:7];
reg         result_G [0:7];
reg         result_B [0:7];


assign red   = i_data[23:16];
assign green = i_data[15:8];
assign blue  = i_data[7:0];

assign result = {result_R[0], result_R[1], result_R[2], result_R[3], 
                 result_R[4], result_R[5], result_R[6], result_R[7],
                 result_G[0], result_G[1], result_G[2], result_G[3], 
                 result_G[4], result_G[5], result_G[6], result_G[7],
                 result_B[0], result_B[1], result_B[2], result_B[3], 
                 result_B[4], result_B[5], result_B[6], result_B[7]};


always@(posedge i_clk) begin
    if(i_start) begin
        center_R <= red;
        center_G <= green;
        center_B <= blue;
    end 

    result_R[7] <= center_R < red;
    result_G[7] <= center_G < green;
    result_B[7] <= center_B < blue;

    result_R [0] <= result_R[1];
    result_G [0] <= result_G[1];
    result_B [0] <= result_B[1];

    result_R [1] <= result_R[2];
    result_G [1] <= result_G[2];
    result_B [1] <= result_B[2];

    result_R [2] <= result_R[3];
    result_G [2] <= result_G[3];
    result_B [2] <= result_B[3];

    result_R [3] <= result_R[4];
    result_G [3] <= result_G[4];
    result_B [3] <= result_B[4];

    result_R [4] <= result_R[5];
    result_G [4] <= result_G[5];
    result_B [4] <= result_B[5];

    result_R [5] <= result_R[6];
    result_G [5] <= result_G[6];
    result_B [5] <= result_B[6];

    result_R [6] <= result_R[7];
    result_G [6] <= result_G[7];
    result_B [6] <= result_B[7];
end

assign o_data = result;

endmodule