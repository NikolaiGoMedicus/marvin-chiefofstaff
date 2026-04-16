#!/bin/bash
# Nightly safety net: commit + push any uncommitted MARVIN state
# Runs via launchd at 23:00 daily — catches sessions where /end wasn't run

cd /Users/nikolaibockholt/marvin || exit 1

git add -A
if ! git diff --cached --quiet; then
  git commit -m "auto: nightly sync $(date +%Y-%m-%d)" --no-gpg-sign -q
  git push origin main -q
fi
