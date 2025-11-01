#!/usr/bin/sh

root_info=$(df -B1 / | tail -1)
total_disk=$(echo $root_info | awk '{print $2}')
used_disk=$(echo $root_info | awk '{print $3}')
available_disk=$(echo $root_info | awk '{print $4}')
used_percent=$(echo $root_info | awk '{print $5}' | sed 's/%//')

echo "root_total:${total_disk}"
echo "root_used:${used_disk}"
echo "root_available:${available_disk}"
echo "root_used_percent:${used_percent}%"

home_info=$(df -B1 /home 2>/dev/null | tail -1)
if [ $? -eq 0 ] && [ "$(echo $home_info | awk '{print $6}')" != "/" ]; then
    home_total=$(echo $home_info | awk '{print $2}')
    home_used=$(echo $home_info | awk '{print $3}')
    home_available=$(echo $home_info | awk '{print $4}')
    home_percent=$(echo $home_info | awk '{print $5}' | sed 's/%//')
    
    echo "home_total:${home_total}"
    echo "home_used:${home_used}"
    echo "home_available:${home_available}"
    echo "home_used_percent:${home_percent}%"
fi
