#!/bin/sh

selected_dir=$(find ~ -type d 2>/dev/null | fzf --prompt="Выберите директорию (Enter для $HOME): ")

if [ -n "$selected_dir" ]; then
    cd "$selected_dir"
fi

