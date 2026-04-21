---
description: Quick checkpoint without ending session
---

# /update - Quick Context Checkpoint

Lightweight save without ending the session. Use frequently to preserve context.

## State Architecture Note

MARVIN uses a **modular state** layout: `state/current.md` is a slim index, and each project has its own file under `state/projects/`. The context-refinement agent patches only the project files that actually changed.

## Instructions

### 1. Decide Which Agents to Spawn

- Always spawn the **logging agent** in checkpoint mode (short entry in `sessions/{TODAY}.md`).
- Spawn the **context-refinement agent** only if something material changed in the session (new thread, completed item, changed priority, new link, sent/parked draft).

### 2. Spawn Agents in PARALLEL

Issue agent calls in a **single message** so they run concurrently.

**Logging agent** (checkpoint mode):
> "You are the MARVIN logging agent. Read `.claude/agents/logging.md` for your instructions. Run the /update flow — write a checkpoint entry for today."

**Context-refinement agent** (only if needed):
> "You are the MARVIN context-refinement agent. Read `.claude/agents/context-refinement.md` for your instructions. Update state based on recent work — touch only the project files that actually changed."

If nothing material changed, skip the context-refinement call entirely.

### 3. Confirm (minimal)

One line: `Checkpointed: {brief description}`

No summary. No "next actions" list. Just confirm the save.

### 4. No Commit

`/update` does NOT commit or push. Commits happen only on `/end` or `/commit` (or the nightly sync safety net).
