#!/usr/bin/env bash

# Git status segment (gitmux-style) using only native git commands.
# Emits tmux-style #[...] codes with an explicit bar background so zjstatus
# keeps the bar color (gitmux's #[none]/#[default] resets drop the bg).

BG=#33475f

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

out="#[fg=#e5e9f0,bg=$BG,bold] ⎇  $branch"

[ "$ahead" -gt 0 ] && out+=" #[fg=#88c0d0,bg=$BG,bold]↑·${ahead}"
[ "$behind" -gt 0 ] && out+=" #[fg=#88c0d0,bg=$BG,bold]↓·${behind}"

out+=" #[fg=#e5e9f0,bg=$BG]-"

[ "$staged" -gt 0 ] && out+=" #[fg=#a3be8c,bg=$BG,bold]● ${staged}"
[ "$conflict" -gt 0 ] && out+=" #[fg=#bf616a,bg=$BG,bold]✖ ${conflict}"
[ "$modified" -gt 0 ] && out+=" #[fg=#bf616a,bg=$BG,bold]✚ ${modified}"
[ "$untracked" -gt 0 ] && out+=" #[fg=#b48ead,bg=$BG,bold]… ${untracked}"
[ "$stashed" -gt 0 ] && out+=" #[fg=#88c0d0,bg=$BG,bold]⚑ ${stashed}"

[ -z "$(git status --porcelain 2>/dev/null)" ] && out+=" #[fg=#a3be8c,bg=$BG,bold]✔"

printf '%s\n' "$out"
