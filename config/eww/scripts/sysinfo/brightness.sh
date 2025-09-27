#!/usr/bin/sh

brightness=$(brightnessctl g 2>/dev/null)
max_brightness=$(brightnessctl m 2>/dev/null)

if [ -z "$brightness" ] || [ -z "$max_brightness" ]; then
    echo "Error"
    exit 1
fi

if [ -n "$brightness" ] && [ -n "$max_brightness" ] && [ "$max_brightness" -gt 0 ]; then
    percentage=$((brightness * 100 / max_brightness))
    echo "brightness:$percentage%"
else
    echo "brightness:unknown"
fi
