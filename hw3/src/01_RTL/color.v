module Color_trans(
	input  [23:0] i_rgb,
	output [23:0] o_ycbcr
);

wire [ 7:0] red, green, blue, y, cb, cr;
wire [ 9:0] temp_y;
wire [10:0] temp_cb, temp_cr;
wire [10:0] const_128;

assign red   = i_rgb[23:16];
assign green = i_rgb[15: 8];
assign blue  = i_rgb[ 7: 0];
assign const_128 = 11'b10000000000;

assign temp_y  = {2'd0, red} + {1'd0, green, 1'd0} + {3'd0, green[7:1]};
assign temp_cb = const_128 + {1'b0, blue, 2'd0} - {2'b0, green, 1'd0} - {3'b0, red};
assign temp_cr = const_128 + {1'b0, red, 2'd0} - {2'b0, green, 1'd0} 
			   - {3'b0, green} - {3'b0, blue};

assign y  = temp_y[9:2] + temp_y[1];
assign cb = &temp_cb[10:2] ? 8'd255 : temp_cb[10:3] + temp_cb[2];
assign cr = &temp_cr[10:2] ? 8'd255 : temp_cr[10:3] + temp_cr[2];

assign o_ycbcr = {y, cb, cr};

endmodule