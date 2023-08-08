#!/bin/bash

# Threshold for CPU usage (percentage)
threshold=100

while true; do
    # Get CPU usage using top command, extract the CPU line, and extract the usage value
    cpu_usage=$(top -l 1 | grep "CPU usage:" | awk '{print $3}' | tr -d '%')

    # Compare CPU usage with threshold
    if (( $(echo "$cpu_usage >= $threshold" | bc -l) )); then
        # Send a notification
        echo "High CPU Usage Alert - Current CPU Usage: $cpu_usage%"
    else 
        echo "Normal CPU Usage - Current CPU Usage: $cpu_usage%"
        exit 0
    fi

    # Sleep for 1 minute
    sleep 60
done
