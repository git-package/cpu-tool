#!/bin/bash

# Check if lm-sensors and mpstat are installed
if ! command -v sensors &> /dev/null; then
    echo "Error: lm-sensors is not installed. Please install it using your package manager."
    exit 1
fi

if ! command -v mpstat &> /dev/null; then
    echo "Error: sysstat package is not installed. Please install it using your package manager."
    exit 1
fi

# Infinite loop to update CPU information every second
while true; do
    clear  # Clear the terminal for a clean display

    # Get CPU temperature
    cpu_temp=$(sensors | grep -i 'cpu' | awk '{print $2}' | head -n 1)

    # Get CPU clock speed
    cpu_clock=$(lscpu | grep "CPU MHz" | awk '{print $3}')

    # Get CPU usage
    cpu_usage=$(mpstat 1 1 | tail -1 | awk '{print 100 - $12}')

    # Display the information
    echo "Current CPU Information:"
    echo "Temperature: $cpu_temp"
    echo "Clock Speed: $cpu_clock MHz"
    echo "Usage: $cpu_usage%"
    
    sleep 1  # Wait for 1 second before the next update
done
