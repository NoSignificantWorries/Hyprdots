#!/bin/sh

# Получить громкость
get_volume() {
  wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{printf "%d", $1 * 100}'
}

# Получить статус выключения звука (mute)
get_mute() {
  wpctl get-mute @DEFAULT_AUDIO_SINK@
}

# Получить имя подключенного bluetooth девайса (если есть)
get_bluetooth_device() {
  wpctl status | grep -E 'bluez_output.*device:' | awk '{print $NF}' | sed 's/.device//' | sed 's/://'
}

# Определить иконку и формат в зависимости от громкости и mute
determine_icon_and_format() {
  volume=$(get_volume)
  muted=$(get_mute)
  bluetooth_device=$(get_bluetooth_device)

  if [[ ! -z "$bluetooth_device" ]]; then
    if [[ "$muted" == "true" ]]; then
      icon=""  # Bluetooth muted icon
      format="{volume}%\n"
    else
      icon=""    # Bluetooth icon
      format="{volume}%\n"
    fi
  else
    if [[ "$muted" == "true" ]]; then
      icon=""    # Muted icon
      format="{volume}%\n"
    else
      case $volume in
        ([0-9]|1[0-9]|2[0-9])) icon="󰕿";; # 0-29%
        ([3-9][0-9])) icon="";;          # 30-99%
        (100)) icon="";;            # 100%
        (*) icon="";;
      esac
      format="{icon}{volume}%\n"
    fi
  fi

  # Добавление информации об источнике (микрофоне)
  source_volume=$(wpctl get-volume @DEFAULT_AUDIO_SOURCE@ | awk '{printf "%d", $1 * 100}')
  source_muted=$(wpctl get-mute @DEFAULT_AUDIO_SOURCE@)

  if [[ "$source_muted" == "true" ]]; then
    source_icon=""
  else
    source_icon=""
  fi

  source_format="$source_icon$source_volume%"

  # Замена переменных в строке format
  format=$(echo "$format" | sed "s/{icon}/$icon/g; s/{volume}/$volume/g")

  # Вывод информации
  echo -e "$format$source_format"
}

determine_icon_and_format


