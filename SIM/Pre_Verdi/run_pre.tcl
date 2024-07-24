# -R -gui options are deleted for Verdi and ucli

cp ../../SYN/output/SA_gate.v ./
cp ../../STA/PRE/SA.sdf_PT ./

vcs -full64 -debug_access+all -kdb -LDFLAGS -Wl,--no-as-needed \
+neg_tchk \
+maxdelays \
+incdir+../../RTL \
+incdir+../../SIM/TB \
+incdir+/media/0/LogicLibraries/SAED32_EDK/lib/stdcell_lvt/verilog/ \
 +v2k -R -gui \
../../SIM/TB/SA_tb.v \
./SA_gate.v \
../../RTL/PE.v \
../../RTL/Counter.v \
-v /media/0/LogicLibraries/SAED32_EDK/lib/stdcell_lvt/verilog/saed32nm_lvt.v \
-l pre_sim.log 
