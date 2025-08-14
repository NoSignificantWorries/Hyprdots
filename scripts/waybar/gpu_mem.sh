#!/bin/sh

MEM_INFO=$(nvidia-smi --query-gpu=memory.used,memory.total --format=csv,noheader 2>&1)

if [ $? -ne 0 ]; then
    echo "<span color='#f38ba8'>󰻠 ERR</span>"
    exit 0
fi

# MEM_USED=$(nvidia-smi --query-gpu=memory.used --format=csv,noheader | sed 's/[^0-9]//g')
# MEM_TOTAL=$(nvidia-smi --query-gpu=memory.total --format=csv,noheader | sed 's/[^0-9]//g')
MEM_USED=$(echo "$MEM_INFO" | awk -F', ' '{print $1}' | sed 's/[^0-9]//g')
MEM_TOTAL=$(echo "$MEM_INFO" | awk -F', ' '{print $2}' | sed 's/[^0-9]//g')

if [ -z "$MEM_USED" ] || [ -z "$MEM_TOTAL" ]; then
    echo "<span color='#f38ba8'>󰻠 ERR</span>"
    exit 0
fi

MEM_PERCENT=$(echo "scale=0; $MEM_USED * 100 / $MEM_TOTAL" | bc)


if [[ $MEM_PERCENT -le 20 ]]; then
    COLOR="#f5e0dc"
elif [[ $MEM_PERCENT -le 40 ]]; then
    COLOR="#f9e2af"
elif [[ $MEM_PERCENT -le 60 ]]; then
    COLOR="#fab387"
elif [[ $MEM_PERCENT -le 80 ]]; then
    COLOR="#eba0ac"
else
    COLOR="#f38ba8"
fi

echo "<span color='${COLOR}'>󰻠 ${MEM_PERCENT}%</span>"

