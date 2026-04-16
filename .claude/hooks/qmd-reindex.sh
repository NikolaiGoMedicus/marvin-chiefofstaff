#!/bin/bash
# Hook: PostToolUse (Write|Edit) → QMD Auto-Reindex
# Triggers `qmd embed` in background after writing to Obsidian vault.

VAULT_PATH="/Users/nikolaibockholt/Documents/obsidian/"

# Check if the tool input targets a file in the vault
if echo "$TOOL_INPUT" | grep -q "$VAULT_PATH"; then
  # Don't stack multiple embeds
  if ! pgrep -f "qmd embed" > /dev/null 2>&1; then
    nohup qmd embed > /tmp/qmd-reindex.log 2>&1 &
  fi
fi
