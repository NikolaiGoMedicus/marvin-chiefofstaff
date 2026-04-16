# MARVIN Improvements Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Add calendar briefing, stale thread detection, draft outbox, archive compaction, and logging/context-refinement agents to MARVIN.

**Architecture:** All changes are markdown instruction files (slash commands and agent definitions). No application code. Commands live in `.claude/commands/`, agents in `.claude/agents/`, state in `state/`. Commands are Claude Code slash command files — they instruct the LLM what to do when invoked.

**Tech Stack:** Markdown, Claude Code slash commands, MCP tools (Google Workspace `get_events`)

**Note:** These are prompt/instruction files, not application code. There are no unit tests. "Testing" means running the command and verifying it behaves correctly. Each task includes a verification step.

---

### Task 1: Add Calendar-Pull to /start

**Files:**
- Modify: `.claude/commands/start.md`

- [ ] **Step 1: Add calendar loading step to start.md**

Replace the entire contents of `.claude/commands/start.md` with:

```markdown
---
description: Start MARVIN session - load context, give briefing
---

# /start - Start MARVIN Session

Start up as MARVIN (Manages Appointments, Reads Various Important Notifications), your AI Chief of Staff.

## Instructions

### 1. Establish Date
Run `date +%Y-%m-%d` to get today's date. Store as TODAY.
Run `date +%H:%M` to get current time. Store as NOW.

### 2. Load Context (read these files in order)
- `CLAUDE.md` - Core instructions and context
- `state/current.md` - Current priorities and state
- `state/goals.md` - Your goals
- `sessions/{TODAY}.md` - If exists, we're resuming today's session
- If no today file, read the most recent file in `sessions/` for continuity

### 3. Load Calendar
- Call `get_events` for TODAY (all-day + timed events)
- Call `get_events` for tomorrow (preview of what's coming)

### 4. Present Briefing
Give a concise briefing:
- Date and day of week
- Top priorities from state/current.md
- **Today's calendar** — list meetings with time, title, and attendees (abbreviated). Flag conflicts or back-to-back blocks. If resuming today (session log exists), only show events after NOW.
- **Tomorrow preview** — brief list of scheduled events
- Any open threads or items needing attention
- Ask how to help today

Keep it concise. Offer details on request.

If resuming a session (today's log exists), acknowledge what was already covered.
```

- [ ] **Step 2: Verify**

Run `/start` in a test conversation. Confirm:
1. Calendar events for today appear in the briefing
2. Tomorrow's events appear as preview
3. All other briefing content (priorities, threads) still works

- [ ] **Step 3: Commit**

```bash
git add .claude/commands/start.md
git commit -m "feat: add calendar pull to /start briefing"
```

---

### Task 2: Add Stale Thread Detector to /start

**Files:**
- Modify: `.claude/commands/start.md`

- [ ] **Step 1: Add stale detection step and briefing output**

In `.claude/commands/start.md`, add a new step between "Load Calendar" and "Present Briefing". Replace from `### 4. Present Briefing` to end of file with:

```markdown
### 4. Detect Stale Threads
Scan `state/current.md` for open items:
- Unchecked `[ ]` todos
- "Warten auf" entries
- Items with "offen" or "ausstehend" keywords

For each item, extract a key identifier (person name, project name, or ticket ID). Search the last 14 days of session logs (`sessions/YYYY-MM-DD.md`) for mentions of that identifier.

If an item has no mention in any session log from the last 14 days, mark it as stale. Record the date of the last session log that mentioned it (or "no record" if never mentioned).

### 5. Present Briefing
Give a concise briefing:
- Date and day of week
- Top priorities from state/current.md
- **Today's calendar** — list meetings with time, title, and attendees (abbreviated). Flag conflicts or back-to-back blocks. If resuming today (session log exists), only show events after NOW.
- **Tomorrow preview** — brief list of scheduled events
- **Outbox** — if `## Outbox` section exists in current.md and has entries, show count and summary (e.g., "2 unsent drafts in outbox (Slack DM Jens x2)")
- **Stale threads (>14 days)** — show top 3-5 stalest items with last-seen date. If more exist, show count and offer full list on request. Example:
  ```
  **Stale threads (>14 days):**
  - Olaf Rajek — IP→Sprechzimmer Mapping (last: 12.03.)
  - Philipp Gonser — ZDS Bürosysteme (last: 05.02.)
  - 3 more... ask for full list
  ```
- Any other open threads needing attention
- Ask how to help today

Keep it concise. Offer details on request.

If resuming a session (today's log exists), acknowledge what was already covered.
```

- [ ] **Step 2: Verify**

Run `/start`. Confirm:
1. Stale thread section appears in briefing
2. Items correctly identified as stale (cross-reference with session logs)
3. Calendar and priorities still display correctly

- [ ] **Step 3: Commit**

```bash
git add .claude/commands/start.md
git commit -m "feat: add stale thread detector and outbox count to /start"
```

---

### Task 3: Create /draft Command

**Files:**
- Create: `.claude/commands/draft.md`

- [ ] **Step 1: Create draft.md**

Create `.claude/commands/draft.md` with this content:

```markdown
---
description: Review, send, or park message drafts
---

# /draft - Draft Review & Outbox

Review a message draft for tone and correctness, then send, edit, or park it. Also manages the outbox of parked drafts.

## Instructions

### Mode Detection

**If a draft was just written or discussed in this conversation:**
→ Go to "Review Draft" flow

**If no draft context exists (user just typed /draft):**
→ Go to "Manage Outbox" flow

---

### Review Draft Flow

#### 1. Identify the Draft
Extract from conversation context:
- The message text
- Target channel (Slack DM, Slack channel, Email, etc.)
- Recipient(s)

If any of these are unclear, ask.

#### 2. Review
Check the draft for:
- **Tone** — should be casual, friendly, no corporate speak (per Nikolai's style)
- **Completeness** — does it cover what was discussed? Missing context?
- **Recipient** — correct person/channel?
- **Risk** — anything that could be misread? Sensitive content? Wrong audience?

Show the final draft formatted for the target channel. If you made adjustments, show what changed and why.

#### 3. Ask for Action
Present three options:

> **Draft ready.** What do you want to do?
> 1. **Send** — I'll send it now (you'll confirm first)
> 2. **Edit** — let's revise it
> 3. **Park** — save to outbox for later

**Send:** Show the exact message one more time and ask "Confirm send?" Before sending, always get explicit confirmation. This respects the "never send directly" rule — Nikolai decides when to fire.

**Edit:** Iterate on the draft. Return to step 2 after changes.

**Park:** Add to the Outbox section in `state/current.md`. Use the format below.

#### 4. Park to Outbox
If the user chooses "Park", add/update the Outbox section in `state/current.md`.

The Outbox section goes after `## Active Priorities` and before `## Open Threads`:
```markdown
## Outbox

| Draft | Channel | Parked | Status |
|-------|---------|--------|--------|
| {short description} | {Slack DM X / Slack #channel / Email to X} | {DD.MM.} | ready |
```

If the section already exists, append a row. If it doesn't exist, create it in the correct position.

Store the full draft text as a blockquote below the table, labeled with the draft name:
```markdown
**{short description}:**
> {full draft text}
```

Confirm: "Parked. Will show up in your next /start briefing."

---

### Manage Outbox Flow

#### 1. Load Outbox
Read the `## Outbox` section from `state/current.md`.

If no Outbox section exists or it's empty:
> "Outbox is empty. No parked drafts."
Done.

#### 2. Show Drafts
Display the outbox table and ask:
> "Which draft do you want to review? Or say 'clear sent' to remove sent items."

#### 3. For Each Selected Draft
Show the full stored draft text and offer the same three actions: Send, Edit, Park (keep), or Delete.

**Delete:** Remove the row from the table and the stored draft text. Confirm: "Removed from outbox."

**Send:** Same flow as Review Draft → Send above. After successful send, remove from outbox.
```

- [ ] **Step 2: Verify**

Test both flows:
1. Write a Slack draft in conversation, then run `/draft` → should enter Review mode
2. Run `/draft` cold → should enter Outbox management mode
3. Park a draft → verify it appears in current.md under `## Outbox`

- [ ] **Step 3: Commit**

```bash
git add .claude/commands/draft.md
git commit -m "feat: add /draft command with outbox tracking"
```

---

### Task 4: Create /compact Command

**Files:**
- Create: `.claude/commands/compact.md`

- [ ] **Step 1: Create compact.md**

Create `.claude/commands/compact.md` with this content:

```markdown
---
description: Archive completed sections from current.md
---

# /compact - Archive Completed Items

Move fully-completed sections from `state/current.md` to `state/archive.md` to keep the active state file lean.

## Instructions

### 1. Scan for Archivable Sections

Read `state/current.md` and identify sections (### headings under `## Open Threads`) that meet ALL of these criteria:
- Every `[ ]` checkbox in the section is checked `[x]` or replaced with ✅
- No unchecked `[ ]` items remain
- No "Warten auf" items (even if old)
- Section is explicitly marked "✅ Erledigt" or all work is visibly complete

**Never archive:**
- `## Active Priorities` (always stays)
- `## Outbox` (always stays)
- Any section with at least one open `[ ]`
- Any section with a "Warten auf" entry

### 2. Show Candidates

If no archivable sections found:
> "Nothing to archive. All sections have open items."
Done.

If candidates found, list them:
> **Found {N} archivable sections:**
> 1. Virtual Backgrounds (Sales Team) — ✅ complete
> 2. IGP Stundenzettel Q1 — ✅ complete
>
> **Move to archive?** (yes/no/select specific)

Wait for confirmation. User can say "yes" (all), "no" (abort), or pick specific items by number.

### 3. Archive

For each confirmed section:

**a) Read or create `state/archive.md`:**
If the file doesn't exist, create it with:
```markdown
# Archive

Completed items moved from current.md by /compact.
```

**b) Find or create the current month heading:**
Format: `## YYYY-MM (Month Name)`
Example: `## 2026-04 (April)`

If the heading doesn't exist, add it at the top (after the file header) so newest months appear first.

**c) Add the archived section under the month heading:**
```markdown
### {Section Title} — archived {DD.MM.}
{Condensed content: key outcome + links. Remove redundant checkboxes. Keep links and references.}
```

**d) Remove the section from `state/current.md`.**

### 4. Report

Show the result:
> **Archived {N} sections.**
> current.md: {before} → {after} lines.
> Archive: `state/archive.md`
```

- [ ] **Step 2: Verify**

Run `/compact`. Confirm:
1. It correctly identifies completed sections
2. It asks for confirmation before moving anything
3. Archived content appears in `state/archive.md` under correct month
4. Removed sections are gone from `state/current.md`
5. No open items were accidentally archived

- [ ] **Step 3: Commit**

```bash
git add .claude/commands/compact.md
git commit -m "feat: add /compact command for current.md archiving"
```

---

### Task 5: Create Logging Agent

**Files:**
- Create: `.claude/agents/logging.md`

- [ ] **Step 1: Create logging.md**

Create `.claude/agents/logging.md` with this content:

```markdown
---
name: logging
description: Generate clean session log entries from conversation history
model: sonnet
---

# Logging Agent

## Purpose

Generate structured session log entries from the main agent's conversation history. Handles the mechanical work of extracting topics, decisions, threads, and actions so the main agent can focus on higher-level work.

## When to Spawn

MARVIN spawns this agent during:
- `/end` — full session log entry
- `/update` — lightweight checkpoint entry

The main agent provides a brief prompt. This agent has access to the full conversation history and can infer all context from it. Do not over-explain in the prompt.

## Process

### For /end (Full Session Log)

1. Get today's date: `date +%Y-%m-%d`
2. Get current time: `date +%H:%M`
3. Determine session label from time:
   - Before 12:00 → "Vormittag"
   - 12:00–17:00 → "Nachmittag"
   - 17:00–21:00 → "Abend"
   - After 21:00 → "Nacht"
   - Always verify with `date` — never guess.
4. Read `sessions/{TODAY}.md` to check for existing entries
5. Review the conversation and extract:
   - **Topics** — what was worked on (with detail, not just titles)
   - **Decisions** — what was decided and why
   - **Open Threads** — what's unfinished or needs follow-up
   - **Next Actions** — concrete next steps with owners where applicable
   - **Artefakte** — files, docs, links created or modified
6. Append to `sessions/{TODAY}.md` (create with header `# Session Log: {TODAY}` if new):

```
## Session: {Label} ({start_time}–{end_time})

### Topics
- **{Topic}** — {detail}

### Decisions
- {decision}

### Open Threads
- {thread}

### Next Actions
- [ ] {action}

### Artefakte
- {artefakt with link}
```

7. Return a one-line summary to the main agent: "Session logged: {N} topics, {N} decisions, {N} open threads, {N} actions."

### For /update (Checkpoint)

1. Get today's date and time
2. Append to `sessions/{TODAY}.md`:

```
## Update: {HH:MM}
- {what was worked on, 1-3 bullets}
```

3. Return: "Checkpointed: {brief description}"

## Output Format

Return a single summary line. Do not return the full log content — the main agent doesn't need it in context.

## Notes

- Session time labels MUST be verified with `date` — see memory rule about session labeling
- If the session log already has an entry for a similar time range, append — don't overwrite
- Keep Topics detailed enough that someone reading the log next week understands what happened
- Artefakte section is optional — only include if files/docs were created or significantly modified
```

- [ ] **Step 2: Commit**

```bash
git add .claude/agents/logging.md
git commit -m "feat: add logging agent for session log generation"
```

---

### Task 6: Create Context-Refinement Agent

**Files:**
- Create: `.claude/agents/context-refinement.md`

- [ ] **Step 1: Create context-refinement.md**

Create `.claude/agents/context-refinement.md` with this content:

```markdown
---
name: context-refinement
description: Update current.md with discoveries from work session
model: sonnet
---

# Context-Refinement Agent

## Purpose

Apply targeted edits to `state/current.md` based on what happened in the work session. Handles status changes, new threads, completed items, and new links/contacts discovered during the session.

## When to Spawn

MARVIN spawns this agent during:
- `/end` — after the logging agent finishes
- `/update` — as the only agent (lighter checkpoint)
- Precompact hook — before context window compaction

The main agent provides a brief prompt. This agent has access to the full conversation history and can infer all context from it. Do not over-explain in the prompt.

## Process

1. Read `state/current.md` to get the current state
2. Review the conversation history and identify changes:
   - **Status changes** — items that moved from open to done, or got new status
   - **New threads** — topics that emerged and need tracking
   - **Completed items** — checkboxes to check, sections to mark done
   - **New links/artifacts** — Google Docs, Notion pages, Figma files created
   - **New contacts/details** — names, emails, phone numbers discovered
   - **Updated details** — dates, amounts, decisions that supersede old info
   - **Outbox changes** — drafts that were sent (remove from outbox) or parked (add to outbox)
3. Apply targeted edits to `state/current.md`:
   - Use the Edit tool for precise changes — do NOT rewrite the entire file
   - Check `[ ]` items that were completed → `[x]`
   - Add ✅ markers with dates where applicable
   - Add new threads under the appropriate `### Work -` section
   - Update "Last updated" timestamp at the top
4. Return a diff summary to the main agent:
   > "Updated current.md: marked 2 items ✅, added 1 new thread (LMS Entscheidung), updated Outbox (removed 1 sent draft). Last updated → {timestamp}."

## Rules

- **Targeted edits only.** Never rewrite current.md from scratch. Use Edit tool for each change.
- **Preserve structure.** Don't move sections around, rename headings, or restructure the file.
- **Conservative.** Only change things that clearly happened in the session. Don't infer or assume.
- **Timestamp.** Always update `Last updated: YYYY-MM-DD HH:MM` at the top of current.md.
- **Outbox.** If drafts were sent during the session, remove them from the Outbox table. If new drafts were parked, they should already be there (done by /draft command).

## Output Format

Return a concise diff summary (2-4 lines). Do not return the full file content.

## Notes

- If the session was purely conversational (no state changes), return: "No state changes needed."
- When adding new threads, place them under the most relevant existing `### Work -` section. If no section fits, create a new one following the existing naming pattern.
- When in doubt about whether something changed, leave it unchanged. Better to miss an update than to introduce an error.
```

- [ ] **Step 2: Commit**

```bash
git add .claude/agents/context-refinement.md
git commit -m "feat: add context-refinement agent for state updates"
```

---

### Task 7: Update /end and /update to Spawn Agents

**Files:**
- Modify: `.claude/commands/end.md`
- Modify: `.claude/commands/update.md`

- [ ] **Step 1: Rewrite end.md to use agents**

Replace the entire contents of `.claude/commands/end.md` with:

```markdown
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
```

- [ ] **Step 2: Rewrite update.md to use context-refinement agent**

Replace the entire contents of `.claude/commands/update.md` with:

```markdown
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
```

- [ ] **Step 3: Verify**

Run `/update` during a session. Confirm:
1. Logging agent spawns and writes checkpoint to session log
2. Context-refinement agent spawns (if state changed) and updates current.md
3. Confirmation message is concise

- [ ] **Step 4: Commit**

```bash
git add .claude/commands/end.md .claude/commands/update.md
git commit -m "feat: update /end and /update to spawn logging + context-refinement agents"
```

---

### Task 8: Update /help and CLAUDE.md

**Files:**
- Modify: `.claude/commands/help.md`
- Modify: `CLAUDE.md`

- [ ] **Step 1: Add /draft and /compact to help.md**

In `.claude/commands/help.md`, replace the command table (lines 17-27) with:

```
| Command   | What It Does                        |
|-----------|-------------------------------------|
| /start    | Start a session with a briefing     |
| /end      | End session and save everything     |
| /update   | Quick checkpoint (save progress)    |
| /draft    | Review, send, or park message drafts|
| /compact  | Archive completed items from state  |
| /report   | Generate a weekly summary of work   |
| /commit   | Review and commit git changes       |
| /code     | Open MARVIN in your IDE             |
| /status   | Check integration & workspace health|
| /help     | Show this help guide                |
| /sync     | Get updates from MARVIN template    |
```

- [ ] **Step 2: Add /draft and /compact to CLAUDE.md**

In `CLAUDE.md`, replace the Slash Commands table (the one under `### Slash Commands (inside MARVIN)`) with:

```
| Command | What It Does |
|---------|--------------|
| `/start` | Start a session with a briefing |
| `/end` | End session and save everything |
| `/update` | Quick checkpoint (save progress) |
| `/draft` | Review, send, or park message drafts |
| `/compact` | Archive completed items from state |
| `/report` | Generate a weekly summary of work |
| `/commit` | Review and commit git changes |
| `/code` | Open MARVIN in your IDE |
| `/help` | Show commands and available integrations |
| `/sync` | Get updates from MARVIN template |
```

- [ ] **Step 3: Add archive.md and agents to CLAUDE.md Architecture section**

In `CLAUDE.md`, after the `state/goals.md` line in the "Critical State Files" section, add:

```markdown
- **`state/archive.md`** — Completed items archived from current.md by `/compact`. Organized by month, newest first.
```

After the "Template Source" section, add a new section:

```markdown
### Agents (`.claude/agents/`)

Subagents handle heavy lifting during session management:

- **logging** — Generates session log entries. Spawned by `/end` and `/update`. Model: sonnet.
- **context-refinement** — Updates `state/current.md` with session discoveries. Spawned by `/end`, `/update`, and precompact hook. Model: sonnet.
```

- [ ] **Step 4: Commit**

```bash
git add .claude/commands/help.md CLAUDE.md
git commit -m "docs: add /draft, /compact, agents to help and CLAUDE.md"
```

---

## Task Dependency Order

```
Task 1 (calendar in /start)
  → Task 2 (stale detector in /start — modifies same file)
    → Task 3 (/draft command — standalone, but Task 2 already includes outbox count in briefing)
      → Task 4 (/compact — standalone)
        → Task 5 (logging agent — standalone)
          → Task 6 (context-refinement agent — standalone)
            → Task 7 (/end + /update rewrites — depends on agents existing)
              → Task 8 (docs — depends on all features existing)
```

Tasks 3-6 are technically independent but ordered this way for clean sequential commits. Tasks 1→2 and 7→8 have real dependencies.
