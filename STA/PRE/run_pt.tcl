read_ddc ../../SYN/output/SA_mapped.ddc 

link

create_clock -period 25 -name MAIN_CLOCK [get_ports clk]
set_clock_latency -source  -max 2 [get_clocks MAIN_CLOCK] 
set_clock_latency -max 1 [get_clocks MAIN_CLOCK]

set_clock_uncertainty -setup 1.5 [get_clocks MAIN_CLOCK]

set_input_delay -max 4.0 -clock MAIN_CLOCK [all_inputs]
set_input_delay -min 2.0 -clock MAIN_CLOCK [all_inputs]
remove_input_delay [get_ports "clk"] 
set_input_delay -max 4.0 -clock MAIN_CLOCK [get_ports rst_n]
set_input_delay -min 2.0 -clock MAIN_CLOCK [get_ports rst_n]

set_ideal_network [get_ports "rst_n clk"]

check_timing -verbose

report_analysis_coverage

write_sdf SA.sdf_PT


