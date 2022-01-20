module inst_mem #(                            
	parameter WORD_W = 32,    // word length in one memory
    parameter WORD_D = 1024,  // numbers of memory in inst_mem
    parameter ADDR_W = 32     // numbers of bits in address
)(
	input                   i_clk,
	input                   i_rst_n,
	input      [ADDR_W-1:0] i_addr,
	output reg [WORD_W-1:0] o_inst
);	

wire [9:0]        address;
reg  [WORD_W-1:0] memory_r [0:WORD_D-1]; // initalize in tb

assign address = i_addr[11:2];

always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        o_inst <= 0;
    end else begin
        o_inst <= memory_r[address];
    end
end

endmodule