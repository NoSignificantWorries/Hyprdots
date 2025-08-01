#!/bin/sh

UTIL=$(nvidia-smi --query-gpu=utilization.gpu --format=csv,noheader | sed 's/[^0-9]//g')


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

