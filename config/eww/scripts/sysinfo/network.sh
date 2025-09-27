#!/usr/bin/sh

wifi_info=$(nmcli -t -f active,ssid,signal,rate dev wifi 2>/dev/null | grep yes | head -1)

if [ -n "$wifi_info" ]; then
    ssid=$(echo "$wifi_info" | cut -d: -f2)
    signal=$(echo "$wifi_info" | cut -d: -f3)
    rate=$(echo "$wifi_info" | cut -d: -f4)
    
    echo "connection_type:wifi"
    echo "ssid:$ssid"
    echo "signal_strength:${signal}%"
    echo "bitrate:${rate}Mbps"
else
    eth_info=$(nmcli -t -f device,type,state con status 2>/dev/null | grep ethernet | head -1)
    if [ -n "$eth_info" ]; then
        echo "connection_type:ethernet"
        echo "ssid:ethernet"
        echo "signal_strength:100%"
        echo "bitrate:1000Mbps"
    else
        echo "connection_type:disconnected"
        echo "ssid:none"
        echo "signal_strength:0%"
        echo "bitrate:0Mbps"
    fi
fi

rx_bytes=$(cat /sys/class/net/*/statistics/rx_bytes 2>/dev/null | awk '{sum += $1} END {print sum}')
tx_bytes=$(cat /sys/class/net/*/statistics/tx_bytes 2>/dev/null | awk '{sum += $1} END {print sum}')

echo "total_rx:${rx_bytes:-0}"
echo "total_tx:${tx_bytes:-0}"
