# build.tcl
#
# Simple Quartus Prime build script
# Usage: quartus_sh --script=build.tcl

# Set the project name
set project_name "IrrigationController"

# Open the project
project_open $project_name

# Compile the design
execute_flow -compile

# (Optional) Program the FPGA if hardware connected
# Uncomment the following line if you want automatic programming after compile
# quartus_pgm -c USB-Blaster -m JTAG -o "p;output_files/$project_name.sof"

# Close the project
project_close
