#!/usr/bin/sh

# Получаем информацию об устройствах в формате JSON
DEVICES_JSON=$(hyprctl devices -j)

# Извлекаем главную клавиатуру (с полем "main": true)
MAIN_KEYBOARD_NAME=$(echo "$DEVICES_JSON" | jq -r '.keyboards[] | select(.main == true) | .name')
ACTIVE_KEYMAP=$(echo "$DEVICES_JSON" | jq -r '.keyboards[] | select(.main == true) | .active_keymap')
LAYOUT=$(echo "$DEVICES_JSON" | jq -r '.keyboards[] | select(.main == true) | .layout')

# Выводим результат
echo "main_keyboard: $MAIN_KEYBOARD_NAME"
echo "active_keymap: $ACTIVE_KEYMAP"
echo "layout: $LAYOUT"
