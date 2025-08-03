#!/bin/sh

LOW_LEVEL=20
CRITICAL_LEVEL=10

on_battery() {
    if grep -q "Discharging" /sys/class/power_supply/BAT*/status; then
        return 0
    else
        return 1
    fi
}

get_battery_level() {
    cat /sys/class/power_supply/BAT*/capacity
}


check_battery() {
    if on_battery; then
        BATTERY_LEVEL=$(get_battery_level)

        if [ "$BATTERY_LEVEL" -le "$CRITICAL_LEVEL" ]; then
            notify-send "Power" "Critical buttery (${BATTERY_LEVEL}%), connect charger" -i "$HOME/.icons/critical-battery.png"
        elif [ "$BATTERY_LEVEL" -le "$LOW_LEVEL" ]; then
            notify-send "Power" "Low buttery (${BATTERY_LEVEL}%), connect charger!" -i "$HOME/.icons/low-battery.png"
        fi
    fi
}


while true; do
    check_battery
    sleep 60
done

