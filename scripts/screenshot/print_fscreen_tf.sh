#!/bin/sh

grim ~/Pictures/Screenshots/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png && notify-send "Screenshot" "Full screen saved in Screenshots dir" -i screenshot

