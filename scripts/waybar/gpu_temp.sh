#!/bin/sh

TEMP_INFO=$(nvidia-smi --query-gpu=temperature.gpu --format=csv,noheader 2>&1)

if [ $? -ne 0 ]; then
    echo "<span color='#f38ba8'> ERR</span>"
    exit 0
fi

TEMP=$(echo "$TEMP_INFO" | awk -F', ' '{print $1}' | sed 's/[^0-9]//g')

if [ -z "$TEMP" ]; then
    echo "<span color='#f38ba8'> ERR</span>"
    exit 0
fi

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

