set top_design SA
set_svf SA.svf
define_design_lib work -path ./work

set rtl [ list \
../RTL/SA.v \
../RTL/PE.v \
../RTL/Counter.v]

analyze -format verilog $rtl
elaborate -architecture verilog $top_design
#uniquify : uniquify is executed automatically

#read_ddc ./output/pad_TOP_unmapped.ddc
current_design $top_design
redirect -tee -file rpt/0_link.rpt {link}
redirect -tee -file rpt/1_check_design.rpt {check_design}
write -format ddc -hierarchy -out ./output/SA_unmapped.ddc

#do "dcprocheck" prior to source the below constraint file
create_clock -period 25 -name MAIN_CLOCK [get_ports clk]
redirect -tee -file rpt/2_source.rpt {source -echo -verbose cons/TOP.con}
redirect -tee -file rpt/3_check_timing.rpt {check_timing}
redirect -tee -file rpt/4_report_port.rpt {report_port -verbose}

#set_boundary_optimization $top_design false
redirect -tee -file rpt/5_compile.rpt {compile_ultra -no_autoungroup}
redirect -tee -file rpt/6_report_constraint.rpt {report_constraint -all_violators}
redirect -tee -file rpt/7_report_timing.rpt {report_timing}
redirect -tee -file rpt/8_report_path_group.rpt {report_path_group}
redirect -tee -file rpt/9_report_area.rpt {report_area}
redirect -tee -file rpt/10_report_clock.rpt {report_clock -skew -attr}; #This is for dc_shell-topo

# "tri" to "wire"
set verilogout_no_tri true
# bus[10] to bus_10_
change_names -rules verilog -hierarchy

write -format verilog -hierarchy -output ./output/SA_gate.v
write -format ddc -hierarchy -output ./output/SA_mapped.ddc
write_sdc -version 1.9 ./output/$top_design.sdc
write_sdf ./output/$top_design.sdf_dc
set_svf -off
