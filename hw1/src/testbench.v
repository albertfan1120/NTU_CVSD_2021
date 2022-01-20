`timescale 1ns/1ps
`define CYCLE       10.0
`define RST_DELAY   2
`define MAX_CYCLE   100000

`ifdef I0
    `define Inst_I  "./pattern/INST0_I.dat"
    `define Inst_O  "./pattern/INST0_O.dat"
    `define PAT_NUM 20
`elsif I1
    `define Inst_I  "./pattern/INST1_I.dat"
    `define Inst_O  "./pattern/INST1_O.dat"
    `define PAT_NUM 20
`elsif I2
    `define Inst_I  "./pattern/INST2_I.dat"
    `define Inst_O  "./pattern/INST2_O.dat"
    `define PAT_NUM 20
`elsif I3
    `define Inst_I  "./pattern/INST3_I.dat"
    `define Inst_O  "./pattern/INST3_O.dat"
    `define PAT_NUM 5
`elsif I4
    `define Inst_I  "./pattern/INST4_I.dat"
    `define Inst_O  "./pattern/INST4_O.dat"
    `define PAT_NUM 20
`elsif I5
    `define Inst_I  "./pattern/INST5_I.dat"
    `define Inst_O  "./pattern/INST5_O.dat"
    `define PAT_NUM 20
`elsif I6
    `define Inst_I  "./pattern/INST6_I.dat"
    `define Inst_O  "./pattern/INST6_O.dat"
    `define PAT_NUM 20
`elsif I7
    `define Inst_I  "./pattern/INST7_I.dat"
    `define Inst_O  "./pattern/INST7_O.dat"
    `define PAT_NUM 20
`elsif I8
    `define Inst_I  "./pattern/INST8_I.dat"
    `define Inst_O  "./pattern/INST8_O.dat"
    `define PAT_NUM 20
`elsif hidden
    `define Inst_I  "./hidden/hidden_I.dat"
    `define Inst_O  "./hidden/hidden_O.dat"
    `define PAT_NUM 10000
`else
    `define Inst_I  ""
    `define Inst_O  ""
    `define PAT_NUM 0
`endif




module tb;

    parameter INT_W  = 7;
    parameter FRAC_W = 5;
    parameter INST_W = 3;
    parameter DATA_W = INT_W + FRAC_W;

    reg                      i_clk;
    reg                      i_rst_n;
    reg                      i_valid;
    reg  signed [DATA_W-1:0] i_data_a;
    reg  signed [DATA_W-1:0] i_data_b;
    reg         [INST_W-1:0] i_inst;
    wire                     o_valid;
    wire signed [DATA_W-1:0] o_data;
    wire                     o_overflow;
    integer            i;
    integer            j;
    integer error;

    reg [2*DATA_W+INST_W-1:0] inst_idata [0:`PAT_NUM-1];
    reg [(DATA_W+1)-1:0]      inst_odata [0:`PAT_NUM-1];

    reg signed [DATA_W-1:0] test_inA  ;
    reg signed [DATA_W-1:0] test_inB  ;
    reg        [INST_W-1:0] test_inst ;
    reg                     test_outO ;
    reg signed [DATA_W-1:0] test_outD ;


    initial begin
        $readmemb(`Inst_I, inst_idata);
        $readmemb(`Inst_O, inst_odata);
    end


    alu u_alu (
        .i_clk          (i_clk      ),
        .i_rst_n        (i_rst_n    ),
        .i_valid        (i_valid    ),
        .i_data_a       (i_data_a   ),
        .i_data_b       (i_data_b   ),
        .i_inst         (i_inst     ),
        .o_valid        (o_valid    ),
        .o_data         (o_data     ),
        .o_overflow     (o_overflow )    
    );

    initial i_clk = 0;
    always #(`CYCLE/2.0) i_clk = ~i_clk; 
    initial begin
        $fsdbDumpfile("tb.fsdb");
        $fsdbDumpvars(0, tb, "+mda");
    end

    initial begin
        i        = 0;
        i_rst_n  = 1;
        i_valid  = 0;
        i_data_a = 0;
        i_data_b = 0;
        i_inst   = 0;
        reset;

        while (i < `PAT_NUM) begin
            @(negedge i_clk);
            i_valid = $random;
	    if (i_valid) begin
            	i_data_a = inst_idata[i][DATA_W-1          : 0];
            	i_data_b = inst_idata[i][2*DATA_W-1        : DATA_W];
            	i_inst   = inst_idata[i][2*DATA_W+INST_W-1 : 2*DATA_W+INST_W-3];
            	i = i + 1;
	    end
        end

	i_valid = 0;
    end

    initial begin
        j = 0;
        error = 0;
        while (j < `PAT_NUM) begin
            @(negedge i_clk);
            if (o_valid) begin
                test_inA  =  inst_idata[j][DATA_W-1          : 0     ];
                test_inB  =  inst_idata[j][2*DATA_W-1        : DATA_W];
                test_inst =  inst_idata[i][2*DATA_W+INST_W-1 : 2*DATA_W+INST_W-3];
                test_outO =  inst_odata[j][DATA_W];
                test_outD =  inst_odata[j][DATA_W-1          : 0     ];
                if (test_outO !== o_overflow) begin
                    $display (
                        "Test[%d]: Error! Inst=%b, A=%b, B=%b, Out=(%b, %b), yours=(%b, %b)", 
                        j, test_inst, test_inA, test_inB, test_outO, test_outD, o_overflow, o_data
                    );
                    error = error+1;
                end else if (test_outO == 0 && test_outD !== o_data) begin
                    $display (
                        "Test[%d]: Error! Inst=%b, A=%b, B=%b, Out=(%b, %b), yours=(%b, %b)", 
                        j, test_inst, test_inA, test_inB, test_outO, test_outD, o_overflow, o_data
                    );      
                    error = error+1;        
                end else if ((test_outD == o_data || test_outO !== 0) && test_outO == o_overflow) begin
                     $display("Test[%d]: Correct!", j);
                end else begin
                    $display("Test[%d]: Unknown output!!, Out=(%b, %b), yours=(%b, %b)", j, test_outO, test_outD, o_overflow, o_data);
                    error = error+1;
                end
                j = j + 1;
            end
        end

        $display("Pattern: ", `Inst_I);

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

    initial begin
        # (`MAX_CYCLE * `CYCLE);
        $display("----------------------------------------------");
        $display("Latency of your design is over 100000 cycles!!");
        $display("----------------------------------------------");
        $finish;
    end

    task reset; begin
        # ( 0.25 * `CYCLE);
        i_rst_n = 0;    
        # ((`RST_DELAY) * `CYCLE);
        i_rst_n = 1;    
    end endtask

endmodule
