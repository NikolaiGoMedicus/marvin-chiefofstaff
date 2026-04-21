---
description: End MARVIN session - save context and state
---

# /end - End MARVIN Session

Wrap up the current session, save context, and commit changes.

## State Architecture Note

MARVIN uses a **modular state** layout: `state/current.md` is a slim index, and each project has its own file under `state/projects/`. Details live in project files; current.md holds priorities, Outbox, Stale Threads, and short notes.

## Instructions

### 1. Summarize This Session

Review the conversation and prepare a brief summary of:
- **Topics discussed** — What did we work on?
- **Decisions made** — What was decided?
- **Open threads** — What's unfinished or needs follow-up?
- **Action items** — What needs to happen next?

### 2. Spawn Logging + Context-Refinement Agents in PARALLEL

Issue BOTH Agent tool calls in a **single message** so they run concurrently. No waiting between them. No file conflicts: logging writes to `sessions/`, context-refinement writes to `state/`.

**Logging agent** (writes to `sessions/{TODAY}.md`):
> "You are the MARVIN logging agent. Read `.claude/agents/logging.md` for your instructions. Run the /end flow — write a full session log entry for today."

**Context-refinement agent** (updates `state/current.md` + relevant `state/projects/*.md`):
> "You are the MARVIN context-refinement agent. Read `.claude/agents/context-refinement.md` for your instructions. Update state based on this session's work — touch only the project files that actually changed."

Wait for BOTH to return before continuing.

### 3. Clean Outbox

Check `state/current.md` for the `## Outbox` section. If any drafts were sent during this session, remove them from the Outbox table (if the context-refinement agent didn't already do it).

### 4. Commit + Push

Run a single synchronous commit+push. Auto-checkpoint via Stop-hook is OFF — this step is the authoritative place where MARVIN work lands in git.

```bash
cd /Users/nikolaibockholt/marvin
git add -A
if ! git diff --cached --quiet; then
  git commit -m "session: $(date +%Y-%m-%d) end" --no-gpg-sign
  git push origin main
fi
```

If there is truly nothing staged (e.g. pure conversational session, no edits), skip the commit.

### 5. Confirm

Show a brief summary:
- What was logged (from logging agent)
- What state changed (from context-refinement agent)
- Commit hash pushed (or "no changes")
- Key items for next session

Keep it concise. Multiple sentences, not a wall of text.
