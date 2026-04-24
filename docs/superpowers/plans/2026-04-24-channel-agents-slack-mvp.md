# Channel-Agents Slack-MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Einen spezialisierten Slack-Channel-Agenten für MARVIN implementieren, der offene Slack-Items (DMs, @-Mentions) per Triage-Workflow trackt — so dass keine Interaktion mehr durchs Raster fällt.

**Architecture:** Lightweight Claude-Code-Subagent (`channel-slack`) + Slash-Command (`/triage-slack`) + flaches State-File (`state/channels/slack.md`). Subagent klassifiziert heuristisch, Main-MARVIN schreibt nach User-Bestätigung. Orthogonal zu `state/projects/*.md`.

**Tech Stack:** Markdown-basierte Claude-Code-Agent/Command-Definitionen; Slack MCP (vorhandene `mcp__slack__*` oder `mcp__claude_ai_Slack__*` Tools); `.env` für `SLACK_USER_ID`; Bash für Schema-Validierung. Keine separate Laufzeit-Infrastruktur.

**Spec:** [`docs/superpowers/specs/2026-04-24-channel-agents-design.md`](../specs/2026-04-24-channel-agents-design.md)

---

## Task 0: Setup & Prerequisites

**Files:**
- Modify: `.env.example:32` (add `SLACK_USER_ID` placeholder)
- Modify: `.env` (add real `SLACK_USER_ID`, gitignored)

**Context:** Der Subagent braucht Nikolais Slack-User-ID, um zu unterscheiden zwischen "Message von Nikolai" und "Message an Nikolai". Diese ID ist stabil (nicht der Display-Name).

- [ ] **Step 1: Check which Slack MCP is active**

Run: `cat .mcp.json | grep -i slack`
Expected: Zeigt, ob `slack` (project-level) oder `claude_ai_Slack` MCP konfiguriert ist. Das legt fest, welche `mcp__slack_*`-Tools der Subagent nutzt. Dokumentiere das Ergebnis in einer Notiz (z.B. `slack-mcp-notes.md` oder direkt als Kommentar).

- [ ] **Step 2: Identify Nikolai's Slack User ID via MCP**

Frage die Session, den aktiven Slack-MCP zu nutzen:
```
"Find my Slack user ID (Nikolai Bockholt at GoMedicus/Börnsen)"
```
Main-MARVIN ruft `mcp__slack__slack_get_users` (oder `mcp__claude_ai_Slack__slack_search_users` mit Query "Nikolai") und liefert die `U...`-ID zurück.
Expected: Slack-User-ID im Format `U01XXXXXXXX`.

- [ ] **Step 3: Add `SLACK_USER_ID` to `.env.example`**

Edit `.env.example`, unter dem bestehenden `SLACK_BOT_TOKEN=` Eintrag hinzufügen:

```bash
# Slack
SLACK_BOT_TOKEN=
SLACK_USER_ID=  # Your Slack user ID (U01XXXXXXXX), needed by channel-slack agent
```

- [ ] **Step 4: Add real value to `.env`**

Edit `.env` (if it exists) oder `cp .env.example .env` wenn noch nicht vorhanden. Set:

```bash
SLACK_USER_ID=U01XXXXXXXX  # die echte ID aus Step 2
```

- [ ] **Step 5: Verify `.env` is gitignored**

Run: `grep -E '^\.env$' .gitignore`
Expected: `.env` ist in `.gitignore`. Wenn nicht, bricht hier ab — sicherer Umgang mit Tokens ist Pflicht.

- [ ] **Step 6: Commit**

```bash
git add .env.example
git commit -m "chore: add SLACK_USER_ID placeholder for channel-slack agent"
```

---

## Task 1: Create State Bootstrap Template

**Files:**
- Create: `state/channels/slack.md`

**Context:** Leerer State-File als initialer Zustand, mit korrektem Frontmatter + allen Sektionen. Das ist zugleich die erste sichtbare Artefakt-Manifestation der neuen Channel-State-Layer.

- [ ] **Step 1: Create the directory and file**

Run: `mkdir -p state/channels`

Create `state/channels/slack.md` with exact content:

```markdown
---
channel: slack
last_run: null
updated: 2026-04-24
---

# Slack Channel State

> **Orthogonal zu `state/projects/*.md`.** Dieses File trackt nur eingehende Slack-Items, die Aktion von Nikolai verlangen. Längsseitige Projekt-Arcs bleiben in `state/projects/`.

## Open Items

_Bestätigte offene Items (warten auf Nikolais Aktion). Leer beim Bootstrap._

| ID | Since | Source | Summary | Project | Link |
|----|-------|--------|---------|---------|------|

## Pending Confirmation

_Wird bei jedem `/triage-slack` neu gefüllt mit Kandidaten. Nach Bestätigung geleert._

## Recently Closed

_Letzte 7 Tage. Wird automatisch gepruned._

| ID | Closed | Source | Resolution |
|----|--------|--------|------------|
```

- [ ] **Step 2: Verify file structure with a schema-check script**

Run this bash check manually:

```bash
FILE=state/channels/slack.md
# Check frontmatter keys
grep -q '^channel: slack$' $FILE && \
grep -q '^last_run:' $FILE && \
grep -q '^updated:' $FILE && \
# Check required sections
grep -q '^## Open Items$' $FILE && \
grep -q '^## Pending Confirmation$' $FILE && \
grep -q '^## Recently Closed$' $FILE && \
echo "OK: slack.md schema valid" || echo "FAIL: slack.md schema invalid"
```

Expected: `OK: slack.md schema valid`

- [ ] **Step 3: Commit**

```bash
git add state/channels/slack.md
git commit -m "feat: add state/channels/slack.md bootstrap template"
```

---

## Task 2: Create the `channel-slack` Subagent Definition

**Files:**
- Create: `.claude/agents/channel-slack.md`

**Context:** Der Subagent selbst ist eine Markdown-Datei mit Frontmatter (`name`, `description`, `model`) und einer System-Prompt-artigen Körpersektion, die sein Verhalten festlegt. Basiert auf dem `.claude/agents/_template.md` Muster.

- [ ] **Step 1: Create the agent definition**

Create `.claude/agents/channel-slack.md` with exact content:

````markdown
---
name: channel-slack
description: Triage incoming Slack DMs + mentions; classify action-needed items; detect smart-close candidates
model: sonnet
---

# Channel-Slack Agent

## Purpose

Triagiert den Slack-Inbox für Nikolai: identifiziert Nachrichten, die seine Aktion verlangen (DMs, @-Mentions, offene Threads), und erkennt offene Items, die er inzwischen geschlossen hat (Smart-Close). Schreibt selbst **nicht** in State — der Haupt-Agent übernimmt Writes nach Bestätigung.

## When to Spawn

Main-MARVIN spawned diesen Agenten:
- `/triage-slack` (primärer Entry-Point)
- Später optional: als Teil eines `/start triage`-Modus

## Inputs (über den Prompt)

Main-MARVIN übergibt im Prompt:
- `slack_user_id` — Nikolai's Slack-User-ID (aus `.env` von Main gelesen)
- `last_run` Timestamp aus `state/channels/slack.md`
- Liste der aktuellen Open Items (für Smart-Close)
- Liste der Recently-Closed IDs (für Re-Open-Detection)
- Optional: `dry: true` Flag (kein State-Effekt, nur Klassifikation zeigen)

Der Agent liest selbst:
- `state/channels/slack.md` als Kontext-Bestätigung, falls Details im Prompt fehlen

## Capabilities / Tools

**Lesend:**
- `mcp__slack__slack_get_channel_history` bzw. `mcp__claude_ai_Slack__slack_read_channel` (für DMs)
- `mcp__slack__slack_get_thread_replies` bzw. `mcp__claude_ai_Slack__slack_read_thread` (für Thread-State)
- `mcp__slack__slack_list_channels` (für Channel-Kontext)
- `mcp__slack__slack_get_user_profile` (für Absender-Attribution)
- `Read` (für State-File)

**Nicht erlaubt:** Schreiben in State, Senden von Nachrichten, Reactions setzen.

## Workflow

1. **Parse Prompt**: Extrahiere `last_run` und Flags.
2. **Load Config**: Lies `SLACK_USER_ID` aus `.env` (oder via Tool wenn verfügbar).
3. **Fetch Inbox-Events seit `last_run`**:
   - Alle DM-Channels des Users → `slack_get_channel_history(oldest=last_run)`
   - Channels mit @-Mentions → via `slack_search` oder Channel-History mit Filter auf `<@SLACK_USER_ID>`
4. **Klassifiziere neue Events als Kandidaten:**

   **Flag als Action-Needed wenn:**
   - DM an Nikolai UND letzter Beitrag von anderem User → ✓
   - @-Mention Nikolai in Channel UND Nachricht enthält `?` oder klare Anfrage → ✓
   - Thread-Participant Nikolai, letzter Beitrag von anderem, Message-Alter ≥ 1h → ✓

   **Auto-Filter (niemals Kandidat):**
   - Bot-Messages (`subtype: bot_message` oder bekannte Bot-IDs)
   - System-Messages (`subtype: channel_join`, etc.)
   - Newsletter-/Broadcast-Channels (hartcodierte Liste, iterativ erweitern)
   - Reaction-only Events
   - `@here` / `@channel` — nur direkte `@<SLACK_USER_ID>` zählen
   - Nikolai-authored Messages (`user == SLACK_USER_ID`)

5. **Prüfe offene Items aus `Open Items`-Tabelle auf Smart-Close:**
   - Für jedes Item: fetcht den Thread oder DM-History
   - Wenn **Nikolai** nach der Item-Erstellung eine Message im Thread gesendet hat → Smart-Close-Kandidat
   - Re-Open: wenn ein Item in `Recently Closed` steht UND neuer Event (Reply/Mention) dazukommt → als neuen Kandidat aufnehmen

6. **Match optional Projekte:** Scanne `state/projects/*.md` Dateinamen + bekannte Keywords (Kronprinzenbau, Lütjensee, etc.) gegen Channel-Name oder Nachrichtentext. Setze `project`-Feld wenn Match.

7. **Return strukturierten Report** an Main (siehe Output Format).

## Output Format

Return **genau** dieses JSON-artige Struktur als Markdown-Codeblock (damit Main-MARVIN parsen kann):

```yaml
run_timestamp: 2026-04-24T17:30:00+02:00
dry: false
candidates:
  - tmp_id: C1
    source: "DM Henry Krause"
    channel_id: D0801K7MZ9P
    ts: "1714234567.001200"  # Slack-Message-Timestamp
    summary: "Kannst du morgen die Inventar-Tabelle reviewen?"
    reason: "Direkte Anfrage an dich in DM"
    project: design-assets-rollout  # oder null
    link: "slack://channel?team=T0XXX&id=D0801K7MZ9P&message=1714234567001200"
  - tmp_id: C2
    ...
smart_close:
  - id: S-040
    reason: "Du hast am 2026-04-24 16:45 in diesem Thread geantwortet"
    closed_at: 2026-04-24T16:45:00+02:00
re_open:
  - id: S-038  # war in Recently Closed, jetzt wieder Aktivität
    reason: "Neue Nachricht von Henry am 2026-04-24 17:00"
errors: []  # z.B. ["rate_limited: retry_after=30"] wenn was schiefging
```

Wenn keine Kandidaten: leere Arrays, keine Ausnahme.

## Error Handling

- **MCP unavailable / auth fail:** Return `errors: ["mcp_unavailable: <detail>"]`, leere `candidates` und `smart_close`. Main zeigt Fehler, schreibt nix.
- **Rate Limit:** Return `errors: ["rate_limited: retry_after=<sec>"]`. Main wartet und informiert User.
- **Malformed state file:** Return `errors: ["state_invalid: <detail>"]`. Main re-bootstrappt Template.

## Rules

- **Conservativ.** Lieber einen Kandidaten zu wenig vorschlagen als Rauschen zu produzieren.
- **Reason-Feld ist Pflicht.** User muss immer nachvollziehen können, warum ein Item vorgeschlagen wurde.
- **Keine Writes.** Nicht in `state/channels/slack.md` schreiben. Main-MARVIN macht das.
- **Keine Sends.** Niemals Nachrichten an Slack senden oder Reactions setzen.
- **Dry-Run:** Wenn `--dry` im Prompt, exakt gleiches Verhalten nur mit `dry: true` im Output.

## Notes

- Erste Woche ist Kalibrierungsphase: Heuristik-Tuning durch Nikolai-Feedback.
- MVP-Fokus: DMs + direkte @-Mentions. Thread-Replies in Non-DM-Channels sind Phase 2.
- Newsletter-Blacklist erweitert sich iterativ basierend auf Nikolais Rauschen-Feedback.
````

- [ ] **Step 2: Verify frontmatter + sections**

Run:
```bash
FILE=.claude/agents/channel-slack.md
grep -q '^name: channel-slack$' $FILE && \
grep -q '^description:' $FILE && \
grep -q '^model: sonnet$' $FILE && \
grep -q '^## Purpose$' $FILE && \
grep -q '^## Workflow$' $FILE && \
grep -q '^## Output Format$' $FILE && \
echo "OK: channel-slack agent schema valid" || echo "FAIL"
```

Expected: `OK: channel-slack agent schema valid`

- [ ] **Step 3: Commit**

```bash
git add .claude/agents/channel-slack.md
git commit -m "feat: add channel-slack subagent for Slack inbox triage"
```

---

## Task 3: Create the `/triage-slack` Slash Command

**Files:**
- Create: `.claude/commands/triage-slack.md`

**Context:** Der Command ist die User-Facing Entry-Point. Er lädt den State, spawned den Subagenten, präsentiert das Ergebnis, nimmt User-Confirmation entgegen und schreibt State. Analog zu `.claude/commands/start.md`, `.claude/commands/end.md`.

- [ ] **Step 1: Create the command definition**

Create `.claude/commands/triage-slack.md` with exact content:

````markdown
# /triage-slack - Triage Slack Inbox

Triagiere offene Slack-Items: identifiziere neue Nachrichten, die deine Aktion verlangen, und erkenne Smart-Close-Kandidaten für bereits offene Items.

## Usage

- `/triage-slack` — Normaler Lauf: fetch + klassifiziere + schreibe nach Bestätigung
- `/triage-slack --dry` — Dry-Run: nur zeigen, kein State-Write

## Instructions

### 1. Check State File Exists

Read `state/channels/slack.md`.

Wenn das File fehlt:
- Bootstrap aus Template (siehe Task 1 dieses Plans).
- Sei explizit: "State-File neu angelegt. Erster Run fetcht letzte 7 Tage."
- Setze `last_run = now - 7d` für den initialen Fetch.

### 2. Parse State

Extrahiere aus Frontmatter:
- `last_run` — Timestamp des letzten Runs, oder `null` (dann `now - 7d` als Default).

Parse Tabellen:
- `Open Items` — Liste bestehender offener Items (ID, Since, Source, Summary, Project, Link).
- `Recently Closed` — Liste, um Re-Open-Detection zu ermöglichen.

### 3. Spawn Subagent

Verwende das `Agent`-Tool mit `subagent_type: channel-slack`.

Vor dem Spawn: Main liest `SLACK_USER_ID` aus `.env`:
```bash
grep '^SLACK_USER_ID=' .env | cut -d= -f2
```
Wenn leer / nicht gesetzt: Abbruch mit Fehlermeldung an User ("SLACK_USER_ID in .env fehlt — siehe Task 0 im Implementation-Plan").

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
````

- [ ] **Step 2: Verify the command structure**

Run:
```bash
FILE=.claude/commands/triage-slack.md
grep -q '^# /triage-slack' $FILE && \
grep -q '^## Usage$' $FILE && \
grep -q '^## Instructions$' $FILE && \
grep -q '### 1\. Check State File Exists' $FILE && \
grep -q '### 6\. Apply User Confirmation' $FILE && \
echo "OK: triage-slack command schema valid" || echo "FAIL"
```

Expected: `OK: triage-slack command schema valid`

- [ ] **Step 3: Commit**

```bash
git add .claude/commands/triage-slack.md
git commit -m "feat: add /triage-slack command orchestrating channel-slack agent"
```

---

## Task 4: First End-to-End Dry-Run Test

**Files:**
- No changes; manual test documented

**Context:** Erste echte Invokation. Weil wir kein automatisiertes Testing haben, dokumentieren wir hier exakt, was als Test passiert und was als Erfolg gilt. Nikolai führt das manuell aus und kalibriert Output.

- [ ] **Step 1: Ensure state file is in bootstrap state**

Run: `cat state/channels/slack.md | head -6`
Expected: Frontmatter zeigt `last_run: null` — sonst manuell auf `null` zurücksetzen (falls bereits Läufe stattfanden).

- [ ] **Step 2: Run in dry mode**

In einer MARVIN-Session: `/triage-slack --dry`

Expected output format:
```
🧪 DRY-RUN — State wird nicht geändert.

📥 Slack Triage — 2026-04-24T17:30:00+02:00

Pending Confirmation (N):
  [C1] ...
  ...

Smart-Close Candidates (0):  # leer, weil keine Open Items existieren
Re-Open Candidates (0):      # leer

Commands:
  ✓ C1 C2 C3 ...
  ...

🧪 DRY-RUN complete. State unchanged.
Would have: Added N, Closed 0, Re-opened 0, Dropped 0.
```

Wenn stattdessen:
- Fehler: Prüfe MCP-Connection (`/status`), prüfe `SLACK_USER_ID` in `.env`, prüfe Slack-Bot-Permissions.
- Kein Output / hängt: Siehe Step 4.

- [ ] **Step 3: Verify state file unchanged**

Run: `git status state/channels/slack.md`
Expected: `nothing to commit` — File wurde nicht modifiziert durch Dry-Run.

- [ ] **Step 4: Calibration notes**

Dokumentiere in `state/projects/marvin-infrastructure.md` unter einer neuen `### Channel-Agents Slack MVP` Sektion:
- Anzahl vorgeschlagener Kandidaten
- Wie viele davon sind false positives (Nikolai schätzt subjektiv)
- Welche Heuristik-Regel versagt am häufigsten

Dieser Block wird in Task 6 wieder aufgenommen (Heuristik-Tuning).

- [ ] **Step 5: Commit calibration notes (nur wenn Edits gemacht)**

```bash
git add state/projects/marvin-infrastructure.md
git commit -m "docs: add channel-slack calibration notes from first dry-run"
```

---

## Task 5: First Real Run (Write State)

**Files:**
- Modify: `state/channels/slack.md` (via /triage-slack, not manually)

**Context:** Jetzt mit echtem Write. Nach diesem Schritt sollten im State-File reale Open Items stehen, und `last_run` auf jetzt gesetzt sein.

- [ ] **Step 1: Run triage live**

In einer MARVIN-Session: `/triage-slack`

Output sollte identisch zu Dry-Run-Step 2 sein (ohne Banner).

- [ ] **Step 2: Confirm a sensible subset**

Beispiel: `✓ C1 C3, ✗ C2 C4 C5, cancel` wenn keine guten Kandidaten dabei sind.

Expected:
```
✅ Triage complete.
   Added:    2 new Open Items (S-001, S-002)
   Closed:   0 items
   Re-opened: 0 items
   Dropped:  3 candidates
   Pruned:   0 items from Recently Closed (>7d old)

Current state: 2 total Open Items in Slack.
Run `/draft slack <ID>` to draft a reply.
```

- [ ] **Step 3: Verify state file**

Run: `cat state/channels/slack.md`

Check manuell:
- Frontmatter `last_run` ist gesetzt auf aktuellen Timestamp
- `Open Items`-Tabelle hat die bestätigten Items mit IDs S-001, S-002
- `Pending Confirmation` ist leer
- `Recently Closed` unverändert (leer bei Bootstrap)

Run: Schema-Check aus Task 1, Step 2 (Einzeiler).
Expected: `OK: slack.md schema valid`

- [ ] **Step 4: Commit state**

```bash
git add state/channels/slack.md
git commit -m "state: initial slack triage run — N open items tracked"
```

---

## Task 6: Smart-Close & Re-Open Round-Trip Test

**Files:**
- Modify: `state/channels/slack.md` (via /triage-slack)

**Context:** Verifiziere dass der Lifecycle (Open → Closed → optional Re-Open) funktioniert. Dafür brauchen wir ein Item, bei dem Nikolai nach dem initialen Triage-Run tatsächlich antwortet.

- [ ] **Step 1: Pick one Open Item and reply in Slack UI**

Wähle ein `S-00X` aus `state/channels/slack.md` aus. Gehe in Slack, öffne den Thread / DM, antworte tatsächlich. (Das ist keine Automation — echte User-Aktion.)

- [ ] **Step 2: Run triage again**

`/triage-slack`

Expected:
```
Smart-Close Candidates (1):
  [S-00X] DM/Channel — Du hast am <ts> in diesem Thread geantwortet

Commands: ...
```

- [ ] **Step 3: Confirm smart-close**

`close S-00X`

Expected:
```
✅ Triage complete.
   Added:    0
   Closed:   1 items (S-00X)
   ...
```

- [ ] **Step 4: Verify state**

Run: `grep 'S-00X' state/channels/slack.md`
Expected: S-00X steht unter `## Recently Closed`, **nicht** mehr unter `## Open Items`.

- [ ] **Step 5 (optional): Re-Open-Test**

Wenn jemand in Slack erneut auf S-00X antwortet, sollte der nächste `/triage-slack` S-00X als Re-Open-Kandidat zeigen.

- [ ] **Step 6: Commit state**

```bash
git add state/channels/slack.md
git commit -m "state: first smart-close round-trip verified"
```

---

## Task 7: Heuristic Calibration Round 1

**Files:**
- Modify: `.claude/agents/channel-slack.md` (refine heuristic rules)
- Modify: `state/projects/marvin-infrastructure.md` (log calibration)

**Context:** Nach ~1 Woche Nutzung (oder ~5 Triage-Runs) zeigt sich, wo die Heuristik zu viele false positives produziert oder echte Items misst. Einmal bewusst justieren, dokumentieren, committen.

- [ ] **Step 1: Review past runs**

Sammle subjektive Einschätzung über mehrere Runs:
- Welche false positives waren häufig? (z.B. Bot-Messages eines bestimmten Integrations-Bots, nicht-filtered)
- Welche echten Items fehlten? (z.B. Thread-Replies ohne @-Mention, aber an Nikolai adressiert)

- [ ] **Step 2: Adjust heuristic in agent file**

Edit `.claude/agents/channel-slack.md`:

Falls z.B. ein neuer Bot (`@GitHubBot`) häufig Rauschen produziert, unter "Auto-Filter" ergänzen:
```markdown
   - Messages von bekannten Integrations-Bots: `@GitHubBot`, `@PagerDuty`, ...
```

Falls z.B. Thread-Replies ohne Mention gemisst werden, unter Flag-Regel präzisieren oder erweitern.

- [ ] **Step 3: Log calibration**

Edit `state/projects/marvin-infrastructure.md`, füge unter `### Channel-Agents Slack MVP` eine Zeitstempel-Notiz:
```markdown
- 2026-05-XX — Kalibrierung Round 1: {was geändert}. Begründung: {N false positives über M Runs}.
```

- [ ] **Step 4: Run triage again to verify**

`/triage-slack --dry`

Prüfe, ob das vorher problematische Pattern jetzt sauber ist.

- [ ] **Step 5: Commit**

```bash
git add .claude/agents/channel-slack.md state/projects/marvin-infrastructure.md
git commit -m "refine: channel-slack heuristic calibration round 1"
```

---

## Task 8: Update CLAUDE.md Documentation

**Files:**
- Modify: `CLAUDE.md` — neue Sektion für Channel-State + Agent-Dokumentation

**Context:** Wenn ein neues Team-Member (oder Future-Claude) MARVIN öffnet, muss die Channel-Architektur aus CLAUDE.md ersichtlich sein. Sie ergänzt die existierende State-Architektur-Sektion.

- [ ] **Step 1: Locate existing "State (modular, seit 2026-04-21)" section**

Run: `grep -n 'State (modular' CLAUDE.md`
Expected: Zeigt Zeilennummer, z.B. `L94`.

- [ ] **Step 2: Edit the state-architecture block**

Edit `CLAUDE.md`, update das state/-Tree-Diagramm unter "### State (modular, ...)" so:

Old (relevanter Ausschnitt):
```
state/
├── current.md            Schlanker Index: ...
├── goals.md              ...
├── archive.md            ...
├── projects/
│   ├── ...
└── sessions/             Session-Logs (eine Datei pro Tag)
```

New:
```
state/
├── current.md            Schlanker Index: ...
├── goals.md              ...
├── archive.md            ...
├── projects/             Längsseitige Projekt-Arcs (SSoT für Projekte)
│   ├── ...
├── channels/             Kanalzentrierte Inbound-Queues (SSoT für "someone waiting on me")
│   ├── slack.md          Slack DMs + @-Mentions, getracked via /triage-slack
│   └── ...               Gmail, Notion, Calendar, Drive (spätere Phasen)
└── sessions/             Session-Logs (eine Datei pro Tag)
```

Ergänze unter "Regeln:" eine neue Zeile:
```markdown
- `state/channels/*.md` ist **orthogonal** zu `state/projects/*.md`: Kanäle tracken Inbound-Queue ("someone waiting on me"), Projekte tracken längsseitigen Arc. Cross-Links optional, keine Auto-Writes zwischen den Layern.
```

- [ ] **Step 3: Add agent to the "Agents" section**

Edit `CLAUDE.md`, unter "### Agents (`.claude/agents/`)" Tabelle ergänzen:

```markdown
- **channel-slack** — triagiert Slack-Inbox, klassifiziert Action-Needed-Items. Spawned von `/triage-slack`. Model: sonnet.
```

- [ ] **Step 4: Add command to the Commands section**

Edit `CLAUDE.md`, in der "Slash Commands (inside MARVIN)" Tabelle ergänzen:

```markdown
| `/triage-slack` | Triage Slack inbox: offene Items klassifizieren, Smart-Close erkennen |
```

- [ ] **Step 5: Verify edits**

Run: `grep -c 'channel-slack' CLAUDE.md`
Expected: Mindestens `2` (ein Mal in state/-Tree, ein Mal in Agents-Sektion, vielleicht mehr).

Run: `grep '/triage-slack' CLAUDE.md`
Expected: Mindestens zwei Matches (Commands-Table + State-Tree-Kommentar).

- [ ] **Step 6: Commit**

```bash
git add CLAUDE.md
git commit -m "docs: document channel-agents architecture + /triage-slack command"
```

---

## Task 9: Final Integration Smoke Test

**Files:**
- No changes; manual verification

**Context:** Schluss-Check: Alle Bausteine existieren, schema-valide, und ein kompletter Runde läuft durch.

- [ ] **Step 1: Verify all artifacts exist**

Run:
```bash
test -f state/channels/slack.md && \
test -f .claude/agents/channel-slack.md && \
test -f .claude/commands/triage-slack.md && \
grep -q 'SLACK_USER_ID' .env.example && \
grep -q 'channel-slack' CLAUDE.md && \
echo "OK: all artifacts in place" || echo "FAIL: missing artifact"
```

Expected: `OK: all artifacts in place`

- [ ] **Step 2: Verify schema validity of state file**

Schema-Check aus Task 1, Step 2:
```bash
FILE=state/channels/slack.md
grep -q '^channel: slack$' $FILE && \
grep -q '^last_run:' $FILE && \
grep -q '^## Open Items$' $FILE && \
grep -q '^## Pending Confirmation$' $FILE && \
grep -q '^## Recently Closed$' $FILE && \
echo "OK: slack.md valid" || echo "FAIL"
```

Expected: `OK: slack.md valid`

- [ ] **Step 3: Verify agent frontmatter**

```bash
FILE=.claude/agents/channel-slack.md
grep -q '^name: channel-slack$' $FILE && \
grep -q '^description:' $FILE && \
grep -q '^model: sonnet$' $FILE && \
echo "OK: agent valid" || echo "FAIL"
```

Expected: `OK: agent valid`

- [ ] **Step 4: Run one final live triage**

`/triage-slack` — sollte sauber durchlaufen ohne neue Fehler.

- [ ] **Step 5: Push**

```bash
git push
```

Expected: Alle Commits landen im `NikolaiGoMedicus/marvin-chiefofstaff` Remote.

---

## Post-Implementation: Was als nächstes?

Nach Abschluss dieses Plans ist der Slack-MVP live. Natürliche Follow-ups (NICHT Teil dieses Plans):

1. **Gmail-Phase-2 Spec + Plan** — eigene Spec schreiben, wenn Slack-MVP ~2 Wochen kalibriert ist.
2. **Optional `/start triage`-Integration** — wenn Nikolai signalisiert, dass er den Triage-Flow gerne automatisch morgens will.
3. **Weitere Kanäle** — Notion (niedrig-hängendes Obst), Calendar, Drive.
4. **`/inbox-all` Aggregator** — wenn ≥2 Channel-Agents existieren.

Diese bekommen eigene Specs + Pläne, wenn sie an der Reihe sind.
