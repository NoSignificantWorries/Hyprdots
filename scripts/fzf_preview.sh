#!/bin/sh

file="$1"

clear

if [[ -d "$file" ]]; then
    tree -C "$file"
elif [[ "$file" == *.png || "$file" == *.jpg ]]; then
    jp2a --color-depth=24 --width=$((FZF_PREVIEW_COLUMNS)) "$file"
    # timg -g$((FZF_PREVIEW_COLUMNS))x$((FZF_PREVIEW_LINES)) "$file"
elif [[ "$file" == *.ipynb ]]; then
    rich "$file"
else
    bat --color=always --style=header,grid "$file"
fi

