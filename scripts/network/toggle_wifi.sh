#!/bin/bash

toggle_wifi() {
  local wifi_state

  wifi_state=$(nmcli radio wifi)

  if [[ "$wifi_state" == "enabled" ]]; then
    nmcli radio wifi off
    if [ $? -eq 0 ]; then
      notify-send "Networking" "Wi-Fi turned OFF" -i "$HOME/.icons/wifi-notify.png"
    else
      notify-send "Networking" "ERROR turning off Wi-Fi" -u critical -i "$HOME/.icons/wifi-notify.png"
    fi
  else
    nmcli radio wifi on
    if [ $? -eq 0 ]; then
      notify-send "Networking" "Wi-Fi turned ON" -i "$HOME/.icons/wifi-notify.png"
    else
      notify-send "Networking" "ERROR turning on Wi-Fi" -u critical -i "$HOME/.icons/wifi-notify.png"
    fi
  fi
}

if ! command -v nmcli &> /dev/null; then
  notify-send "Networking" "ERROR: nmcli not found." -u critical -i "$HOME/.icons/wifi-notify.png"
  exit 1
fi

toggle_wifi

