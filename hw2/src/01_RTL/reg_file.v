module reg_file #(                            
	parameter WORD_W = 32,  // word length in one register
    parameter WORD_D = 32,  // numbers of registers in reg_file
	parameter ADDR_B = 5    // 2^ADDR_B >= WORD_D
)(  
    input               i_clk, 
    input               i_rst_n, 
//---------- for read in reg_file --------------
    input  [ADDR_B-1:0] i_read_addr1,
    input  [ADDR_B-1:0] i_read_addr2,
    output [WORD_W-1:0] o_read_data1,
    output [WORD_W-1:0] o_read_data2,
//---------- for write in reg_file -------------	
    input               i_wen,
    input  [ADDR_B-1:0] i_write_addr,
    input  [WORD_W-1:0] i_write_data
);

reg  [WORD_W-1:0] memory_r [0:WORD_D-1];

integer i;
always@(posedge i_clk or negedge i_rst_n) begin
    if (!i_rst_n) begin
        for (i = 0; i < WORD_D; i = i + 1) 
            memory_r[i] <= 0;
    end
    else begin
        if (i_wen) begin
            memory_r[i_write_addr] <= i_write_data;
        end
    end       
end

// output assignment
assign o_read_data1 = memory_r[i_read_addr1];
assign o_read_data2 = memory_r[i_read_addr2];

endmodule