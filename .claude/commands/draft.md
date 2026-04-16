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
