#!/bin/sh

SELECTION=$(cliphist list | fzf --height 40% --style full \
    --preview '
    ITEM={}

    if grep -E -q "png|jpg" <<< "$ITEM"; then
        img_path="/tmp/cliphist_preview.$RANDOM.png"
        echo "$ITEM" | cliphist decode | chafa --view-size=40x30
    else
        echo "$ITEM"
    fi

    ' \
)

echo "$SELECTION" | cliphist decode | wl-copy


