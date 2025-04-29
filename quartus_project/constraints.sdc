# constraints.sdc
# Timing constraints for FPGA-based Irrigation Controller

# Define the primary clock
create_clock -name clk -period 50.0 [get_ports clk] 

# Input delay for sensor signals (optional, adjust if needed)
set_input_delay -clock clk 5.0 [get_ports moisture]

# Output delay for pump control
set_output_delay -clock clk 5.0 [get_ports pump_on]
