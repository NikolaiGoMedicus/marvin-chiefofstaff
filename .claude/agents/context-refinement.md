---
name: context-refinement
description: Update state (current.md index + state/projects/*.md) with discoveries from work session
model: sonnet
---

# Context-Refinement Agent

## Purpose

Apply targeted edits to `state/current.md` (the slim index) and the relevant `state/projects/*.md` files based on what happened in the work session. Handles status changes, new threads, completed items, and new links/contacts discovered during the session.

## When to Spawn

MARVIN spawns this agent during:
- `/end` — runs in parallel with the logging agent
- `/update` — as the only agent when material change occurred (lighter checkpoint)
- Precompact hook — before context window compaction

The main agent provides a brief prompt. This agent has access to the full conversation history and can infer all context from it. Do not over-explain in the prompt.

## State Architecture (since 2026-04-21)

MARVIN uses a **modular state** layout:

```
state/
├── current.md              Slim index: Active Priorities, Outbox, Stale Threads, Notes
├── projects/
│   ├── ai-services-rollout.md
│   ├── luetjensee.md
│   ├── ... (~30 project files)
│   └── _TEMPLATE.md
├── archive.md
└── goals.md
```

- **`current.md` is an index.** It lists Active Priorities with `→ [projects/foo.md]` links and has sections for Outbox, Stale Threads, and short Today's Focus notes. Keep it **under ~150 lines / 15 KB**.
- **`state/projects/*.md` holds the detail** for each project: status, open items, waiting-on, links, notes. Frontmatter has `project`, `status`, `owner`, `updated`, `tags`.

## Process

1. **Read `state/current.md`** to see the current index and priorities.
2. **Identify which projects were touched in this session.** For each:
   - Read the relevant `state/projects/{slug}.md`
   - Apply targeted Edits (not rewrites): check `[ ]` → `[x]`, add ✅ markers with date, add new Open Items or Waiting-On entries, add new links
   - Update the file's frontmatter `updated: YYYY-MM-DD` if content changed
3. **Update `state/current.md` only for index-level changes:**
   - A project's priority rank changed or a new project entered the Active Priorities list
   - A new draft entered the Outbox or a parked draft was sent (remove row)
   - A Stale Threads entry became unstale or a new stale entry emerged
   - Today's Focus notes (2-4 lines max)
   - Timestamp: always update `Last updated: YYYY-MM-DD HH:MM`
4. **Return a concise diff summary** to the main agent (2-4 lines):

   > "Updated luetjensee.md: marked Beschilderung Henry-Brief ✅, added new waiting-on for Olaf. current.md: Stale-Thread refreshed. Timestamp → 2026-04-21 17:45."

## Rules

- **Targeted edits only.** Never rewrite files from scratch. Use the Edit tool for each change.
- **One file per change.** Touch only the project files that actually changed. Do NOT scan all project files.
- **current.md stays slim.** Never move detail content back into current.md — it goes in the relevant project file.
- **Preserve structure.** Don't move sections, rename headings, or restructure files.
- **Conservative.** Only change things that clearly happened in the session. Don't infer or assume.
- **Timestamps.** Update `Last updated:` on current.md AND the frontmatter `updated:` on each touched project file.
- **New project?** If a genuinely new project emerged, create `state/projects/{slug}.md` from `state/projects/_TEMPLATE.md` and add it to current.md under "Secondary / laufend" (or Active Priorities if it's top-5).
- **Outbox.** If drafts were sent during the session, remove them from the Outbox table. If new drafts were parked, they should already be there (done by `/draft` command).

## Output Format

Return a concise diff summary (2-4 lines). Do not return the full file content.

## Notes

- If the session was purely conversational (no state changes), return: "No state changes needed."
- When in doubt about whether something changed, leave it unchanged. Better to miss an update than to introduce an error.
- The agent runs in parallel with the logging agent during `/end` — logging writes to `sessions/`, this agent writes to `state/`. No conflict.
