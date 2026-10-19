#!/usr/bin/env bash

# Battery segment for zjstatus.
# - Plugged (AC attached): shows a plug icon (unchanged), regular green.
# - Unplugged: shows a Font Awesome battery glyph reflecting the level:
#     >75%  battery-full (fa-battery-full)
#     51-75% battery-three-quarters
#     26-50% battery-quarter   (yellow)
#     <=25%  battery-empty     (red)
# Emits tmux-style #[...] codes with an explicit bar background.

BG=#181825

BAT=""
for t in /sys/class/power_supply/*/type; do
  [ -r "$t" ] || continue
  grep -q Battery "$t" && { BAT=$(dirname "$t"); break; }
done
[ -n "$BAT" ] || exit 0

cap=$(cat "$BAT/capacity" 2>/dev/null || echo "?")
case "$cap" in
  ''|*[!0-9]*) cap=0 ;;
esac
status=$(cat "$BAT/status" 2>/dev/null || echo "")

case "$status" in
  "Charging" | "Full" | "Not charging") plugged=1 ;;
  *) plugged=0 ;;
esac

if [ "$plugged" = "1" ]; then
  icon='\u26A1'                 # unplugged/plugged indicator
  color="#a3be8c"
elif [ "$cap" -gt 75 ]; then
  icon='\uF240'                 # battery-full
  color="#a3be8c"
elif [ "$cap" -gt 50 ]; then
  icon='\uF241'                 # battery-three-quarters
  color="#a3be8c"
elif [ "$cap" -gt 25 ]; then
  icon='\uF243'                 # battery-quarter
  color="#ebcb8b"               # nord13 (yellow)
else
  icon='\uF244'                 # battery-empty
  color="#bf616a"               # nord11 (red)
fi

glyph=$(printf "$icon")
printf '#[bg=%s,fg=%s,,bold]%s %s%%' "$BG" "$color" "$glyph" "$cap"
