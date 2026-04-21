---
description: Archive completed work and trim stale content
---

# /compact - Archive & Trim

Archive completed projects and trim stale content across the modular state. Operates on **project files** (`state/projects/*.md`), not on `current.md` globally.

## State Architecture

`state/current.md` is a slim index. Detail content lives in `state/projects/*.md` with frontmatter (`project`, `status`, `owner`, `updated`, `tags`). `/compact` works on these files.

## Instructions

### 1. Scan for Archivable Projects & Sections

Iterate `state/projects/*.md`. For each file, check:

**a) Project-level archive candidates:**
- Frontmatter `status: done` → candidate for full archive
- Frontmatter `status: paused` AND `updated` > 90 days ago → suggest archive

**b) Section-level archive candidates within a file:**
- `## Open Items` where every `[ ]` is `[x]` or `✅` → candidate to compress into a `## History` block in-place (not moved out of the file)

### 2. Show Candidates

If no candidates found:
> "Nothing to archive. All project files have active work."

Otherwise list candidates grouped by type:

> **Project-level archive candidates (2):**
> 1. `hardware-standards.md` — status: waiting, no activity since 27.03. → move to archive?
> 2. `alice-offboarding.md` — status: waiting, waiting on Q3 decision → move to archive?
>
> **Section-level compress candidates (3):**
> 1. `luetjensee.md` / Hardware-Inventar — all items ✅ → compress to one-line in History?
> 2. ...
>
> **Action?** (yes = all / select numbers / no)

Wait for confirmation.

### 3. Archive (Project-Level)

For each approved project-level archive:

**a) Read or create `state/archive.md`:**

```markdown
# Archive

Completed / dormant projects moved from state/projects/ by /compact.
```

**b) Find or create the current-month heading:** `## YYYY-MM (Month Name)` (newest month at top, after the file header).

**c) Append a condensed summary under the month heading:**

```markdown
### {Project Title} — archived {DD.MM.}

**Outcome:** {1-3 sentence summary of status when archived.}

**Key links:**
- {Notion / Google Doc / etc.}

Full history: `state/projects/archive/{YYYY-MM}/{slug}.md` (if preserved).
```

**d) Move the file:** `mv state/projects/{slug}.md state/projects/archive/{YYYY-MM}/{slug}.md` (create dirs as needed). Do NOT delete — keep the full file for historical lookup.

**e) Remove the project's row from `state/current.md`** (Active Priorities or Secondary list).

### 4. Compress (Section-Level)

For each approved section-level compress:

- Read the section
- Collapse the fully-done Open Items into a single line under a new or existing `## History` block:
  - `### {Section name} — completed {DD.MM.}` + 1-2 lines of outcome + key links
- Remove the detailed checkboxes
- Update the file's frontmatter `updated:` to today

### 5. Report

```
Archived: 2 projects (hardware-standards, alice-offboarding)
Compressed: 3 sections across 2 files
current.md: 53 → 51 lines
archive.md: {before} → {after} lines
```

## Rules

- **Never archive `goals.md` or `current.md`.**
- **Never archive a project file with `status: active`.**
- **Compress, don't delete.** Full content must remain retrievable — archived files move, they don't disappear.
- **Always ask before acting.** `/compact` is destructive-enough to warrant confirmation even though it's reversible.
