#!/bin/sh

screenshot_file="/tmp/screenshot.png"
thumb_dir="$HOME/.cache/thumbnails/cliphist"
thumb_file="$thumb_dir/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

mkdir -p "$thumb_dir"

grim - | tee "$screenshot_file" | wl-copy -t image/png

convert "$screenshot_file" -thumbnail 200 "$thumb_file"

notify-send "Screenshot" "Full screen copied to clipboard" -i "$thumb_file"

rm -f "$screenshot_file"

