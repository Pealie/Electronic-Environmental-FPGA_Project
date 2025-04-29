# Deploying the HPS Script to Azure IoT

This guide outlines how to send FPGA soil moisture readings to Azure IoT Central.

## Prerequisites
- Azure account
- Azure IoT Central application
- DE10-Nano running Linux
- Python 3 installed on the HPS

## Steps

1. **Create an Azure IoT Central Application:**
   - Go to [Azure IoT Central](https://apps.azureiotcentral.com/).
   - Create a "Custom Application" or use "IoT Device" template.

2. **Register a Device:**
   - In your IoT Central app, create a new device.
   - Note the device ID, scope ID, and device key.

3. **Install Python Libraries:**
   ```bash
   pip3 install azure-iot-device
   ```

4. **Modify `hps_upload.py`:**
   - Replace placeholders with your Azure IoT Central device credentials.

5. **Run the Python script on the HPS:**
   ```bash
   python3 hps_upload.py
   ```

6. **Monitor Data:**
   - Soil moisture readings will appear on your Azure dashboard.

## Notes
- Ensure your DE10-Nano has internet access (WiFi or Ethernet).
- You can expand the script to upload multiple sensor data or receive configuration commands from the cloud.

