#!/bin/sh

UTIL_INFO=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader 2>&1)

COLOR="#f38ba8"

if [ $? -ne 0 ] || echo "$UTIL_INFO" | grep -qi "error\|failed\|unavailable"; then
    echo "<span color='${COLOR}'>󰾲 ERR</span>"
    exit 0
fi

UTIL=$(echo "$UTIL_INFO" | awk -F', ' '{print $1}' | sed 's/[^0-9]//g')

if [ -z "$UTIL" ]; then
    echo "<span color='${COLOR}'>󰾲 ERR</span>"
    exit 0
fi


if [[ $UTIL -le 20 ]]; then
    COLOR="#f5e0dc"
elif [[ $UTIL -le 40 ]]; then
    COLOR="#f9e2af"
elif [[ $UTIL -le 60 ]]; then
    COLOR="#fab387"
elif [[ $UTIL -le 80 ]]; then
    COLOR="#eba0ac"
else
    COLOR="#f38ba8"
fi

echo "<span color='${COLOR}'>󰾲 ${UTIL}%</span>"

