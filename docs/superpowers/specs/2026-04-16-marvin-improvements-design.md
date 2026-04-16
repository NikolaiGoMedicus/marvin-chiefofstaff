# MARVIN Improvements — Design Spec

**Date:** 2026-04-16
**Scope:** 3 quick wins + 2 big wins for MARVIN workspace

---

## 1. Calendar-Pull in /start

### What
Add today's + tomorrow's calendar to the /start briefing.

### Changes to `start.md`
Add step between "Load Context" and "Present Briefing":

**Step 2.5 — Load Calendar:**
- Call `get_events` for today (all-day + timed events)
- Call `get_events` for tomorrow (preview)

**In the briefing**, add "Today's calendar" section after date/priorities:
- List meetings: time, title, attendees (abbreviated)
- Flag conflicts or back-to-back blocks
- If resuming today (session log exists): filter out past events using `date +%H:%M`

---

## 2. Stale Thread Detector in /start

### What
Flag open items in current.md that haven't been mentioned in session logs for 14+ days.

### Detection Logic
- Parse current.md for open items: unchecked `[ ]` todos, "Warten auf" entries, "offen" keywords
- For each item, search last 14 days of session logs for keyword matches (project name, person name, ticket ID)
- No mention in 14 days = stale

### Briefing Output
Show top 3-5 stalest items with last-seen date after calendar:
```
**Stale threads (>14 days):**
- Olaf Rajek — IP→Sprechzimmer Mapping (last: 12.03.)
- Philipp Gonser — ZDS Bürosysteme (last: 05.02.)
- 3 more... ask for full list
```

### Changes
- `start.md`: add stale detection step + briefing section

---

## 3. /draft Command with Outbox

### What
Dedicated command for reviewing, sending, or parking message drafts. Includes persistent outbox tracking in state.

### /draft Command Flow
1. Takes current conversation context (draft just written or discussed)
2. Checks: tone (casual per Nikolai's style), completeness, recipient correctness, anything risky
3. Shows final draft formatted for target channel (Slack/Email/etc.)
4. Asks: "Send, edit, or park?"
   - **Send** → confirm and send (respects "never send directly" rule — always shows draft first)
   - **Edit** → iterate on the draft
   - **Park** → save to outbox for later

### /draft without context
When called without a recent draft in conversation, lists and manages parked drafts:
- Show outbox table
- Offer to review/send/delete individual drafts

### Outbox in current.md
New section after Active Priorities, before Open Threads:
```markdown
## Outbox

| Draft | Channel | Parked | Status |
|-------|---------|--------|--------|
| CDIO Update | Slack DM Jens | 16.04. | ready |
| Skills Konsolidierung | Slack DM Jens | 16.04. | ready |
```

### Integration with other commands
- **/start** surfaces outbox count: "2 unsent drafts in outbox (Slack DM Jens x2)"
- **/end** cleans up sent drafts (removes from outbox)

### New file
- `.claude/commands/draft.md`

---

## 4. /compact — current.md Archiving

### What
Manual command to move fully-completed sections from current.md to an archive file.

### Archiving Rules (Conservative)
**Archive when:**
- ALL items in a section are checked ✅
- No remaining `[ ]` in the section
- Section explicitly marked "✅ Erledigt" or equivalent

**Keep when:**
- At least one open `[ ]` exists
- Any "Warten auf" item present (even if old)
- Active Priorities section (always stays)
- Outbox section (always stays)

### Archive File: `state/archive.md`
Organized by month:
```markdown
# Archive

## 2026-04 (April)

### Virtual Backgrounds (Sales Team) — archived 16.04.
✅ 2 Backgrounds erstellt (GoMedicus + MedKitDoc), Figma + Notion fertig.
- Figma: [link] · Notion: [link]

### IGP Stundenzettel Q1 — archived 16.04.
✅ Stundennachweise erstellt, Excel an Arved übergeben.
- Ergebnis: Nikolai 378h, Sebastian 378h, Friederike 138h, Florian 420h, Alice 370h
```

### /compact Command Flow
1. Scan current.md for fully-completed sections
2. Show candidates: "Found 4 archivable sections: Virtual Backgrounds, IGP Stundenzettel, Hardware-Standards, Slack Konsolidierung. Move to archive?"
3. On confirm: move to archive.md under current month heading, remove from current.md
4. Report: "current.md: 554 → ~420 lines. 4 sections archived."

### New files
- `.claude/commands/compact.md`
- `state/archive.md` (created on first run)

---

## 5. Logging + Context-Refinement Agents

### Logging Agent

**File:** `.claude/agents/logging.md`
**Model:** sonnet
**Spawned by:** /end, /update

**Purpose:** Generate clean session log entries from conversation history.

**Process:**
1. Receives full conversation context
2. Extracts: topics discussed, decisions made, open threads, next actions, artefacts created
3. Formats and writes session log entry to `sessions/{TODAY}.md`
4. Returns summary to main agent

**Why separate:** Frees main context window from mechanical log formatting. Especially valuable in long sessions where main agent context is tight.

### Context-Refinement Agent

**File:** `.claude/agents/context-refinement.md`
**Model:** sonnet
**Spawned by:** /end, /update, precompact hook

**Purpose:** Update current.md with discoveries from the work session.

**Process:**
1. Receives conversation context + current state of current.md
2. Identifies: new threads, status changes, completed items, new contacts/links/artifacts
3. Applies targeted edits to current.md (not a full rewrite)
4. Returns diff summary: "Updated 3 sections, added 1 new thread, marked 2 items ✅"

**Why separate:** current.md edits are error-prone in a full context window. Dedicated agent with focused task produces cleaner, more reliable updates.

### Integration with Existing Commands
- **/end:** calls logging agent first, then context-refinement agent (sequential — logging output informs what changed)
- **/update:** calls context-refinement agent only (lighter checkpoint)

---

## Files Summary

### New files
| File | Purpose |
|------|---------|
| `.claude/commands/draft.md` | /draft command |
| `.claude/commands/compact.md` | /compact command |
| `.claude/agents/logging.md` | Session log agent |
| `.claude/agents/context-refinement.md` | State update agent |
| `state/archive.md` | Archive for completed items |

### Modified files
| File | Changes |
|------|---------|
| `.claude/commands/start.md` | Add calendar pull, stale detector, outbox count |
| `.claude/commands/end.md` | Spawn agents, clean outbox |
| `.claude/commands/update.md` | Spawn context-refinement agent |
| `.claude/commands/help.md` | Add /draft, /compact to command table |
| `CLAUDE.md` | Document new commands + agents |
