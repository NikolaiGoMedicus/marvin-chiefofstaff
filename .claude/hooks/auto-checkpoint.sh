#!/bin/bash
# Hook: Stop → Auto-Checkpoint
# Reminds Claude to save session state before stopping.
# Uses a flag file with 2-min TTL to prevent infinite loops.

FLAG="/tmp/marvin-auto-checkpoint"

# If flag exists and is less than 2 minutes old → already checkpointed
# Claude has saved state between first and second fire → commit + push
if [ -f "$FLAG" ] && [ -n "$(find "$FLAG" -mmin -2 2>/dev/null)" ]; then
  cd /Users/nikolaibockholt/marvin
  git add -A
  if ! git diff --cached --quiet; then
    git commit -m "auto: sync state $(date +%Y-%m-%d\ %H:%M)" --no-gpg-sign -q
    git push origin main -q 2>/dev/null &
  fi
  exit 0
fi

touch "$FLAG"

TODAY=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)

cat <<EOF
<auto-checkpoint>
Session pausing (${TIME}). If this session involved meaningful work (decisions, research, tasks, file changes), append a brief checkpoint (3-5 lines) to sessions/${TODAY}.md and update state/current.md if needed. If this was just a quick Q&A, skip the checkpoint and stop.
</auto-checkpoint>
EOF
