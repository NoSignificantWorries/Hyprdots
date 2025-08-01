#!/bin/sh

CONFIG_DIR="$HOME/.config/waybar"

CONFIG_SYMLINK="$CONFIG_DIR/config.jsonc"
STYLE_SYMLINK="$CONFIG_DIR/style.css"

CONFIG_1="$CONFIG_DIR/main/config_main.jsonc"
STYLE_1="$CONFIG_DIR/main/style_main.css"

if [[ ! -L "${CONFIG_SYMLINK}" ]]; then
    ln -s "${CONFIG_1}" "${CONFIG_SYMLINK}"
fi

if [[ ! -L "${STYLE_SYMLINK}" ]]; then
    ln -s "${STYLE_1}" "${STYLE_SYMLINK}"
fi

killall waybar
waybar -c "${CONFIG_SYMLINK}" &


