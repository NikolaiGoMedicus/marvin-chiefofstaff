# /triage-slack - Triage Slack Inbox

Triagiere offene Slack-Items: identifiziere neue Nachrichten, die deine Aktion verlangen, und erkenne Smart-Close-Kandidaten für bereits offene Items.

## Usage

- `/triage-slack` — Normaler Lauf: fetch + klassifiziere + schreibe nach Bestätigung
- `/triage-slack --dry` — Dry-Run: nur zeigen, kein State-Write

## Instructions

### 1. Check State File Exists

Read `state/channels/slack.md`.

Wenn das File fehlt:
- Bootstrap aus Template (siehe `docs/superpowers/plans/2026-04-24-channel-agents-slack-mvp.md` Task 1).
- Sei explizit: "State-File neu angelegt. Erster Run fetcht letzte 7 Tage."
- Setze `last_run = now - 7d` für den initialen Fetch.

### 2. Parse State

Extrahiere aus Frontmatter:
- `last_run` — Timestamp des letzten Runs, oder `null` (dann `now - 7d` als Default).

Parse Tabellen:
- `Open Items` — Liste bestehender offener Items (ID, Since, Source, Summary, Project, Link).
- `Recently Closed` — Liste, um Re-Open-Detection zu ermöglichen.

### 3. Spawn Subagent

Vor dem Spawn: Main liest `SLACK_USER_ID` aus `.env`:
```bash
grep '^SLACK_USER_ID=' .env | cut -d= -f2
```
Wenn leer / nicht gesetzt: Abbruch mit Fehlermeldung an User ("SLACK_USER_ID in .env fehlt — siehe Task 0 im Implementation-Plan").

Verwende das `Agent`-Tool mit `subagent_type: channel-slack`.

Prompt an den Subagenten (minimal — er hat die volle Spec in seiner Definition):

```
Triage Slack inbox.

slack_user_id: {U01XXXXXXXX}
last_run: {last_run_iso8601}
dry: {true|false}

Current Open Items (for smart-close check):
{bulletpoint-list of S-IDs + thread-links from state}

Recently Closed (for re-open detection):
{bulletpoint-list of S-IDs}

Return structured report as specified in your Output Format.
```

### 4. Parse Agent Report

Erwartet: YAML-Codeblock mit `run_timestamp`, `dry`, `candidates`, `smart_close`, `re_open`, `errors`.

Wenn `errors` nicht leer:
- Zeige Fehler dem User
- Stoppe hier — **kein State-Write**.

### 5. Present Candidates Inline

Zeige dem User in dieser exakten Struktur:

```
📥 Slack Triage — {run_timestamp}

Pending Confirmation ({count}):
  [C1] {source} — "{summary}"
       reason: {reason}
       {project: ... if set}
  [C2] ...

Smart-Close Candidates ({count}):
  [S-040] {source} — {reason}

Re-Open Candidates ({count}):
  [S-038] {source} — {reason}

Commands:
  ✓ C1 C2 C3       — confirm as new Open Items
  ✗ C4 C5          — drop these candidates
  close S-040      — confirm Smart-Close
  reopen S-038     — re-promote to Pending
  all ✓            — confirm ALL pending candidates
  all close        — confirm ALL smart-close candidates
  cancel           — don't write anything
```

Wenn `dry: true`:
- Füge Banner oben hinzu: `🧪 DRY-RUN — State wird nicht geändert.`
- Zeige die User-Commands trotzdem, aber kein tatsächlicher Write.
- Springe direkt zu Step 7 (Report Summary) ohne Step 6.

### 6. Apply User Confirmation (nur wenn nicht dry)

Warte auf User-Input. Parse:

- `✓ C1 C3 C5` oder `all ✓` → diese Kandidaten werden zu neuen Open Items
- `✗ C2 C4` oder nicht genannte → verworfen, kein State-Effekt
- `close S-040` oder `all close` → S-040 wird aus Open Items entfernt, in Recently Closed eingefügt
- `reopen S-038` → S-038 aus Recently Closed entfernen, als neues Open Item mit neuer ID anlegen
- `cancel` → kein Write, `last_run` bleibt unverändert

**State-Write-Logik:**

a. **Neue IDs vergeben** für confirmed Candidates:
   - Finde höchste existierende ID in Open Items **und** Recently Closed: `max_id`
   - Neue IDs = `S-(max_id+1)`, `S-(max_id+2)`, ...

b. **Append zu `Open Items`-Tabelle:**
   ```markdown
   | S-043 | 2026-04-24 | DM Henry Krause | Inventar-Tabelle Review | design-assets-rollout | [slack](slack://...) |
   ```

c. **Smart-Close:**
   - Entferne Row aus `Open Items`
   - Append zu `Recently Closed` mit `Closed` = `closed_at` aus Agent-Report und `Resolution` = `replied`:
     ```markdown
     | S-040 | 2026-04-24 16:45 | DM Jens | replied |
     ```

d. **Prune Recently Closed > 7 Tage:**
   - Parse `Closed`-Spalte
   - Entferne Rows älter als `now - 7d`

e. **Update Frontmatter:**
   - `last_run: <run_timestamp>`
   - `updated: <YYYY-MM-DD>`

f. **Verwende das `Edit` tool**, nicht `Write`, um gezielte Änderungen zu machen. Schreib nicht das ganze File neu.

### 7. Report Summary to User

```
✅ Triage complete.
   Added:    {n} new Open Items (S-043, S-044, ...)
   Closed:   {n} items (S-040, S-041)
   Re-opened: {n} items
   Dropped:  {n} candidates
   Pruned:   {n} items from Recently Closed (>7d old)

Current state: {count} total Open Items in Slack.
Run `/draft slack <ID>` to draft a reply.
```

Bei `dry: true`:
```
🧪 DRY-RUN complete. State unchanged.
Would have: Added {n}, Closed {n}, Re-opened {n}, Dropped {n}.
```

## Notes

- Command ruft **kein** `/draft` direkt auf — User entscheidet separat, welchen Items er antworten will.
- Command schreibt **nur** `state/channels/slack.md` — keine Project-File-Writes (orthogonal, siehe Spec).
- Einmal pro Arbeitstag ist ein sinnvoller Default-Rhythmus, aber der User entscheidet.
