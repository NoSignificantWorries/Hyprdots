#!/usr/bin/sh

battery_info=$(upower -i $(upower -e | grep battery) 2>/dev/null)

if [ -z "$battery_info" ]; then
    echo "Error"
    exit 1
fi

percentage=$(echo "$battery_info" | grep percentage | awk '{print $2}' | sed 's/%//')
echo "charge:$percentage"

state=$(echo "$battery_info" | grep state | awk '{print $2}')
echo "charging:$state"

time_to=$(echo "$battery_info" | grep "time to" | head -1 | awk '{print $4, $5}')
if [ -n "$time_to" ]; then
    echo "time_to:$time_to"
else
    echo "time_to:unknown"
fi
