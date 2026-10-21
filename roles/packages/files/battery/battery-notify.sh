#!/usr/bin/env bash
set -u

BAT="${BATTERY_DEVICE:-$(ls -d /sys/class/power_supply/BAT* 2>/dev/null | head -1)}"
STATE_DIR="${XDG_RUNTIME_DIR:-/tmp}"
STATE_FILE="$STATE_DIR/battery-notify-state"

notify() {
  local urgency="$1" msg="$2"
  notify-send -a "battery" -u "$urgency" -i "battery" "Battery" "$msg" 2>/dev/null
}

[ -n "$BAT" ] || exit 0

capacity=$(cat "$BAT/capacity" 2>/dev/null) || exit 0
status=$(cat "$BAT/status" 2>/dev/null) || status="Unknown"

case "$status" in
  Charging | Full | "Not charging")
    printf '100\n' > "$STATE_FILE"
    exit 0
    ;;
esac

last=$(cat "$STATE_FILE" 2>/dev/null || printf '100')
last=${last:-100}

new_last="$last"

if [ "$capacity" -le 5 ] && [ "$last" -gt 5 ]; then
  notify critical "Battery critically low: ${capacity}%"
  new_last=5
elif [ "$capacity" -le 10 ] && [ "$last" -gt 10 ]; then
  notify critical "Battery critically low: ${capacity}%"
  new_last=10
elif [ "$capacity" -le 20 ] && [ "$last" -gt 20 ]; then
  notify normal "Battery low: ${capacity}%"
  new_last=20
fi

printf '%s\n' "$new_last" > "$STATE_FILE"