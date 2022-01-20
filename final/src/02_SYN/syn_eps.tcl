# Setting environment
sh mkdir -p Netlist_eps
sh mkdir -p Report_eps

set company {NTUGIEE}
set designer {Student}

set search_path      ". /home/raid7_2/course/cvsd/CBDK_IC_Contest/CIC/SynopsysDC/db  $search_path ../ ./"
set target_library   "slow.db"              
set link_library     "* $target_library dw_foundation.sldb"
set symbol_library   "tsmc13.sdb generic.sdb"
set synthetic_library "dw_foundation.sldb"

# Setting physical lib for EPS flow
set_tlu_plus_files -max_tluplus /home/raid7_2/course/cvsd/CBDK_IC_Contest_v2.5/ICC2/tluplus/t013s8mg_fsg_typical.tluplus -tech2itf_map /home/raid7_2/course/cvsd/CBDK_IC_Contest_v2.5/ICC2/tluplus/t013s8mg_fsg.map
create_mw_lib -technology /home/raid7_2/course/cvsd/CBDK_IC_Contest_v2.5/Astro/tsmc13_CIC.tf -mw_reference_library /home/raid7_2/course/cvsd/CBDK_IC_Contest_v2.5/Astro/tsmc13gfsg_fram tsmc13_mw
open_mw_lib tsmc13_mw

set default_schematic_options {-size infinite}


# Import Design
set DESIGN "GSIM"

set hdlin_translate_off_skip_text "TRUE"
set edifout_netlist_only "TRUE"
set verilogout_no_tri true

set hdlin_enable_presto_for_vhdl "TRUE"
set sh_enable_line_editing true
set sh_line_editing_mode emacs
history keep 100
alias h history

read_file -format verilog  "../01_RTL/GSIM.v"
read_file -format verilog  "../01_RTL/buffer.v"
read_file -format verilog  "../01_RTL/overflow.v"
read_file -format verilog  "../01_RTL/core.v"

current_design [get_designs $DESIGN]
link


# Compile Design
current_design [get_designs ${DESIGN}]

check_design > Report/check_design.txt
check_timing > Report/check_timing.txt

source GSIM_DC.sdc
source eps_phy_cons.tcl

uniquify
set_fix_multiple_port_nets -all -buffer_constants [get_designs *]


compile_ultra 
compile_ultra -incremental


# Report Output
current_design [get_designs ${DESIGN}]
report_timing > "./Report_eps/${DESIGN}_syn.timing"
report_area > "./Report_eps/${DESIGN}_syn.area"
report_congestion > "./Report_eps/${DESIGN}_syn.congestion"

# Output Design
current_design [get_designs ${DESIGN}]

set bus_inference_style {%s[%d]}
set bus_naming_style {%s[%d]}
set hdlout_internal_busses true
change_names -hierarchy -rule verilog
define_name_rules name_rule -allowed {a-z A-Z 0-9 _} -max_length 255 -type cell
define_name_rules name_rule -allowed {a-z A-Z 0-9 _[]} -max_length 255 -type net
define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
define_name_rules name_rule -case_insensitive
change_names -hierarchy -rules name_rule

remove_unconnected_ports -blast_buses [get_cells -hierarchical *]
set verilogout_higher_designs_first true
write -format ddc     -hierarchy -output "./Netlist_eps/${DESIGN}_syn.ddc"
write -format verilog -hierarchy -output "./Netlist_eps/${DESIGN}_syn.v"
write_sdf -version 3.0  -context verilog -load_delay cell ./Netlist_eps/${DESIGN}_syn.sdf
write_sdc  ./Netlist_eps/${DESIGN}_syn.sdc -version 2.1


report_timing
report_area
exit