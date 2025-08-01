#!/bin/sh

grim - | wl-copy -t image/png && notify-send "Screenshot" "Full screen copied to clipboard" -i screenshot

