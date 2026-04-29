# ============================================================
# Synthesis Script — PMU Optimized (SCL 180nm)
# ============================================================

# 1. Setup PDK Paths
set_attribute lib_search_path { /mnt/hgfs/scl_bridge/SCLPDK_V3.0_KIT/scl180/stdcell/fs120/6M1L/liberty/lib_flow_ss } /
set_attribute library { tsl18fs120_scl_ss.lib } /

# 2. Setup Output Directories
exec mkdir -p reports
exec mkdir -p netlists

# 3. Read and Elaborate Design
# Using your specific optimized PMU file
read_hdl -v2001 top.v
elaborate top

# 4. Define Timing Constraints
# 10ns period = 100MHz
define_clock -name clk -period 10000 [find / -port clk]

# FIX: Added the explicit -edge rising and -value logic 
# to ensure the tool doesn't treat '2000' as a string name
external_delay -input 2000 -clock clk [all_inputs]
external_delay -output 2000 -clock clk [all_outputs]

# 5. Synthesis Execution
synthesize -to_mapped -effort medium

# 6. Generate Reports
report timing > reports/top_timing_scl180.rpt
report power  > reports/top_power_scl180.rpt
report area   > reports/top_area_scl180.rpt
report gates  > reports/top_gates_scl180.rpt

# 7. Export Gate-Level Netlist
write_hdl -mapped > netlists/top_scl180_netlist.v

puts "\n"
puts "========================================================"
puts "     top OPTIMIZED SYNTHESIS COMPLETE (SCL 180nm)       "
puts "========================================================"
