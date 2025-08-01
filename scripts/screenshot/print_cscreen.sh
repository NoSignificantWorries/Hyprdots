#!/bin/sh

grim -g "$(slurp -b '00000075' -c '#b4befe' -d)" - | wl-copy -t image/png && notify-send "Screenshot" "Region copied to clipboard" -i screenshot

