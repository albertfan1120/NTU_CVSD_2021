`timescale 1ns/10ps
`define CYCLE    3.4   	     
`define SDFFILE  "../02_SYN/Netlist/GSIM_syn.sdf"
`define APRFILE  "../05_APR/GSIM_pr.sdf"	               // Modify your sdf file name	               
`define MAX_CYCLE   10000000
`define RST_DELAY   1.25
`define DEL_I 1
`define DEL_O 0.5

`ifdef tb1
    `define INFILE "../00_TESTBED/PATTERN/indata1.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden1.dat"
    `define MATRIXNUM 31
`elsif tb2
    `define INFILE "../00_TESTBED/PATTERN/indata2.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden2.dat"
    `define MATRIXNUM 8
`elsif tb3
    `define INFILE "../00_TESTBED/PATTERN/indata3.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden3.dat"
    `define MATRIXNUM 31
`elsif tb4
    `define INFILE "../00_TESTBED/PATTERN/indata4.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden4.dat"
    `define MATRIXNUM 3
`else
    `define INFILE "../00_TESTBED/PATTERN/indata0.dat"
    `define GOLDEN "../00_TESTBED/PATTERN/golden0.dat"
    `define MATRIXNUM 16
`endif


module testbed;

reg          clk;
reg          reset;
reg          module_en;
reg  [  4:0] matrix_num;
wire         proc_done;

// matrix memory
wire         mem_rreq;
wire [  9:0] mem_addr;
reg          mem_rrdy;
reg [255:0] mem_dout;
reg          mem_dout_vld;

// output result
wire         x_wen;
wire [  8:0] x_addr;
wire [ 31:0] x_data; 
reg  [ 31:0] x_out [0:1023];
reg  [ 31:0] x_golden [0:1023];
reg fail;

reg rrdy_r;
reg [9:0] mem_addr_w;
reg mem_rreq_w;
reg dout_vld_r, dout_vld_w;
wire [255:0] matrix_data_w;

integer i, j, k;

always @(posedge clk) begin
    #(`CYCLE-`DEL_O);
    if (x_wen) begin
        x_out [x_addr] <= x_data;
    end
end

`ifdef SDF
    initial begin
	$display ("SDF file for used : %s", `SDFFILE);
	$sdf_annotate(`SDFFILE, u_GSIM);
    end
    initial #1 $display("SDF File %s were used for this simulation.", `SDFFILE);
`elsif APR
    initial begin
	$display ("SDF file for used : %s", `APRFILE);
	$sdf_annotate(`APRFILE, u_GSIM);
    end
    initial #1 $display("SDF File %s were used for this simulation.", `APRFILE);
`endif

// Write out waveform file
initial begin
`ifdef VCS
`elsif SDF
  $fsdbDumpfile("gsim.fsdb");
  $fsdbDumpvars(0, "+mda");
  $fsdbDumpMDA;
`else
  $fsdbDumpfile("gsim.fsdb");
  $fsdbDumpvars(0, "+mda");
  $fsdbDumpMDA;
`endif
end

initial $readmemh (`INFILE, u_matrix_mem.mem_r);
initial $readmemh (`GOLDEN, x_golden);

GSIM u_GSIM(
	.i_clk(clk),
	.i_reset(reset),
	.i_module_en(module_en),
    .i_matrix_num(matrix_num),
	.o_proc_done(proc_done),

    .o_mem_rreq(mem_rreq),
	.o_mem_addr(mem_addr),
	.i_mem_rrdy(mem_rrdy),
    .i_mem_dout(mem_dout),
    .i_mem_dout_vld(mem_dout_vld),

    .o_x_wen(x_wen),
	.o_x_addr(x_addr),
	.o_x_data(x_data)  
);

matrix_mem u_matrix_mem(
	.i_clk(clk),
	.i_rst(reset),
	.i_addr(mem_addr_w),
	.o_data(matrix_data_w)
);


//Clk generation
initial clk = 1'b0;
always begin #(`CYCLE/2) clk = ~clk; end



initial begin
    fail = 0;
    reset = 0;
    module_en = 0;
    matrix_num = 0;
    mem_rrdy =1;
    mem_dout_vld = 0;
    mem_dout = 0;   
    task_reset;

    # 1000;
    @(posedge clk);
    #`DEL_I;
    module_en  = 1;
    matrix_num = `MATRIXNUM;
    mem_rrdy   = rrdy_r;

    while (!proc_done) begin
        @(posedge clk);
        #`DEL_I; 
        mem_rrdy = rrdy_r;
        mem_dout_vld = dout_vld_r;
        mem_dout = (dout_vld_r)? matrix_data_w : 0;

    end
    @(posedge clk);
    #`DEL_I module_en = 0;
    
    if (proc_done == 1'b0) begin
        $display (" ------ Error: You can't pull down o_proc_done before i_module_en = 0!! ------ ");
        $finish;
    end
    
    while (proc_done) begin
        @(posedge clk);
    end
    fail = 0;
    for (i = 0; i < matrix_num; i = i + 1) begin
        for (j = 0; j < 16 && ~fail; j = j + 1) begin    
            if (x_golden [i*16+j] !== x_out [i*16+j]) begin
                fail = 1;
                $display (" ------ Fail at matrix solution: %2d ------\n", i);
                for (k = 0; k < 16; k = k + 1) begin
                    $display ("Expected output : %h Your output %h\n", x_golden [i*16+k], x_out [i*16+k]);
                end
            end

        end
    end
    if (!fail) begin
        YOU_PASS_TASK;
        $display (" ------ Congratulation! You have pass all the pattern! ------\n");
    end else begin
        YOU_FAIL_TASK;
        $display (" ------ Failed, Don't give up! ------\n");
    end
    #1000;
    $finish;
end



initial begin
    # (`MAX_CYCLE * `CYCLE);
    $display("Error! Runtime exceeded!");
    $finish;
end


//get output
initial begin
    mem_addr_w = 0;
    mem_rreq_w = 0;
    dout_vld_w = 0;
    while (module_en == 1'b0) begin
        @(posedge clk);
    end
    #(`CYCLE-`DEL_O);
    mem_addr_w = mem_addr;
    mem_rreq_w = mem_rreq;
    if (mem_rreq && rrdy_r) dout_vld_w = 1;
    else dout_vld_w = 0;
    while (module_en == 1'b1)begin
        @(posedge clk);
        #(`CYCLE-`DEL_O);
        mem_addr_w = mem_addr;
        mem_rreq_w = mem_rreq;
        if (mem_rreq && rrdy_r) dout_vld_w = 1;
        else dout_vld_w = 0;
    end

end

// Reset generation
task task_reset; begin
        # ( 0.75 * `CYCLE);
        reset = 1;    
        # ((`RST_DELAY - 0.25) * `CYCLE);
        reset = 0;    
end endtask

// i_dout_vld simulation 
always @(posedge clk or posedge reset)  begin
    if(reset)    dout_vld_r <= 0;
    else dout_vld_r <= dout_vld_w;
end

// i_mem_rrdy simulation (modify here)
parameter FIFTY_PROB = 1; // modify to 0 when you want different probability
parameter PROB = 20; // 0 ~ 255
parameter MASK = 8'b11111111;
always @(posedge clk or posedge reset)  begin
    if(reset)    rrdy_r <= 1;
    else if(FIFTY_PROB) rrdy_r <= ~$random;
    else rrdy_r <= ($random & MASK) < PROB;
end

// ----------------- task ------------------ //

task YOU_PASS_TASK;begin
    $display("                                                             \033[33m`-                                                                            ");        
    $display("                                                             /NN.                                                                           ");        
    $display("                                                            sMMM+                                                                           ");        
    $display(" .``                                                       sMMMMy                                                                           ");        
    $display(" oNNmhs+:-`                                               oMMMMMh                                                                           ");        
    $display("  /mMMMMMNNd/:-`                                         :+smMMMh                                                                           ");        
    $display("   .sNMMMMMN::://:-`                                    .o--:sNMy                                                                           ");        
    $display("     -yNMMMM:----::/:-.                                 o:----/mo                                                                           ");        
    $display("       -yNMMo--------://:.                             -+------+/                                                                           ");        
    $display("         .omd/::--------://:`                          o-------o.                                                                           ");        
    $display("           `/+o+//::-------:+:`                       .+-------y                                                                            ");        
    $display("              .:+++//::------:+/.---------.`          +:------/+                                                                            ");        
    $display("                 `-/+++/::----:/:::::::::::://:-.     o------:s.          \033[37m:::::----.           -::::.          `-:////:-`     `.:////:-.    \033[33m");        
    $display("                    `.:///+/------------------:::/:- `o-----:/o          \033[37m.NNNNNNNNNNds-       -NNNNNd`       -smNMMMMMMNy   .smNNMMMMMNh    \033[33m");        
    $display("                         :+:----------------------::/:s-----/s.          \033[37m.MMMMo++sdMMMN-     `mMMmMMMs      -NMMMh+///oys  `mMMMdo///oyy    \033[33m");        
    $display("                        :/---------------------------:++:--/++           \033[37m.MMMM.   `mMMMy     yMMM:dMMM/     +MMMM:      `  :MMMM+`     `    \033[33m");        
    $display("                       :/---///:-----------------------::-/+o`           \033[37m.MMMM.   -NMMMo    +MMMs -NMMm.    .mMMMNdo:.     `dMMMNds/-`      \033[33m");        
    $display("                      -+--/dNs-o/------------------------:+o`            \033[37m.MMMMyyyhNMMNy`   -NMMm`  sMMMh     .odNMMMMNd+`   `+dNMMMMNdo.    \033[33m");        
    $display("                     .o---yMMdsdo------------------------:s`             \033[37m.MMMMNmmmdho-    `dMMMdooosMMMM+      `./sdNMMMd.    `.:ohNMMMm-   \033[33m");        
    $display("                    -yo:--/hmmds:----------------//:------o              \033[37m.MMMM:...`       sMMMMMMMMMMMMMN-  ``     `:MMMM+ ``      -NMMMs   \033[33m");        
    $display("                   /yssy----:::-------o+-------/h/-hy:---:+              \033[37m.MMMM.          /MMMN:------hMMMd` +dy+:::/yMMMN- :my+:::/sMMMM/   \033[33m");        
    $display("                  :ysssh:------//////++/-------sMdyNMo---o.              \033[37m.MMMM.         .mMMMs       .NMMMs /NMMMMMMMMmh:  -NMMMMMMMMNh/    \033[33m");        
    $display("                  ossssh:-------ddddmmmds/:----:hmNNh:---o               \033[37m`::::`         .::::`        -:::: `-:/++++/-.     .:/++++/-.      \033[33m");        
    $display("                  /yssyo--------dhhyyhhdmmhy+:---://----+-                                                                                  ");        
    $display("                  `yss+---------hoo++oosydms----------::s    `.....-.                                                                       ");        
    $display("                   :+-----------y+++++++oho--------:+sssy.://:::://+o.                                                                      ");        
    $display("                    //----------y++++++os/--------+yssssy/:--------:/s-                                                                     ");        
    $display("             `..:::::s+//:::----+s+++ooo:--------+yssssy:-----------++                                                                      ");        
    $display("           `://::------::///+/:--+soo+:----------ssssys/---------:o+s.``                                                                    ");        
    $display("          .+:----------------/++/:---------------:sys+----------:o/////////::::-...`                                                        ");        
    $display("          o---------------------oo::----------::/+//---------::o+--------------:/ohdhyo/-.``                                                ");        
    $display("          o---------------------/s+////:----:://:---------::/+h/------------------:oNMMMMNmhs+:.`                                           ");        
    $display("          -+:::::--------------:s+-:::-----------------:://++:s--::------------::://sMMMMMMMMMMNds/`                                        ");        
    $display("           .+++/////////////+++s/:------------------:://+++- :+--////::------/ydmNNMMMMMMMMMMMMMMmo`                                        ");        
    $display("             ./+oo+++oooo++/:---------------------:///++/-   o--:///////::----sNMMMMMMMMMMMMMMMmo.                                          ");        
    $display("                o::::::--------------------------:/+++:`    .o--////////////:--+mMMMMMMMMMMMMmo`                                            ");        
    $display("               :+--------------------------------/so.       +:-:////+++++///++//+mMMMMMMMMMmo`                                              ");        
    $display("              .s----------------------------------+: ````` `s--////o:.-:/+syddmNMMMMMMMMMmo`                                                ");        
    $display("              o:----------------------------------s. :s+/////--//+o-       `-:+shmNNMMMNs.                                                  ");        
    $display("             //-----------------------------------s` .s///:---:/+o.               `-/+o.                                                    ");        
    $display("            .o------------------------------------o.  y///+//:/+o`                                                                          ");        
    $display("            o-------------------------------------:/  o+//s//+++`                                                                           ");        
    $display("           //--------------------------------------s+/o+//s`                                                                                ");        
    $display("          -+---------------------------------------:y++///s                                                                                 ");        
    $display("          o-----------------------------------------oo/+++o                                                                                 ");        
    $display("         `s-----------------------------------------:s   ``                                                                                 ");        
    $display("          o-:::::------------------:::::-------------o.                                                                                     ");        
    $display("          .+//////////::::::://///////////////:::----o`                                                                                     ");        
    $display("          `:soo+///////////+++oooooo+/////////////:-//                                                                                      ");        
    $display("       -/os/--:++/+ooo:::---..:://+ooooo++///////++so-`                                                                                     ");        
    $display("      syyooo+o++//::-                 ``-::/yoooo+/:::+s/.                                                                                  ");        
    $display("       `..``                                `-::::///:++sys:                                                                                ");        
    $display("                                                    `.:::/o+  \033[37m                                                                      ");
end endtask


task YOU_FAIL_TASK; begin
    $display("\033[33m	                                                         .:                                                                                         ");      
    $display("                                                   .:                                                                                                 ");
    $display("                                                  --`                                                                                                 ");
    $display("                                                `--`                                                                                                  ");
    $display("                 `-.                            -..        .-//-                                                                                      ");
    $display("                  `.:.`                        -.-     `:+yhddddo.                                                                                    ");
    $display("                    `-:-`             `       .-.`   -ohdddddddddh:                                                                                   ");
    $display("                      `---`       `.://:-.    :`- `:ydddddhhsshdddh-                       \033[31m.yhhhhhhhhhs       /yyyyy`       .yhhy`   +yhyo           \033[33m");
    $display("                        `--.     ./////:-::` `-.--yddddhs+//::/hdddy`                      \033[31m-MMMMNNNNNNh      -NMMMMMs       .MMMM.   sMMMh           \033[33m");
    $display("                          .-..   ////:-..-// :.:oddddho:----:::+dddd+                      \033[31m-MMMM-......     `dMMmhMMM/      .MMMM.   sMMMh           \033[33m");
    $display("                           `-.-` ///::::/::/:/`odddho:-------:::sdddh`                     \033[31m-MMMM.           sMMM/.NMMN.     .MMMM.   sMMMh           \033[33m");
    $display("             `:/+++//:--.``  .--..+----::://o:`osss/-.--------::/dddd/             ..`     \033[31m-MMMMysssss.    /MMMh  oMMMh     .MMMM.   sMMMh           \033[33m");
    $display("             oddddddddddhhhyo///.-/:-::--//+o-`:``````...------::dddds          `.-.`      \033[31m-MMMMMMMMMM-   .NMMN-``.mMMM+    .MMMM.   sMMMh           \033[33m");
    $display("            .ddddhhhhhddddddddddo.//::--:///+/`.````````..``...-:ddddh       `.-.`         \033[31m-MMMM:.....`  `hMMMMmmmmNMMMN-   .MMMM.   sMMMh           \033[33m");
    $display("            /dddd//::///+syhhdy+:-`-/--/////+o```````.-.......``./yddd`   `.--.`           \033[31m-MMMM.        oMMMmhhhhhhdMMMd`  .MMMM.   sMMMh```````    \033[33m");
    $display("            /dddd:/------:://-.`````-/+////+o:`````..``     `.-.``./ym.`..--`              \033[31m-MMMM.       :NMMM:      .NMMMs  .MMMM.   sMMMNmmmmmms    \033[33m");
    $display("            :dddd//--------.`````````.:/+++/.`````.` `.-      `-:.``.o:---`                \033[31m.dddd`       yddds        /dddh. .dddd`   +ddddddddddo    \033[33m");
    $display("            .ddddo/-----..`........`````..```````..  .-o`       `:.`.--/-      ``````````` \033[31m ````        ````          ````   ````     ``````````     \033[33m");
    $display("             ydddh/:---..--.````.`.-.````````````-   `yd:        `:.`...:` `................`                                                         ");
    $display("             :dddds:--..:.     `.:  .-``````````.:    +ys         :-````.:...```````````````..`                                                       ");
    $display("              sdddds:.`/`      ``s.  `-`````````-/.   .sy`      .:.``````-`````..-.-:-.````..`-                                                       ");
    $display("              `ydddd-`.:       `sh+   /:``````````..`` +y`   `.--````````-..---..``.+::-.-``--:                                                       ");
    $display("               .yddh``-.        oys`  /.``````````````.-:.`.-..`..```````/--.`      /:::-:..--`                                                       ");
    $display("                .sdo``:`        .sy. .:``````````````````````````.:```...+.``       -::::-`.`                                                         ");
    $display(" ````.........```.++``-:`        :y:.-``````````````....``.......-.```..::::----.```  ``                                                              ");
    $display("`...````..`....----:.``...````  ``::.``````.-:/+oosssyyy:`.yyh-..`````.:` ````...-----..`                                                             ");
    $display("                 `.+.``````........````.:+syhdddddddddddhoyddh.``````--              `..--.`                                                          ");
    $display("            ``.....--```````.```````.../ddddddhhyyyyyyyhhhddds````.--`             ````   ``                                                          ");
    $display("         `.-..``````-.`````.-.`.../ss/.oddhhyssssooooooossyyd:``.-:.         `-//::/++/:::.`                                                          ");
    $display("       `..```````...-::`````.-....+hddhhhyssoo+++//////++osss.-:-.           /++++o++//s+++/                                                          ");
    $display("     `-.```````-:-....-/-``````````:hddhsso++/////////////+oo+:`             +++::/o:::s+::o            \033[31m     `-/++++:-`                              \033[33m");
    $display("    `:````````./`  `.----:..````````.oysso+///////////////++:::.             :++//+++/+++/+-            \033[31m   :ymMMMMMMMMms-                            \033[33m");
    $display("    :.`-`..```./.`----.`  .----..`````-oo+////////////////o:-.`-.            `+++++++++++/.             \033[31m `yMMMNho++odMMMNo                           \033[33m");
    $display("    ..`:..-.`.-:-::.`        `..-:::::--/+++////////////++:-.```-`            +++++++++o:               \033[31m hMMMm-      /MMMMo  .ssss`/yh+.syyyyyyyyss. \033[33m");
    $display("     `.-::-:..-:-.`                 ```.+::/++//++++++++:..``````:`          -++++++++oo                \033[31m:MMMM:        yMMMN  -MMMMdMNNs-mNNNNNMMMMd` \033[33m");
    $display("        `   `--`                        /``...-::///::-.`````````.: `......` ++++++++oy-                \033[31m+MMMM`        +MMMN` -MMMMh:--. ````:mMMNs`  \033[33m");
    $display("           --`                          /`````````````````````````/-.``````.::-::::::/+                 \033[31m:MMMM:        yMMMm  -MMMM`       `oNMMd:    \033[33m");
    $display("          .`                            :```````````````````````--.`````````..````.``/-                 \033[31m dMMMm:`    `+MMMN/  -MMMN       :dMMNs`     \033[33m");
    $display("                                        :``````````````````````-.``.....````.```-::-.+                  \033[31m `yNMMMdsooymMMMm/   -MMMN     `sMMMMy/////` \033[33m");
    $display("                                        :.````````````````````````-:::-::.`````-:::::+::-.`             \033[31m   -smNMMMMMNNd+`    -NNNN     hNNNNNNNNNNN- \033[33m");
    $display("                                `......../```````````````````````-:/:   `--.```.://.o++++++/.           \033[31m      .:///:-`       `----     ------------` \033[33m");
    $display("                              `:.``````````````````````````````.-:-`      `/````..`+sssso++++:                                                        ");
    $display("                              :`````.---...`````````````````.--:-`         :-````./ysoooss++++.                                                       ");
    $display("                              -.````-:/.`.--:--....````...--:/-`            /-..-+oo+++++o++++.                                                       ");
    $display("             `:++/:.`          -.```.::      `.--:::::://:::::.              -:/o++++++++s++++                                                        ");
    $display("           `-+++++++++////:::/-.:.```.:-.`              :::::-.-`               -+++++++o++++.                                                        ");
    $display("           /++osoooo+++++++++:`````````.-::.             .::::.`-.`              `/oooo+++++.                                                         ");
    $display("           ++oysssosyssssooo/.........---:::               -:::.``.....`     `.:/+++++++++:                                                           ");
    $display("           -+syoooyssssssyo/::/+++++/+::::-`                 -::.``````....../++++++++++:`                                                            ");
    $display("             .:///-....---.-..-.----..`                        `.--.``````````++++++/:.                                                               ");
    $display("                                                                   `........-:+/:-.`                                                            \033[37m      ");
end endtask

endmodule


module matrix_mem (
	input             i_clk,
	input             i_rst,
	input  [ 9  : 0 ] i_addr,
	output [ 255: 0 ] o_data
);	

	reg  [     255:0] mem_r [0:1023];
	reg  [     255:0] data_w, data_r;
	wire [9:0] vaddr;
	integer i;



	assign o_data = data_r;
	assign vaddr = i_addr;

	always@(*) begin
		data_w = mem_r[vaddr];
	end

	always@(posedge i_clk or posedge i_rst) begin
		if(i_rst)    data_r <= {256{1'b0}};
		else         data_r <=  data_w;
	end

endmodule
