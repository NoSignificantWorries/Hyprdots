#!/usr/bin/sh

mem_info=$(free -b | grep Mem)
total_mem=$(echo $mem_info | awk '{print $2}')
used_mem=$(echo $mem_info | awk '{print $3}')
available_mem=$(echo $mem_info | awk '{print $7}')

used_percent=$((used_mem * 100 / total_mem))
available_percent=$((available_mem * 100 / total_mem))

echo "total:${total_mem}"
echo "used:${used_mem}"
echo "used_percent:${used_percent}%"
echo "available:${available_mem}"
echo "available_percent:${available_percent}%"

swap_info=$(free -b | grep Swap)
total_swap=$(echo $swap_info | awk '{print $2}')
used_swap=$(echo $swap_info | awk '{print $3}')

if [ "$total_swap" -gt 0 ]; then
    swap_percent=$((used_swap * 100 / total_swap))
    echo "swap_total:${total_swap}"
    echo "swap_used:${used_swap}"
    echo "swap_percent:${swap_percent}%"
else
    echo "swap_total:0"
    echo "swap_used:0"
    echo "swap_percent:0%"
fi
