# Sample Python script to run on the HPS (ARM) of DE10-Nano
# Sends soil moisture data to Azure IoT or logs it locally

import time
import random  # Replace with actual FPGA interfacing code
from datetime import datetime

def read_fpga_moisture():
    # This would be replaced by mmap or SPI access in actual code
    return random.randint(800, 3000)  # Simulated ADC values

def log_data(moisture):
    timestamp = datetime.utcnow().isoformat()
    print(f"{timestamp} - Moisture: {moisture}")

def main():
    print("Starting irrigation data logger...")
    while True:
        moisture = read_fpga_moisture()
        log_data(moisture)
        time.sleep(10)  # Read every 10 seconds

if __name__ == "__main__":
    main()
