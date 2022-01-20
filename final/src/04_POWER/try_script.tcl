## PrimeTime Script
set power_enable_analysis TRUE
set power_analysis_mode time_based

read_file -format verilog  ../02_SYN/Netlist/GSIM_syn.v
current_design GSIM
link

read_sdf -load_delay net ../02_SYN/Netlist/GSIM_syn.sdf

## ===== idle window ===== TA modify
read_vcd  -strip_path testbed/u_GSIM  ../03_GATE/gsim.fsdb \
          -time {5.43  1005.43}
update_power
report_power
report_power > try_idle.power

## ===== active window ===== TA modify
read_vcd  -strip_path testbed/u_GSIM  ../03_GATE/gsim.fsdb \
          -when {i_module_en}
update_power
report_power 
report_power > try_active.power

## ===== idle_after_active window ===== TA modify
read_vcd  -strip_path testbed/u_GSIM  ../03_GATE/gsim.fsdb \
          -time {16164.95 17164.95}
update_power
report_power
report_power > try_idle_after_active.power

exit
