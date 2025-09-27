#!/usr/bin/sh

loadavg=$(cat /proc/loadavg)
load1=$(echo $loadavg | awk '{print $1}')
load5=$(echo $loadavg | awk '{print $2}')
load15=$(echo $loadavg | awk '{print $3}')

echo "load_1min:${load1}"
echo "load_5min:${load5}"
echo "load_15min:${load15}"

cpu_info=$(grep -E "^cpu[0-9]" /proc/stat)
core_count=$(echo "$cpu_info" | wc -l)

echo "core_count:${core_count}"

core=0
echo "$cpu_info" | while read line; do
    user=$(echo $line | awk '{print $2}')
    nice=$(echo $line | awk '{print $3}')
    system=$(echo $line | awk '{print $4}')
    idle=$(echo $line | awk '{print $5}')
    total=$((user + nice + system + idle))
    
    if [ $total -gt 0 ]; then
        usage=$(( (user + nice + system) * 100 / total ))
        echo "core_${core}_usage:${usage}%"
    fi
    core=$((core + 1))
done

running_processes=$(ps -e --no-headers | wc -l)
echo "processes:${running_processes}"
