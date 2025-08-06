#!/bin/sh

file="$1"

if [[ -d "$file" ]]; then
    tree -C "$file"
else
    case "$file" in
        *.png|*.jpg|*.jpeg|*.svg|*.gif) timg -g$((FZF_PREVIEW_COLUMNS))x$((FZF_PREVIEW_LINES)) "$file" ;;
        *) rich "$file" ;;
    esac
fi

