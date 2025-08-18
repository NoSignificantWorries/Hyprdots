#!/bin/sh

thumb_dir="$HOME/.cache/thumbnails/cliphist"
screenshot_dir="$HOME/Pictures/Screenshots"
recording_dir="$HOME/Videos/Recordings"

mkdir -p "$thumb_dir"
mkdir -p "$screenshot_dir"
mkdir -p "$recording_dir"

screenshot_file="/tmp/screenshot.png"

screen_thumb="$thumb_dir/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"
filepath="$screenshot_dir/screenshot_$(date +%Y-%m-%d_%H-%M-%S).png"

record_thumb="$thumb_dir/record_$(date +%Y-%m-%d_%H-%M-%S).mp4"
recpath="$recording_dir/record_$(date +%Y-%m-%d_%H-%M-%S).mp4"


ACTION="$1"

case "$ACTION" in
    "full")
        grim - | tee "$screenshot_file" | wl-copy -t image/png
        convert "$screenshot_file" -thumbnail 200 "$screen_thumb"
        notify-send "Screenshot" "Full screen copied to clipboard" -i "$screen_thumb"
        rm -f "$screenshot_file" "$screen_thumb"
        ;;
    "area")
        grim -g "$(slurp -b '00000075' -c '#b4befe' -d)" - | tee "$screenshot_file" | wl-copy -t image/png
        convert "$screenshot_file" -thumbnail 200 "$screen_thumb"
        notify-send "Screenshot" "Region copied to clipboard" -i "$screen_thumb"
        rm -f "$screenshot_file" "$screen_thumb"
        ;;
    "save-full")
        grim "$filepath"
        convert "$filepath" -thumbnail 200 "$screen_thumb"
        notify-send "Screenshot" "Full screen saved in \"Screenshots\" dir" -i "$screen_thumb"
        rm -f "$screen_thumb"
        ;;
    "save-area")
        grim -g "$(slurp -b '00000075' -c '#b4befe' -d)" "$filepath"
        convert "$filepath" -thumbnail 200 "$screen_thumb"
        notify-send "Screenshot" "Region saved in \"Screenshots\" dir" -i "$screen_thumb"
        rm -f "$screen_thumb"
        ;;
    "record-full-start")
        wf-recorder -f "$recpath" &
        echo $! > /tmp/wf-recorder.pid
        notify-send "Запись" "Начата запись видео"
        ;;
    "record-area-start")
        scale=$(hyprctl monitors | awk '/scale/ {print $2}')
        area=$(slurp -b '00000075' -c '#b4befe' -d)

        echo "$area"
        wf-recorder -g "$scaled_area" -f "$recpath" &
        echo $! > /tmp/wf-recorder.pid
        notify-send "Запись" "Начата запись видео"
        ;;
    "record-stop")
        sleep 0.5
        kill -INT $(cat /tmp/wf-recorder.pid)
        rm /tmp/wf-recorder.pid
        notify-send "Запись" "Запись видео остановлена"
        ;;
    *)
        echo "ERROR: Unknown option"
        exit 1
        ;;
esac

