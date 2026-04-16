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

## Context

This is a MARVIN workspace. `.claude/commands/` contains Claude Code slash command files (markdown instruction files). This is a brand new file — no existing file to read.

Work from: /Users/nikolaibockholt/marvin
