#!/usr/bin/sh

get_temp_from_sensors() {
    sensors | grep -E "$1" | head -1 | tr -d '+' | grep -oE '[0-9]+\.[0-9]°C' | head -1
}

if command -v sensors &> /dev/null; then
    cpu_temp=$(get_temp_from_sensors "Core [0-9]+:|Package id|Tdie|CPU Temperature")
    echo "cpu:${cpu_temp:-unknown}"
    
    mb_temp=$(get_temp_from_sensors "motherboard|sys" | head -1)
    if [ -n "$mb_temp" ]; then
        echo "motherboard:${mb_temp}"
    fi
    
else
    for zone in /sys/class/thermal/thermal_zone*; do
        if [ -f "$zone/temp" ] && [ -f "$zone/type" ]; then
            temp=$(cat "$zone/temp")
            type=$(cat "$zone/type")
            if [ "$temp" -gt 0 ]; then
                temp_c=$((temp / 1000))
                echo "${type}:${temp_c}°C"
            fi
        fi
    done
fi
