#!/bin/sh

grim -g "$(slurp)" - | wl-copy -t image/png && notify-send "Screenshot" "Region copied to clipboard" -i screenshot

