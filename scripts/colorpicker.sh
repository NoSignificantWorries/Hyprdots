#!/bin/sh

thumb_dir="$HOME/.cache/thumbnails/cliphist"

color=$(hyprpicker)

thumb_file="$thumb_dir/color_${color}_$(date +%Y-%m-%d_%H-%M-%S).png"

mkdir -p "$thumb_dir"

wl-copy "$color"

convert -size 100x100 xc:"$color" "$thumb_file"

notify-send -i "$thumb_file" "Color copied" "HEX: $color"

