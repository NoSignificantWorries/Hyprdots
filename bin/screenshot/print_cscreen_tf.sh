#!/bin/sh

grim -g "$(slurp)" ~/Pictures/Screenshot/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send "Screenshot" "Region saved in Screenshots dir" -i screenshot

