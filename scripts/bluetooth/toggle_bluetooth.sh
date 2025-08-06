#!/bin/sh

STATUS=$(bluetoothctl show | grep "Powered: yes")

if [ -n "$STATUS" ]; then
    bluetoothctl power off
    notify-send "Bluetooth" "Bluetooth: OFF" -i "$HOME/.icons/bluetooth-notify.png"
else
    bluetoothctl power on
    notify-send "Bluetooth" "Bluetooth: ON" -i "$HOME/.icons/bluetooth-notify.png"
fi

