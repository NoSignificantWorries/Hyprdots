#!/bin/sh

filepath="$HOME/Pictures/Screenshots/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
thumb_file="/tmp/screenshot_thumb.png"

grim "$filepath"

convert "$filepath" -thumbnail 200 "$thumb_file"

notify-send "Screenshot" "Full screen saved in \"Screenshots\" dir" -i "$thumb_file"

rm -f "$thumb_file"

