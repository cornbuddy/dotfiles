#!/usr/bin/env bash

# Git status segment (gitmux-style) using only native git commands.
# Emits tmux-style #[...] codes with an explicit bar background so zjstatus
# keeps the bar color (gitmux's #[none]/#[default] resets drop the bg).

BG=#181825

branch=$(git rev-parse --abbrev-ref HEAD 2>/dev/null) || exit 0
[ "$branch" = "HEAD" ] && branch=$(git rev-parse --short HEAD 2>/dev/null)

behind=0
ahead=0
if git rev-parse --abbrev-ref '@{upstream}' 2>/dev/null | grep -q .; then
  read -r behind ahead <<<"$(git rev-list --left-right --count '@{upstream}...HEAD' 2>/dev/null)"
  behind=${behind:-0}
  ahead=${ahead:-0}
fi

staged=$(git diff --cached --name-only 2>/dev/null | wc -l)
conflict=$(git diff --name-only --diff-filter=U 2>/dev/null | wc -l)
modified=$(git diff --name-only 2>/dev/null | wc -l)
untracked=$(git ls-files --others --exclude-standard 2>/dev/null | wc -l)
stashed=$(git stash list 2>/dev/null | wc -l)

out="#[fg=white,bg=$BG,bold] ⎇  $branch"

[ "$ahead" -gt 0 ] && out+=" #[fg=cyan,bg=$BG,bold]↑·${ahead}"
[ "$behind" -gt 0 ] && out+=" #[fg=cyan,bg=$BG,bold]↓·${behind}"

out+=" #[fg=default,bg=$BG]-"

[ "$staged" -gt 0 ] && out+=" #[fg=green,bg=$BG,bold]● ${staged}"
[ "$conflict" -gt 0 ] && out+=" #[fg=red,bg=$BG,bold]✖ ${conflict}"
[ "$modified" -gt 0 ] && out+=" #[fg=red,bg=$BG,bold]✚ ${modified}"
[ "$untracked" -gt 0 ] && out+=" #[fg=magenta,bg=$BG,bold]… ${untracked}"
[ "$stashed" -gt 0 ] && out+=" #[fg=cyan,bg=$BG,bold]⚑ ${stashed}"

[ -z "$(git status --porcelain 2>/dev/null)" ] && out+=" #[fg=green,bg=$BG,bold]✔"

printf '%s\n' "$out"
