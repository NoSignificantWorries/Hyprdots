#!/bin/bash

WALLPAPERS_DIR="$HOME/Pictures/Wallpapers"
THUMBNAILS_DIR="/tmp/rofi-wallpapers"

mkdir -p "$THUMBNAILS_DIR"

THUMB_WIDTH=200
THUMB_HEIGHT=120

for img in "$WALLPAPERS_DIR"/*; do
    if [[ -f "$img" ]]; then
        filename=$(basename "$img")
        thumb_path="$THUMBNAILS_DIR/${filename%.*}_thumb.png"
        
        if [[ ! -f "$thumb_path" ]]; then
            magick "$img" -thumbnail "${THUMB_WIDTH}x${THUMB_HEIGHT}>" -background none -gravity center -extent ${THUMB_WIDTH}x${THUMB_HEIGHT} "$thumb_path"
        fi
    fi
done

{
    for img in "$WALLPAPERS_DIR"/*; do
        if [[ -f "$img" ]]; then
            filename=$(basename "$img")
            thumb_path="$THUMBNAILS_DIR/${filename%.*}_thumb.png"
            echo -e "$filename\0icon\x1f$thumb_path"
        fi
    done
} | rofi -dmenu -show-icons -theme "$HOME/.config/rofi/wallpapers/wallpaper-selector.rasi"

