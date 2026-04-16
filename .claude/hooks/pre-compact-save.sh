#!/bin/bash
# Hook: PreCompact → Auto-Save Session State
# Fires before context compaction. Instructs Claude to persist session
# state so nothing is lost when the context window gets compressed.
#
# Returns a reminder via stdout — Claude sees this before compaction runs.

TODAY=$(date +%Y-%m-%d)
TIME=$(date +%H:%M)

cat <<EOF
<pre-compact-save>
Context compaction imminent (${TIME}). Before compaction, you MUST:
1. Append a session checkpoint to sessions/${TODAY}.md (topics, decisions, open threads, next actions)
2. Update state/current.md with any new information from this session
3. After saving, proceed with compaction

This ensures continuity — post-compaction you will only have the compressed summary, not the full conversation.
</pre-compact-save>
EOF
