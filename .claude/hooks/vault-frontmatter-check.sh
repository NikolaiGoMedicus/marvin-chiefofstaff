#!/bin/bash
# Hook: PreToolUse (Write) → Obsidian Frontmatter Check
# Blocks Write to Obsidian vault if content doesn't start with YAML frontmatter.

VAULT_PATH="/Users/nikolaibockholt/Documents/obsidian/"

# Extract file_path from tool input JSON
FILE_PATH=$(echo "$TOOL_INPUT" | python3 -c "import sys,json; print(json.load(sys.stdin).get('file_path',''))" 2>/dev/null)

# Only check files in the vault
if [[ "$FILE_PATH" != "$VAULT_PATH"* ]]; then
  exit 0
fi

# Check if content starts with frontmatter delimiter
STARTS_WITH_FM=$(echo "$TOOL_INPUT" | python3 -c "
import sys, json
data = json.load(sys.stdin)
content = data.get('content', '')
print('yes' if content.strip().startswith('---') else 'no')
" 2>/dev/null)

if [ "$STARTS_WITH_FM" = "no" ]; then
  echo '{"decision":"deny","reason":"Obsidian vault files must start with YAML frontmatter (---). Required fields: created, source, tags. See CLAUDE.md Obsidian conventions."}'
fi
