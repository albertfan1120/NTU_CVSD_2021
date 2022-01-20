module IAS_Trun(                       
    input  [47:0]  i_data,
	output [31:0]  o_data
);
wire        sign;
wire        all_0;
wire        all_1;
wire        no_sat;
wire [ 2:0] upper;
wire [31:0] sat_pat;
wire [13:0] dummy; // for pass nLint

assign sign    = i_data[47];
assign upper   = i_data[47:45];
assign all_0   = !upper;
assign all_1   = &upper;
assign no_sat  = all_0 | all_1;
assign sat_pat = {sign, {31{!sign}}};
assign dummy   = i_data[13:0];

assign o_data = no_sat ? i_data[45:14] : sat_pat;

endmodule


module IAS_48 (                       
    input  [47:0]  i_data,
	output [31:0]  o_data
);
// MAX = 32'h7FFFFFFF;
// MIN = 32'h80000000;

wire                sign;
wire                all_0;
wire                all_1;
wire                no_sat;
wire [16:0] 		upper;
wire [31:0]         sat_pat;

assign sign    = i_data[47];
assign upper   = i_data[47:31];
assign all_0   = !upper;
assign all_1   = &upper;
assign no_sat  = all_0 | all_1;
assign sat_pat = {sign, {31{!sign}}};

assign o_data = no_sat ? i_data[31:0] : sat_pat;

endmodule


module IAS_37(                       
    input  [36:0]  	i_data,
	output [31:0]   o_data
);
// MAX = 32'h7FFFFFFF;
// MIN = 32'h80000000;

wire                sign;
wire                all_0;
wire                all_1;
wire                no_sat;
wire [5:0]          upper;
wire [31:0]         sat_pat;

assign sign    = i_data[36];
assign upper   = i_data[36:31];
assign all_0   = !upper;
assign all_1   = &upper;
assign no_sat  = all_0 | all_1;
assign sat_pat = {sign, {31{!sign}}};

assign o_data = no_sat ? i_data[31:0] : sat_pat;

endmodule