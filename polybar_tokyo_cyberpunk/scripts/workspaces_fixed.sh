#!/bin/bash

show_workspaces() {
    WS=$(i3-msg -t get_workspaces 2>/dev/null)
    FOCUSED=$(echo "$WS" | jq -r '.[] | select(.focused==true) | .name')
    OUTPUT=""
    for i in $(seq 1 10); do
        name="$i"
        if [ "$FOCUSED" = "$name" ]; then
            OUTPUT+="%{F#CE93D8} $name %{F-}"
        elif echo "$WS" | jq -e --arg n "$name" '.[] | select(.name==$n)' > /dev/null 2>&1; then
            OUTPUT+="%{F#6A1B9A} $name %{F-}"
        else
            OUTPUT+="%{F#333333} $name %{F-}"
        fi
    done
    echo "$OUTPUT"
}

show_workspaces

i3-msg -t subscribe '["workspace"]' | while read -r _; do
    show_workspaces
done
