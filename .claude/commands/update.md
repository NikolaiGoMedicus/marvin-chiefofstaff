---
description: Quick checkpoint without ending session
---

# /update - Quick Context Checkpoint

Lightweight save without ending the session. Use frequently to preserve context.

## Instructions

### 1. Spawn Logging Agent (Checkpoint Mode)
Spawn the **logging agent** (`.claude/agents/logging.md`) to write a lightweight checkpoint.

Use the Agent tool with `subagent_type: "general-purpose"` and a prompt like:
> "You are the MARVIN logging agent. Read `.claude/agents/logging.md` for your instructions. Run the /update flow — write a checkpoint entry for today."

### 2. Spawn Context-Refinement Agent
Only if something material changed (new thread, completed item, changed priority, new link).

If nothing material changed, skip this step.

Use the Agent tool with `subagent_type: "general-purpose"` and a prompt like:
> "You are the MARVIN context-refinement agent. Read `.claude/agents/context-refinement.md` for your instructions. Update `state/current.md` based on recent work."

### 3. Confirm (minimal)
One line: "Checkpointed: {brief description}"

No summary. No "next actions" list. Just confirm the save.
