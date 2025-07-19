#!/bin/sh

CONFIG_PATH="$HOME/.config/waybar/config.jsonc"

killall waybar
waybar -c "${CONFIG_PATH}" &


