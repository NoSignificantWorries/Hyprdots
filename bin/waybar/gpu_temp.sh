#!/bin/sh

TEMP=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader)

COLOR="#a6e3a1"

if [[ $TEMP -le 20 ]]; then
    ICON=""
elif [[ $TEMP -le 40 ]]; then
    ICON=""
elif [[ $TEMP -le 60 ]]; then
    ICON=""
elif [[ $TEMP -le 80 ]]; then
    ICON=""
else
    ICON=""
    COLOR="#f38ba8"
fi

echo "<span color='${COLOR}'>${ICON} ${TEMP}°C</span>"

