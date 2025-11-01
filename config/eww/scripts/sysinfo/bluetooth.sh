#!/usr/bin/sh

bt_status=$(bluetoothctl show 2>/dev/null | grep "Powered:" | awk '{print $2}')

if [ "$bt_status" = "yes" ]; then
    echo "status:on"
    
    connected_device=$(bluetoothctl info 2>/dev/null | grep -E "(Device|Name|Battery Percentage)" | head -3)
    
    if echo "$connected_device" | grep -q "Device"; then
        device_name=$(echo "$connected_device" | grep "Name:" | cut -d: -f2 | sed 's/^ *//')
        device_mac=$(echo "$connected_device" | grep "Device:" | awk '{print $2}')
        battery=$(echo "$connected_device" | grep "Battery" | cut -d: -f2 | sed 's/^ *//' | sed 's/%//')
        
        echo "connected:yes"
        echo "device_name:${device_name:-unknown}"
        echo "device_mac:${device_mac:-unknown}"
        # bluetooth info <MAC>
        echo "battery:${battery:-unknown}"
    else
        echo "connected:no"
        echo "device_name:none"
        echo "device_mac:none"
        echo "battery:none"
    fi
else
    echo "status:off"
    echo "connected:no"
    echo "device_name:none"
    echo "device_mac:none"
    echo "battery:none"
fi
