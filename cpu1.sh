#!/bin/bash

# Process name to monitor
process_name="chrome"

# Threshold for CPU usage (percentage)
threshold=100

while true; do
    # Get the PID of the process
    pid=$(pgrep "$process_name")

    if [ -n "$pid" ]; then
        # Get CPU usage percentage for the process
        cpu_usage=$(ps -p "$pid" -o %cpu=)

        # Compare CPU usage with threshold
        if (( $(echo "$cpu_usage >= $threshold" | bc -l) )); then
            # Send a notification
            osascript -e "display notification \"High CPU Usage Alert\n$process_name CPU Usage: $cpu_usage%\" with title \"High CPU Usage\""
        fi
    fi

    # Sleep for 1 minute
    sleep 60
done
