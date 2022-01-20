`timescale 1ns/10ps
`define CYCLE       6.0     // CLK period.
`define HCYCLE      (`CYCLE/2)
`define MAX_CYCLE   100000
`define RST_DELAY   2

`ifdef tb0
    `define INFILE "../00_TESTBED/PATTERN/indata0.dat"
    `define OPFILE "../00_TESTBED/PATTERN/opmode0.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden0.dat"
    `define OPNUM  21
`elsif tb1
    `define INFILE "../00_TESTBED/PATTERN/indata1.dat"
    `define OPFILE "../00_TESTBED/PATTERN/opmode1.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden1.dat"
    `define OPNUM  21
`elsif tb2
    `define INFILE "../00_TESTBED/PATTERN/indata2.dat"
    `define OPFILE "../00_TESTBED/PATTERN/opmode2.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden2.dat"
    `define OPNUM  21
`elsif tb3
    `define INFILE "../00_TESTBED/PATTERN/indata3.dat"
    `define OPFILE "../00_TESTBED/PATTERN/opmode3.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden3.dat"
    `define OPNUM  21
`elsif hidden
    `define INFILE "../00_TESTBED/hidden/indata_hidden.dat"
    `define OPFILE "../00_TESTBED/hidden/opmode_hidden.dat"
    `define GOLDEN "../00_TESTBED/hidden/golden_hidden.dat"
    `define OPNUM  257
`else
    `define INFILE "../00_TESTBED/PATTERN/indata4.dat"
    `define OPFILE "../00_TESTBED/PATTERN/opmode4.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden4.dat"
    `define OPNUM  350
`endif

`define SDFFILE "../02_SYN/Netlist/ipdc_syn.sdf"  // Modify your sdf file name


module testbed;

reg clk, rst_n;
reg         op_valid;
reg  [ 3:0] op_mode;
wire        op_ready;
reg         in_valid;
reg  [23:0] in_data;
wire        in_ready;
wire        out_valid;
wire [23:0] out_data;

reg [23:0] indata_mem [0:255];
reg [ 3:0] opmode_mem [0:1000];
reg [23:0] golden_mem [0:5000];


integer i, j, k, error;
reg [23:0] display_data [0:5000];

// For gate-level simulation only
`ifdef SDF
    initial $sdf_annotate(`SDFFILE, u_ipdc);
    initial #1 $display("SDF File %s were used for this simulation.", `SDFFILE);
`endif


// Write out waveform file
initial begin
    $fsdbDumpfile("ipdc.fsdb");
    $fsdbDumpvars(3, "+mda");
end


ipdc u_ipdc(
    .i_clk(clk),
    .i_rst_n(rst_n),
    .i_op_valid(op_valid),
    .i_op_mode(op_mode),
    .o_op_ready(op_ready),
    .i_in_valid(in_valid),
    .i_in_data(in_data),
    .o_in_ready(in_ready),
    .o_out_valid(out_valid),
    .o_out_data(out_data)
);


// Read in test pattern and golden pattern
initial $readmemb(`INFILE, indata_mem);
initial $readmemb(`OPFILE, opmode_mem);
initial $readmemb(`GOLDEN, golden_mem);


// Clock generation
initial clk = 1'b0;
always begin #(`CYCLE/2) clk = ~clk; end


// Reset generation
initial begin
    rst_n = 1; # (0.25 * `CYCLE);

    rst_n = 0; 
    op_mode = 0;
    op_valid = 0;
    in_valid = 0;
    in_data = 0;
    # ((`RST_DELAY - 0.25) * `CYCLE);

    rst_n = 1; # (`MAX_CYCLE * `CYCLE);
    $display("Error! Runtime exceeded!");
    $finish;
end


// ============= Start processing !! ============ //
initial begin
    @(posedge rst_n)
    load_img;
    get_op_mode;

    if(error == 0) begin
            $display("----------------------------------------------");
            $display("-                 ALL PASS!                  -");
            $display("----------------------------------------------");
    end else begin
            $display("----------------------------------------------");
            $display("  Wrong! Total error: %d                      ", error);
            $display("----------------------------------------------");
    end
    # ( 2 * `CYCLE);
    $finish;
end



// =================== task ==================== //
reg loaded_img;
task load_img; begin
    loaded_img = 0;
    while(!loaded_img) begin
        @(negedge clk)
        if(op_ready) begin
            # `CYCLE;
            op_mode = opmode_mem[0];
            op_valid = 1;

            i = 0;
            while(i < 256) begin
                # `CYCLE;
                op_valid = 0;
                in_valid = 1;
                if(in_ready) begin
                    in_data = indata_mem[i];
                    i = i + 1;
                end
            end

            # `CYCLE;
            if(in_ready) begin
                in_valid = 0;
                in_data = 0;
                loaded_img = 1;
            end
            else begin
                # `CYCLE;
                in_valid = 0;
                in_data = 0;
                loaded_img = 1;
            end

        end
    end
end 
endtask



parameter R_SHIFT = 4'b0100;
parameter L_SHIFT = 4'b0101;
parameter U_SHIFT = 4'b0110;
parameter D_SHIFT = 4'b0111;
parameter SCALE_D = 4'b1000;
parameter SCALE_U = 4'b1001;
parameter MEDIAN  = 4'b1100;
parameter YCbCr   = 4'b1101;
parameter CENSUS  = 4'b1110;

parameter DIS_16 = 16;
parameter DIS_4  = 4;
parameter DIS_1  = 1;


integer origin;
integer x, y;
integer op_num = `OPNUM;
integer display_size = DIS_16;
integer gold_index;
task get_op_mode; begin
    k = 0;
    i = 1;
    gold_index = 0;
    error = 0;
    origin = 0;
    x = 0; y = 0;
    while(i < op_num) begin
        
        @(negedge clk)
        
        if(op_ready) begin
            # `CYCLE;
            op_valid = 1;
            op_mode = opmode_mem[i];
            
            get_dis_size;
            case(op_mode) // update origin
                R_SHIFT:begin
                    if(display_size == DIS_16 && (y + 1) <= 12) y = y + 1;
                    else if(display_size == DIS_4 && (y + 2) <= 13) y = y + 2;
                    else if(display_size == DIS_1 && (y + 4) <= 15) y = y + 4;
                end
                L_SHIFT:begin
                    if(display_size == DIS_16 && (y - 1) >= 0) y = y - 1;
                    else if(display_size == DIS_4 && (y - 2) >= 0) y = y - 2;
                    else if(display_size == DIS_1 && (y - 4) >= 0) y = y - 4;
                end
                U_SHIFT:begin
                    if(display_size == DIS_16 && (x - 1) >= 0) x = x - 1;
                    else if(display_size == DIS_4 && (x - 2) >= 0) x = x - 2;
                    else if(display_size == DIS_1 && (x - 4) >= 0) x = x - 4;
                end
                D_SHIFT:begin
                    if(display_size == DIS_16 && (x + 1) <= 12) x = x + 1;
                    else if(display_size == DIS_4 && (x + 2) <= 13) x = x + 2;
                    else if(display_size == DIS_1 && (x + 4) <= 15) x = x + 4;
                end
            endcase
            
            
            j = 0;
            //gold_index = k;
            while(j < display_size) begin
                # `CYCLE;
                op_valid = 0;
                op_mode = 0;
                if(out_valid)begin
                    display_data[k] = out_data;
                    k = k + 1;
                    j = j + 1;
                end
            end

            while(gold_index < k) begin
                if(golden_mem[gold_index] !== display_data[gold_index]) begin
                    $display("\n%0d'th OP", i);
                    $display("Test[%d]: Error! OP=%b, golden=(%b), yours=(%b)", 
                    gold_index, opmode_mem[i], golden_mem[gold_index], 
                    display_data[gold_index]);

                    error = error + 1;
                end
                gold_index = gold_index + 1;
            end

            i = i + 1;
            
        end
    end
end
endtask


task get_dis_size; begin
    if(op_mode == SCALE_D) begin 
        if(display_size == DIS_16) display_size = DIS_4;
        else if(display_size == DIS_4) display_size = DIS_1;
    end else if(op_mode == SCALE_U) begin       
        if(display_size == DIS_4) begin
            if(x <= 12 && y <= 12) display_size = DIS_16;
        end else if(display_size == DIS_1) begin
            if(x <= 13 && y <= 13) display_size = DIS_4;
        end
    end
end
endtask


endmodule
