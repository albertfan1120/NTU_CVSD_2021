module Buffer (
    input          i_clk,
    input          i_reset,
    input          i_valid,
    input  [255:0] i_data,
    output [255:0] o_data
);
reg [255:0] data;

assign o_data = data;

always @(posedge i_clk or posedge i_reset) begin
    if(i_reset) data <= 0;
    else if(i_valid) data <= i_data;
end

endmodule