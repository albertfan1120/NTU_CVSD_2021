module data_mem #(                            
	parameter WORD_W = 32,    // word length in one memory
    parameter WORD_D = 64,    // numbers of memory in inst_mem
    parameter ADDR_W = 32     // numbers of bits in address
)(
	input                   i_clk,
	input                   i_rst_n,
	input                   i_wen,
	input      [ADDR_W-1:0] i_addr,
	input      [WORD_W-1:0] i_wdata,
	output reg [WORD_W-1:0] o_rdata
);

wire [5:0]        address;
reg  [WORD_W-1:0] memory_r [0:WORD_D-1];

assign address = i_addr[7:2];

integer i;
always @(posedge i_clk or negedge i_rst_n) begin
    if(!i_rst_n) begin
        for (i = 0; i < WORD_D; i = i + 1) 
            memory_r[i] <= 0;
    end else begin
        if(i_wen)
            memory_r[address] <= i_wdata;
        else 
            o_rdata <= memory_r[address];
    end
end

endmodule