#!/usr/bin/sh

config="$HOME/.config/eww/widgets/bar"

eww daemon 2>/dev/null

case "$1" in
    "launch-all")
        eww --force-wayland open-many -c "$config" reserver applications-window
        ;;
    "stop-all")
        eww --force-wayland close-all -c "$config"
        ;;
    *)
        echo "ERROR: Unknown command!"
        ;;
esac

