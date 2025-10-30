#!/bin/sh

LOW_LEVEL=20
CRITICAL_LEVEL=10

IS_NORMAL=1
IS_LOW=0
IS_CRITICAL=0

on_battery() {
    if grep -q "Discharging" /sys/class/power_supply/BAT*/status 2>/dev/null; then
        return 0
    else
        return 1
    fi
}

get_battery_level() {
    cat /sys/class/power_supply/BAT*/capacity 2>/dev/null
}

check_battery() {
    if on_battery; then
        BATTERY_LEVEL=$(get_battery_level)
        
        if [ -z "$BATTERY_LEVEL" ] || ! echo "$BATTERY_LEVEL" | grep -qE '^[0-9]+$'; then
            return 1
        fi

        if [ "$BATTERY_LEVEL" -le "$CRITICAL_LEVEL" ] && [ "$IS_CRITICAL" -eq 0 ]; then
            notify-send "Power" "Critical battery (${BATTERY_LEVEL}%), connect charger!" -i "$HOME/.icons/critical-battery.png" 2>/dev/null
            IS_CRITICAL=1
            IS_LOW=0
            IS_NORMAL=0
        elif [ "$BATTERY_LEVEL" -le "$LOW_LEVEL" ] && [ "$BATTERY_LEVEL" -gt "$CRITICAL_LEVEL" ] && [ "$IS_LOW" -eq 0 ]; then
            notify-send "Power" "Low battery (${BATTERY_LEVEL}%), connect charger!" -i "$HOME/.icons/low-battery.png" 2>/dev/null
            IS_LOW=1
            IS_CRITICAL=0
            IS_NORMAL=0
        elif [ "$BATTERY_LEVEL" -gt "$LOW_LEVEL" ] && [ "$IS_NORMAL" -eq 0 ]; then
            IS_NORMAL=1
            IS_LOW=0
            IS_CRITICAL=0
        fi
    else
        if [ "$IS_NORMAL" -eq 0 ]; then
            IS_NORMAL=1
            IS_LOW=0
            IS_CRITICAL=0
        fi
    fi
}

while true; do
    check_battery
    sleep 60
done

