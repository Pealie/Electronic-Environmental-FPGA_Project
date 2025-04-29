# FPGA-Based Irrigation System for Soft Fruit Farms

This repository contains the source files, logic descriptions, and documentation for an FPGA-based smart irrigation controller designed for soft fruit farms, using the Terasic DE10-Nano development board and capacitive soil moisture sensors.

## Project Overview

The system automates irrigation by monitoring soil moisture in real time and activating a water pump only when necessary. It uses the FPGA fabric for precise control and real-time logic, while a built-in ARM processor (HPS) provides optional cloud connectivity via Microsoft Azure IoT Central.

**Key Components:**
- DE10-Nano (Cyclone V SoC FPGA)
- Analog Devices CN0398 sensor shield with AD7124 ADC
- Capacitive soil moisture sensors
- Relay/pump control
- Azure IoT cloud integration (optional)

## Features
- Real-time irrigation control with VHDL/Verilog logic
- Moisture-based hysteresis thresholds to prevent rapid switching
- Modular and scalable sensor architecture
- Optional Python-based HPS script for data upload and remote control
- Designed for solar-powered and off-grid deployment

## Getting Started

1. Clone the repository:
   ```bash
   git clone https://github.com/Pealie/Electronic-Environmental-FPGA_Project.git
   ```

2. Build the FPGA logic using [Intel Quartus Prime](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/overview.html).

3. Load onto the DE10-Nano board and connect the CN0398 sensor shield.

4. Run the included HPS Python script to enable cloud upload (optional).

## Documentation

Full project documentation and system overview is in `Water_Irrigation_FPGA_Project.md`.

## License

This project is released under the MIT License. See [`LICENSE`](LICENSE) for more details.

## Acknowledgements

Developed by Team Thomson for the InnovateFPGA challenge. Inspired by the need for precision agriculture solutions that conserve water and improve crop health.

