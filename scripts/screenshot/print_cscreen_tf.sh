#!/bin/sh

filepath="$HOME/Pictures/Screenshots/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
thumb_file="/tmp/screenshot_thumb.png"

grim -g "$(slurp -b '00000075' -c '#b4befe' -d)" "$filepath"

convert "$filepath" -thumbnail 200 "$thumb_file"

notify-send "Screenshot" "Region saved in \"Screenshots\" dir" -i "$thumb_file"

rm -f "$thumb_file"

