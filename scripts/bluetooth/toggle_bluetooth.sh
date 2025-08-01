#!/bin/sh

STATUS=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$STATUS" ]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Bluetooth: OFF" -i bluetooth
else
    bluetoothctl power on
    notify-send "Bluetooth" "Bluetooth: ON" -i bluetooth
fi

