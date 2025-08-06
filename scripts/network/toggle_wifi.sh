#!/bin/bash

toggle_wifi() {
  local wifi_state

  wifi_state=$(nmcli radio wifi)

  if [[ "$wifi_state" == "enabled" ]]; then
    nmcli radio wifi off
    if [ $? -eq 0 ]; then
      notify-send "Networking" "Wi-Fi turned OFF"
    else
      notify-send "Networking" "Error turning off Wi-Fi" -u critical
    fi
  else
    nmcli radio wifi on
    if [ $? -eq 0 ]; then
      notify-send "Networking" "Wi-Fi turned on"
    else
      notify-send "Networking" "Error turning on Wi-Fi" -u critical
    fi
  fi
}

if ! command -v nmcli &> /dev/null; then
  notify-send "Networking" "ERROR: nmcli not found." -u critical
  exit 1
fi

toggle_wifi

