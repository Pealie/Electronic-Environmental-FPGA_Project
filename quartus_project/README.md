# Quartus Project Scaffold

This folder is intended to contain the Quartus Prime project for the FPGA-based irrigation controller.

## Suggested Directory Structure

```
quartus_project/
├── IrrigationController.qpf     # Quartus Project File
├── IrrigationController.qsf     # Quartus Settings File
├── fpga_control.vhdl             # VHDL file(s)
└── constraints.sdc               # Timing constraints file (optional)
```

## Steps to Create the Project

1. Open Quartus Prime.
2. Create a New Project Wizard:
   - Project Name: `IrrigationController`
   - Top-level Entity: `IrrigationControl`
   - Target Device: Cyclone V SoC (e.g., 5CSEBA6U23I7)
3. Add `fpga_control.vhdl` as the source file.
4. (Optional) Set timing constraints in `constraints.sdc`.
5. Compile the project.

Use `Programmer` to upload the .sof file to the DE10-Nano.

