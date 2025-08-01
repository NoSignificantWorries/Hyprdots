#!/bin/sh

CONFIG_DIR="$HOME/.config/waybar"

CONFIG_SYMLINK="$CONFIG_DIR/config.jsonc"
STYLE_SYMLINK="$CONFIG_DIR/style.css"

CONFIG_1="$CONFIG_DIR/main/config_main.jsonc"
STYLE_1="$CONFIG_DIR/main/style_main.css"

CONFIG_2="$CONFIG_DIR/compact/config_compact.jsonc"
STYLE_2="$CONFIG_DIR/compact/style_compact.css"


if [[ ! -L "${CONFIG_SYMLINK}" ]]; then
    ln -s "${CONFIG_1}" "${CONFIG_SYMLINK}"
fi

if [[ ! -L "${STYLE_SYMLINK}" ]]; then
    ln -s "${STYLE_1}" "${STYLE_SYMLINK}"
fi


CURRENT_CONFIG=$(readlink "${CONFIG_SYMLINK}")

if [[ "${CURRENT_CONFIG}" == "${CONFIG_1}" ]]; then
    ln -sf "${CONFIG_2}" "${CONFIG_SYMLINK}"
    ln -sf "${STYLE_2}" "${STYLE_SYMLINK}"
else
    ln -sf "${CONFIG_1}" "${CONFIG_SYMLINK}"
    ln -sf "${STYLE_1}" "${STYLE_SYMLINK}"
fi

exec "$HOME/.scripts/waybar/reload.sh"

