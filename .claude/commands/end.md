---
description: End MARVIN session - save context and state
---

# /end - End MARVIN Session

Wrap up the current session and save context for continuity.

## Instructions

### 1. Summarize This Session
Review the conversation and prepare a brief summary of:
- **Topics discussed** - What did we work on?
- **Decisions made** - What was decided?
- **Open threads** - What's unfinished or needs follow-up?
- **Action items** - What needs to happen next?

### 2. Spawn Logging Agent
Spawn the **logging agent** (`.claude/agents/logging.md`) to write the session log entry.

Use the Agent tool with `subagent_type: "general-purpose"` and a prompt like:
> "You are the MARVIN logging agent. Read `.claude/agents/logging.md` for your instructions. Run the /end flow — write a full session log entry for today."

Wait for the agent to complete and confirm the log was written.

### 3. Spawn Context-Refinement Agent
Spawn the **context-refinement agent** (`.claude/agents/context-refinement.md`) to update state.

Use the Agent tool with `subagent_type: "general-purpose"` and a prompt like:
> "You are the MARVIN context-refinement agent. Read `.claude/agents/context-refinement.md` for your instructions. Update `state/current.md` based on this session's work."

Wait for the agent to complete and confirm state was updated.

### 4. Clean Outbox
Check `state/current.md` for the `## Outbox` section. If any drafts were sent during this session, remove them from the Outbox table.

### 5. Confirm
Show a brief summary:
- What was logged (from logging agent)
- What state changed (from context-refinement agent)
- Key items for next session

Keep it concise.
