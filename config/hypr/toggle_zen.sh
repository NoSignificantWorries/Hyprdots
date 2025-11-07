#!/bin/sh

CONFIG_FILE="$HOME/.config/hypr/hyprvars.conf"
STATE_FILE="$HOME/.config/hypr/zen_mode.state"

get_var() {
  local var_name="$1"
  grep "^\\\$$var_name" "$CONFIG_FILE" | cut -d'=' -f2 | sed 's/^[[:space:]]*//;s/[[:space:]]*$//'
}

is_zen_mode() {
  local current_rounding=$(hyprctl getoption decoration:rounding -j | jq -r '.int')
  local current_blur=$(hyprctl getoption decoration:blur:enabled -j | jq -r '.bool')

  [ "$current_rounding" = "$(get_var 'zen_round')" ] && [ "$current_blur" = "false" ]
}

get_current_state() {
  if [ -f "$STATE_FILE" ]; then
    cat "$STATE_FILE"
  else
    echo "default"
  fi
}

set_state() {
  echo "$1" > "$STATE_FILE"
}

apply_zen_mode() {
  echo "Applying ZEN mode..."

  hyprctl keyword decoration:rounding "$(get_var 'zen_round')"
  hyprctl keyword general:gaps_in "$(get_var 'zen_gaps_in')"
  hyprctl keyword general:gaps_out "$(get_var 'zen_gaps_out')"
  hyprctl keyword general:border_size "$(get_var 'zen_border_size')"
  hyprctl keyword decoration:active_opacity "$(get_var 'zen_active_opacity')"
  hyprctl keyword decoration:inactive_opacity "$(get_var 'zen_inactive_opacity')"
  hyprctl keyword decoration:fullscreen_opacity "$(get_var 'zen_fullscreen_opacity')"
  hyprctl keyword decoration:blur:enabled "$(get_var 'zen_blur')"
  hyprctl keyword decoration:shadow:enabled "$(get_var 'zen_shadow')"
  hyprctl keyword animations:enabled "$(get_var 'zen_animations')"

  notify-send -t 2000 "🎌 ZEN Mode" "Minimal mode activated"

  set_state "zen"
}

apply_default_mode() {
  echo "Applying DEFAULT mode..."

  hyprctl keyword decoration:rounding "$(get_var 'def_round')"
  hyprctl keyword general:gaps_in "$(get_var 'def_gaps_in')"
  hyprctl keyword general:gaps_out "$(get_var 'def_gaps_out')"
  hyprctl keyword general:border_size "$(get_var 'def_border_size')"
  hyprctl keyword decoration:active_opacity "$(get_var 'def_active_opacity')"
  hyprctl keyword decoration:inactive_opacity "$(get_var 'def_inactive_opacity')"
  hyprctl keyword decoration:fullscreen_opacity "$(get_var 'def_fullscreen_opacity')"
  hyprctl keyword decoration:blur:enabled "$(get_var 'def_blur')"
  hyprctl keyword decoration:shadow:enabled "$(get_var 'def_shadow')"
  hyprctl keyword animations:enabled "$(get_var 'def_animations')"

  notify-send -t 2000 "🎨 Default Mode" "Normal mode activated"

  set_state "default"
}

current_state=$(get_current_state)

if [ "$current_state" = "zen" ]; then
    apply_default_mode
else
    apply_zen_mode
fi

