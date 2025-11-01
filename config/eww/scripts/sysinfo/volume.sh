#!/usr/bin/sh

speaker_volume=$(pactl get-sink-volume @DEFAULT_SINK@ 2>/dev/null | grep -oP '\d+%' | head -1 | sed 's/%//')
speaker_muted=$(pactl get-sink-mute @DEFAULT_SINK@ 2>/dev/null | grep -oP 'yes|no')

mic_volume=$(pactl get-source-volume @DEFAULT_SOURCE@ 2>/dev/null | grep -oP '\d+%' | head -1 | sed 's/%//')
mic_muted=$(pactl get-source-mute @DEFAULT_SOURCE@ 2>/dev/null | grep -oP 'yes|no')

sink_info=$(pactl info 2>/dev/null | grep "Default Sink:" | cut -d: -f2 | sed 's/^ *//')
source_info=$(pactl info 2>/dev/null | grep "Default Source:" | cut -d: -f2 | sed 's/^ *//')

echo "speaker_volume:${speaker_volume:-unknown}"
echo "speaker_muted:${speaker_muted:-unknown}"
echo "mic_volume:${mic_volume:-unknown}"
echo "mic_muted:${mic_muted:-unknown}"
echo "output_device:${sink_info:-unknown}"
echo "input_device:${source_info:-unknown}"
