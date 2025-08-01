#!/bin/sh

WALLPAPER_LINK="$HOME/.wallpaper"

ln -sf "$1" "${WALLPAPER_LINK}"
hyprctl hyprpaper reload ,"${WALLPAPER_LINK}"

