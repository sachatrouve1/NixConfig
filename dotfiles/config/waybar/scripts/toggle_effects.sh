#!/usr/bin/env bash

STATE_FILE="$HOME/.cache/hypr_effects_state"

# Read current state
if [[ -f "$STATE_FILE" ]]; then
    STATE=$(<"$STATE_FILE")
    STATE=$(echo -n "$STATE" | tr -d '[:space:]')
else
    STATE="on"
fi

# Toggle state
if [[ "$STATE" == "on" ]]; then
    if ! hyprctl eval "hl.config({ animations = { enabled = false }, decoration = { blur = { enabled = false }, rounding = 0 } })" >/dev/null 2>&1; then
        hyprctl keyword animations:enabled false
        hyprctl keyword decoration:blur:enabled false
        hyprctl keyword decoration:rounding 0
    fi
    echo -n "off" >"$STATE_FILE"
else
    if ! hyprctl eval "hl.config({ animations = { enabled = true }, decoration = { blur = { enabled = true }, rounding = 20 } })" >/dev/null 2>&1; then
        hyprctl keyword animations:enabled true
        hyprctl keyword decoration:blur:enabled true
        hyprctl keyword decoration:rounding 20
    fi
    echo -n "on" >"$STATE_FILE"
fi
