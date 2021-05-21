#!/bin/bash

STATUS=$(cat /sys/class/power_supply/BAT1/status)
PERCENTAGE=$(cat /sys/class/power_supply/BAT1/capacity)
if [[ "$STATUS" = "Discharging" && "$PERCENTAGE" < 20 ]]; then
    /usr/bin/notify-send "Low battery: $PERCENTAGE%"
fi
