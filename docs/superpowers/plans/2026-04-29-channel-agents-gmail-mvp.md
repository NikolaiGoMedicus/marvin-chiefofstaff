# Channel-Agents Gmail-MVP Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Einen spezialisierten Gmail-Channel-Agenten für MARVIN implementieren (Phase 2 nach Slack-MVP), der Email-Threads im Gmail-Primary-Tab trackt, in denen jemand auf Nikolais Antwort wartet.

**Architecture:** Mirror der Slack-MVP-Architektur: Subagent (`channel-gmail`, Sonnet, read-only) + Slash-Command (`/triage-gmail`) + flat State-File (`state/channels/gmail.md`). Subagent klassifiziert via Reply-State-Heuristik, Main-MARVIN schreibt nach User-Confirmation. Inbound-only MVP — `/draft`-Refactor ist Phase 2.5.

**Tech Stack:** Markdown-basierte Claude-Code-Agent/Command-Definitionen; Google Workspace MCP (`mcp__google-workspace__search_gmail_messages`, `get_gmail_thread_content` etc.); `.env` für `GOOGLE_USER_EMAIL`; Bash für Schema-Validierung. Keine separate Laufzeit-Infrastruktur.

**Spec:** [`docs/superpowers/specs/2026-04-28-channel-agents-gmail-phase2-design.md`](../specs/2026-04-28-channel-agents-gmail-phase2-design.md)

---

## Task 0: Setup & Prerequisites

**Files:**
- Modify: `.env.example` (add `GOOGLE_USER_EMAIL` placeholder if missing)
- Modify: `.env` (add real `GOOGLE_USER_EMAIL`, gitignored)

**Context:** Der Subagent braucht Nikolais Email-Adresse, um zu unterscheiden zwischen "Message von Nikolai" und "Message an Nikolai". Diese ist stabil. Möglicherweise existiert die Variable schon in `.env` für andere Google-Workspace-Tools.

- [ ] **Step 1: Check ob `GOOGLE_USER_EMAIL` schon in `.env` existiert**

Run:
```bash
grep -E '^GOOGLE_USER_EMAIL=' /Users/nikolaibockholt/marvin/.env || echo "NOT_FOUND"
```
Expected: Entweder `GOOGLE_USER_EMAIL=nikolai@gomedicusgroup.com` (dann zu Step 4 springen) oder `NOT_FOUND` (dann mit Step 2 weitermachen).

- [ ] **Step 2: Add `GOOGLE_USER_EMAIL` to `.env.example`**

Edit `.env.example`. Suche eine sinnvolle Stelle (Google-Workspace-Sektion oder generischer Block). Füge ein:

```bash
# Google Workspace
GOOGLE_USER_EMAIL=  # Your primary Gmail address (e.g. you@example.com), needed by channel-gmail agent
```

Falls bereits eine Google-Sektion existiert, dort einsortieren.

- [ ] **Step 3: Add real value to `.env`**

Edit `.env`. Setze:

```bash
GOOGLE_USER_EMAIL=nikolai@gomedicusgroup.com
```

- [ ] **Step 4: Verify `.env` is gitignored**

Run: `grep -E '^\.env$' /Users/nikolaibockholt/marvin/.gitignore`
Expected: Match (`.env`). Wenn keine Match: STOP, prüfe `.gitignore` — sicherer Umgang mit Tokens ist Pflicht.

- [ ] **Step 5: Commit `.env.example` (nur falls in Step 2 modifiziert)**

```bash
cd /Users/nikolaibockholt/marvin
git add .env.example
git commit -m "chore: add GOOGLE_USER_EMAIL placeholder for channel-gmail agent"
```

Wenn `.env.example` nicht modifiziert wurde (Variable existierte schon): `echo "skip — variable existed already"`.

---

## Task 1: Create State Bootstrap Template

**Files:**
- Create: `state/channels/gmail.md`

**Context:** Leerer State-File als initialer Zustand. Frontmatter + alle Sektionen + erweiterte Spalten (`Direction`, `Status`, `Draft-ID`) gegenüber Slack.

- [ ] **Step 1: Create the file**

Create `state/channels/gmail.md` with exact content:

```markdown
---
channel: gmail
last_run: null
updated: 2026-04-29
---

# Gmail Channel State

> **Orthogonal zu `state/projects/*.md`.** Dieses File trackt nur Email-Threads, die auf Nikolais Antwort warten. Längsseitige Projekt-Arcs leben in `state/projects/`.

## Open Items

_Bestätigte offene Items (warten auf Aktion). Leer beim Bootstrap._

| ID | Since | Direction | Counterpart | Subject | Status | Draft-ID | Project | Thread |
|----|-------|-----------|-------------|---------|--------|----------|---------|--------|

## Pending Confirmation

_Wird bei jedem `/triage-gmail` neu gefüllt mit Kandidaten. Nach Bestätigung geleert._

## Recently Closed

_Letzte 7 Tage. Wird automatisch gepruned._

| ID | Closed | Counterpart | Subject | Resolution |
|----|--------|-------------|---------|------------|
```

- [ ] **Step 2: Verify file structure with a schema-check**

Run:
```bash
FILE=/Users/nikolaibockholt/marvin/state/channels/gmail.md
grep -q '^channel: gmail$' $FILE && \
grep -q '^last_run:' $FILE && \
grep -q '^updated:' $FILE && \
grep -q '^## Open Items$' $FILE && \
grep -q '^## Pending Confirmation$' $FILE && \
grep -q '^## Recently Closed$' $FILE && \
echo "OK: gmail.md schema valid" || echo "FAIL: gmail.md schema invalid"
```

Expected: `OK: gmail.md schema valid`

- [ ] **Step 3: Commit**

```bash
cd /Users/nikolaibockholt/marvin
git add state/channels/gmail.md
git commit -m "feat: add state/channels/gmail.md bootstrap template"
```

---

## Task 2: Create the `channel-gmail` Subagent Definition

**Files:**
- Create: `.claude/agents/channel-gmail.md`

**Context:** Markdown-basierter Subagent mit Frontmatter (`name`, `description`, `model`) und vollständiger System-Prompt-Spezifikation. Analog zu `.claude/agents/channel-slack.md`.

- [ ] **Step 1: Create the agent definition**

Create `.claude/agents/channel-gmail.md` with exact content:

````markdown
---
name: channel-gmail
description: Triagiert Gmail Primary-Tab; klassifiziert Threads die auf Nikolais Antwort warten; erkennt Smart-Close-Kandidaten (Reply ODER Archive)
model: sonnet
---

# Channel-Gmail Agent

## Purpose

Triagiert Nikolais Gmail-Inbox (Primary-Tab) für Email-Threads, die seine Aktion verlangen, und erkennt offene Items, die er inzwischen geschlossen hat (Smart-Close via Reply oder Archive). Schreibt selbst **nicht** in State — der Haupt-Agent übernimmt Writes nach Bestätigung.

## When to Spawn

Main-MARVIN spawned diesen Agenten:
- `/triage-gmail` (primärer Entry-Point)

## Inputs (über den Prompt)

Main-MARVIN übergibt im Prompt:
- `gmail_user_email` — Nikolai's Email-Adresse (aus `.env` von Main gelesen)
- `last_run` Timestamp aus `state/channels/gmail.md` (oder `null` für Bootstrap → 14d-Window)
- Liste der aktuellen Open Items (für Smart-Close)
- Liste der Recently-Closed-IDs (für Re-Open-Detection)
- Optional: `dry: true` Flag (kein State-Effekt, nur Klassifikation zeigen)

Der Agent liest selbst:
- `state/channels/gmail.md` als Kontext-Bestätigung, falls Details im Prompt fehlen

## Capabilities / Tools

**Lesend:**
- `mcp__google-workspace__search_gmail_messages` (für Inbox-Search mit Gmail-Query-Syntax)
- `mcp__google-workspace__get_gmail_thread_content` (für Thread-State-Check)
- `mcp__google-workspace__get_gmail_messages_content_batch` (für Batch-Header-Inspection)
- `mcp__google-workspace__list_gmail_labels` (für INBOX-Label-Check beim Smart-Close-archived)
- `Read` (für State-File)

**Nicht erlaubt:** Schreiben in State, Senden von Nachrichten, Label-Manipulation, Archivieren.

## Workflow

1. **Parse Prompt**: Extrahiere `gmail_user_email`, `last_run`, Open-Items-Liste, Recently-Closed-Liste, und Flags.

2. **Build Gmail-Search-Query:**
   - Bootstrap (last_run=null): `category:primary newer_than:14d to:me -from:me`
   - Subsequent: `category:primary after:{last_run_unix_ts} to:me -from:me`

3. **Fetch Inbox-Events:**
   - `search_gmail_messages` mit obiger Query
   - Pro Match: extrahiere Thread-ID
   - Dedupliziere Thread-IDs (mehrere Messages pro Thread → ein Kandidat)

4. **Per Thread klassifizieren als Kandidat:**

   **Flag als Action-Needed wenn:**
   - Thread-letzte Message NICHT vom User (`from: gmail_user_email`)
   - User ist im `To:`-Feld der letzten Message (nicht nur CC/BCC)
   - User hat seit der letzten Message NICHT geantwortet

   **Auto-Filter (niemals Kandidat):**
   - Sender-Pattern matched: `noreply@`, `no-reply@`, `notifications@`, `mailer-daemon@`, `donotreply@`, `bounces@`, `auto@`
   - Header `List-Unsubscribe` vorhanden → Newsletter
   - Header `Auto-Submitted` ≠ `no` → Auto-Reply / OOO
   - Header `Precedence: bulk` oder `Precedence: list` → Newsletter
   - Sender-Domain in Notification-Blacklist:
     - `linear.app`
     - `github.com`
     - `notion.so`
     - `calendly.com`
     - `loom.com`
     - `slack.com`
     - `figma.com`
     - `vercel.com`
     - `medium.com`
     - `substack.com`
   - Eigene Messages (`from: gmail_user_email`)

5. **Smart-Close für existierende Open Items prüfen:**

   **Reihenfolge wichtig — `replied` vor `archived` prüfen:**

   - **`replied`-Check (Status egal):**
     - Hole Thread via `get_gmail_thread_content`
     - Existiert eine Message mit `from: gmail_user_email` UND Datum > Item's `Since`? → Smart-Close `replied`, `closed_at` = Datum dieser Sent-Message
   - **`archived`-Check (Status egal):**
     - Falls KEIN `replied`-Match: prüfe Thread-Labels
     - INBOX-Label NICHT in Thread-Labels-Liste? → Smart-Close `archived`, `closed_at` = aktueller Run-Timestamp

6. **Re-Open-Check:**
   - Für jedes Item in Recently-Closed-Liste: hole Thread
   - Existiert eine Inbound-Message NACH `closed_at`? → Re-Open-Kandidat

7. **Match optional Projekte:**
   - Scanne Subject + Sender-Domain gegen `state/projects/*.md` Slug-Liste + bekannte Keywords (Kronprinzenbau, Lütjensee, Antonia, Antragswesen, etc.)
   - Setze `project`-Feld wenn klarer Match

8. **Return strukturierten Report** an Main (siehe Output Format).

## Output Format

Return **genau** dieses YAML als Markdown-Codeblock (damit Main-MARVIN parsen kann):

```yaml
run_timestamp: 2026-04-29T10:00:00+02:00
dry: false
candidates:
  - tmp_id: C1
    direction: in
    counterpart: "Antonia Gebhardt <antonia@gomedicusgroup.com>"
    subject: "Re: T2 Form — Zeitplan"
    thread_id: "19db5d9a635fe787"
    summary: "Antonia fragt nach Stand zum T2-Form Rollout"
    reason: "Letzte Message von Antonia 28.04. 14:32, du hast nicht geantwortet"
    project: ai-services-rollout
    link: "https://mail.google.com/mail/u/0/#inbox/19db5d9a635fe787"
smart_close:
  - id: G-007
    reason: "Du hast am 2026-04-28 16:45 in diesem Thread geantwortet"
    closed_at: 2026-04-28T16:45:00+02:00
    resolution: replied
  - id: G-009
    reason: "Thread aus INBOX archiviert"
    closed_at: 2026-04-29T10:00:00+02:00
    resolution: archived
re_open:
  - id: G-005
    reason: "Neue Inbound-Message am 2026-04-29 09:45"
errors: []
```

Wenn keine Kandidaten: leere Arrays, keine Ausnahme.

## Error Handling

- **Google MCP unavailable / auth fail:** Return `errors: ["mcp_unavailable: <detail>"]`, leere Arrays. Main zeigt Fehler, schreibt nix.
- **Rate Limit:** Return `errors: ["rate_limited: retry_after=<sec>"]`. Main wartet und informiert User.
- **Malformed state file:** Return `errors: ["state_invalid: <detail>"]`. Main re-bootstrappt Template.
- **Gmail-Query liefert >100 Messages:** Truncate auf erste 100 unique Threads, return `errors: ["truncated: N messages omitted"]` — User kann engeren Window-Run starten.

## Rules

- **Conservativ.** Lieber einen Kandidaten zu wenig vorschlagen als Rauschen zu produzieren.
- **Reason-Feld ist Pflicht.** User muss immer nachvollziehen können, warum ein Item vorgeschlagen wurde.
- **Keine Writes.** Nicht in `state/channels/gmail.md` schreiben. Main-MARVIN macht das.
- **Keine Sends.** Niemals Mails senden, Drafts ändern, Labels manipulieren.
- **Dry-Run:** Wenn `dry: true` im Prompt, exakt gleiches Verhalten nur mit `dry: true` im Output.

## Notes

- Erste Woche ist Kalibrierungsphase: Heuristik-Tuning durch Nikolai-Feedback.
- MVP-Fokus: Inbound-Tracking. Outbound-initiated Items (`Direction: out`) sind Phase 2.5.
- Notification-Domain-Blacklist erweitert sich iterativ basierend auf Nikolais Rauschen-Feedback.
- Bei Threads mit mehreren Sendern: `counterpart` = Sender der letzten Inbound-Message.
- Subject-Truncation: max ~60 chars; `Re:`/`Fwd:`-Prefix kann entfernt werden für Lesbarkeit.
````

- [ ] **Step 2: Verify frontmatter + sections**

Run:
```bash
FILE=/Users/nikolaibockholt/marvin/.claude/agents/channel-gmail.md
grep -q '^name: channel-gmail$' $FILE && \
grep -q '^description:' $FILE && \
grep -q '^model: sonnet$' $FILE && \
grep -q '^## Purpose$' $FILE && \
grep -q '^## Workflow$' $FILE && \
grep -q '^## Output Format$' $FILE && \
echo "OK: channel-gmail agent schema valid" || echo "FAIL"
```

Expected: `OK: channel-gmail agent schema valid`

- [ ] **Step 3: Commit**

```bash
cd /Users/nikolaibockholt/marvin
git add .claude/agents/channel-gmail.md
git commit -m "feat: add channel-gmail subagent for Gmail inbox triage"
```

---

## Task 3: Create the `/triage-gmail` Slash Command

**Files:**
- Create: `.claude/commands/triage-gmail.md`

**Context:** User-facing Entry-Point. Lädt State, spawned Subagent, präsentiert Ergebnis, nimmt Confirmation entgegen, schreibt State. Analog zu `/triage-slack`.

- [ ] **Step 1: Create the command definition**

Create `.claude/commands/triage-gmail.md` with exact content:

````markdown
# /triage-gmail - Triage Gmail Primary Inbox

Triagiere offene Gmail-Threads im Primary-Tab: identifiziere neue Mails, die deine Antwort verlangen, und erkenne Smart-Close-Kandidaten (du hast geantwortet ODER archiviert).

## Usage

- `/triage-gmail` — Normaler Lauf: fetch + klassifiziere + schreibe nach Bestätigung
- `/triage-gmail --dry` — Dry-Run: nur zeigen, kein State-Write

## Instructions

### 1. Check State File Exists

Read `state/channels/gmail.md`.

Wenn das File fehlt:
- Bootstrap aus Template (siehe `docs/superpowers/plans/2026-04-29-channel-agents-gmail-mvp.md` Task 1).
- Sei explizit: "State-File neu angelegt. Erster Run fetcht letzte 14 Tage."
- Setze `last_run = null` (Subagent macht 14d-Bootstrap-Window).

### 2. Parse State

Extrahiere aus Frontmatter:
- `last_run` — Timestamp des letzten Runs, oder `null` (dann Bootstrap-Modus).

Parse Tabellen:
- `Open Items` — Liste bestehender offener Items (ID, Since, Direction, Counterpart, Subject, Status, Draft-ID, Project, Thread).
- `Recently Closed` — Liste, um Re-Open-Detection zu ermöglichen.

### 3. Spawn Subagent

Vor dem Spawn: Main liest `GOOGLE_USER_EMAIL` aus `.env`:
```bash
grep '^GOOGLE_USER_EMAIL=' /Users/nikolaibockholt/marvin/.env | cut -d= -f2
```
Wenn leer / nicht gesetzt: Abbruch mit Fehlermeldung an User ("GOOGLE_USER_EMAIL in .env fehlt — siehe Task 0 im Implementation-Plan").

Verwende das `Agent`-Tool mit `subagent_type: channel-gmail`.

Prompt an den Subagenten (minimal — er hat die volle Spec in seiner Definition):

```
Triage Gmail inbox.

gmail_user_email: {nikolai@gomedicusgroup.com}
last_run: {last_run_iso8601 or null}
dry: {true|false}

Current Open Items (for smart-close check):
{bulletpoint-list of G-IDs + thread-IDs + Status from state}

Recently Closed (for re-open detection):
{bulletpoint-list of G-IDs + thread-IDs}

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
📥 Gmail Triage — {run_timestamp}

Pending Confirmation ({count}):
  [C1] {counterpart} — "{subject}"
       reason: {reason}
       {project: ... if set}
       {link}
  [C2] ...

Smart-Close Candidates ({count}):
  [G-007] {counterpart} — {reason} → resolution: {replied|archived}
  [G-008] ...

Re-Open Candidates ({count}):
  [G-005] {counterpart} — {reason}

Commands:
  ✓ C1 C2 C3       — confirm as new Open Items
  ✗ C4 C5          — drop these candidates
  close G-007      — confirm Smart-Close (mit Agent-Resolution)
  reopen G-005     — re-promote to Pending
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
- `close G-007` oder `all close` → G-007 wird aus Open Items entfernt, in Recently Closed eingefügt mit Agent-Resolution (`replied` oder `archived`)
- `reopen G-005` → G-005 aus Recently Closed entfernen, als neues Open Item mit neuer ID anlegen
- `cancel` → kein Write, `last_run` bleibt unverändert

**State-Write-Logik:**

a. **Neue IDs vergeben** für confirmed Candidates:
   - Finde höchste existierende ID in Open Items **und** Recently Closed: `max_id`
   - Neue IDs = `G-(max_id+1)`, `G-(max_id+2)`, ...
   - Falls noch keine IDs existieren: starte bei `G-001`

b. **Append zu `Open Items`-Tabelle:**
   ```markdown
   | G-001 | 2026-04-29 | in | Antonia Gebhardt <antonia@gomedicusgroup.com> | Re: T2 Form — Zeitplan | waiting |  | ai-services-rollout | [link](https://mail.google.com/mail/u/0/#inbox/19db5d9a635fe787) |
   ```

   - `Direction` = `in` (Phase-2-MVP befüllt nur inbound)
   - `Status` = `waiting` (default für neue Inbound-Items)
   - `Draft-ID` leer
   - `Subject` truncate auf max 60 chars

c. **Smart-Close:**
   - Entferne Row aus `Open Items`
   - Append zu `Recently Closed` mit `Closed` = `closed_at` aus Agent-Report und `Resolution` = `replied` oder `archived` per Agent-Vorschlag:
     ```markdown
     | G-007 | 2026-04-28 16:45 | Jens Brandt | Re: OKR-Finalisierung | replied |
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
✅ Gmail Triage complete.
   Added:    {n} new Open Items (G-001, G-002, ...)
   Closed:   {n} items ({n_replied} replied, {n_archived} archived)
   Re-opened: {n} items
   Dropped:  {n} candidates
   Pruned:   {n} items from Recently Closed (>7d old)

Current state: {count} total Open Items in Gmail.
```

Bei `dry: true`:
```
🧪 DRY-RUN complete. State unchanged.
Would have: Added {n}, Closed {n} ({n_replied}/{n_archived}), Re-opened {n}, Dropped {n}.
```

## Notes

- Command schreibt **nur** `state/channels/gmail.md` — keine Project-File-Writes (orthogonal, siehe Spec).
- Truncate Subject auf max 60 chars; `Re:`/`Fwd:`-Prefix kann zur Lesbarkeit entfernt werden.
- Falls Agent-Output Truncation-Error meldet (>100 Messages): User informieren, kürzeres Window vorschlagen.
- Einmal pro Arbeitstag ist ein sinnvoller Default-Rhythmus.
````

- [ ] **Step 2: Verify the command structure**

Run:
```bash
FILE=/Users/nikolaibockholt/marvin/.claude/commands/triage-gmail.md
grep -q '^# /triage-gmail' $FILE && \
grep -q '^## Usage$' $FILE && \
grep -q '^## Instructions$' $FILE && \
grep -q '### 1\. Check State File Exists' $FILE && \
grep -q '### 6\. Apply User Confirmation' $FILE && \
echo "OK: triage-gmail command schema valid" || echo "FAIL"
```

Expected: `OK: triage-gmail command schema valid`

- [ ] **Step 3: Commit**

```bash
cd /Users/nikolaibockholt/marvin
git add .claude/commands/triage-gmail.md
git commit -m "feat: add /triage-gmail command orchestrating channel-gmail agent"
```

---

## Task 4: First End-to-End Dry-Run Test

**Files:**
- No changes; manual test documented

**Context:** Erste echte Invokation. Da kein automatisiertes Testing existiert, dokumentieren wir, was als Test passiert und was als Erfolg gilt. Nikolai führt das manuell aus.

- [ ] **Step 1: Ensure state file is in bootstrap state**

Run: `head -6 /Users/nikolaibockholt/marvin/state/channels/gmail.md`
Expected: Frontmatter zeigt `last_run: null`. Wenn nicht (z.B. bereits Läufe stattfanden), manuell auf `null` zurücksetzen via `Edit` tool.

- [ ] **Step 2: Run in dry mode**

In einer MARVIN-Session: `/triage-gmail --dry`

Expected output format:
```
🧪 DRY-RUN — State wird nicht geändert.

📥 Gmail Triage — 2026-04-29T10:00:00+02:00

Pending Confirmation (N):
  [C1] {counterpart} — "{subject}"
       reason: {reason}
       ...
  ...

Smart-Close Candidates (0):  # leer, weil keine Open Items existieren
Re-Open Candidates (0):      # leer

Commands:
  ✓ C1 C2 C3 ...
  ...

🧪 DRY-RUN complete. State unchanged.
Would have: Added N, Closed 0 (0/0), Re-opened 0, Dropped 0.
```

Wenn stattdessen:
- **Fehler `mcp_unavailable`:** Prüfe Google-Workspace-MCP-Connection (`/status`), prüfe OAuth-Tokens.
- **Fehler `truncated: N messages omitted`:** Bootstrap-Window war zu groß. Entweder akzeptieren (User dropped beim Confirm) oder Subagent-Workflow-Definition anpassen (`newer_than:7d` statt `14d`).
- **Kein Output / hängt:** MCP-Search-Query-Syntax könnte falsch sein; Logs prüfen.

- [ ] **Step 3: Verify state file unchanged**

Run: `cd /Users/nikolaibockholt/marvin && git status state/channels/gmail.md`
Expected: `nothing to commit` — File wurde nicht modifiziert durch Dry-Run.

- [ ] **Step 4: Calibration notes**

Edit `state/projects/marvin-infrastructure.md`. Füge unter dem bestehenden Channel-Agents-Block (aktuell `## Channel-Agents Slack MVP (24.04.2026)`) eine neue Sektion ein:

```markdown
## Channel-Agents Gmail MVP (29.04.2026)

- **Bootstrap-Run (Dry):** {N} Kandidaten, {M} subjektive false positives.
- **Häufigster Filter-Miss:** {z.B. interne Bots, Newsletter ohne List-Unsubscribe}
- **Häufigster echter Miss:** {z.B. Mailing-List-Adressen wo ich nicht direkt im To stehe}
- **Notification-Domain-Erweiterungen für Round 1 Calibration:** {Liste der real beobachteten Sender}
```

Diese Notizen sind Input für Task 7 (Heuristic Calibration).

- [ ] **Step 5: Commit calibration notes (nur wenn Edits gemacht)**

```bash
cd /Users/nikolaibockholt/marvin
git add state/projects/marvin-infrastructure.md
git commit -m "docs: channel-gmail bootstrap dry-run calibration notes"
```

---

## Task 5: First Real Run (Write State)

**Files:**
- Modify: `state/channels/gmail.md` (via /triage-gmail, not manually)

**Context:** Erster echter Write. Nach diesem Schritt sollten reale Open Items im State-File stehen, und `last_run` auf jetzt gesetzt sein.

- [ ] **Step 1: Run triage live**

In einer MARVIN-Session: `/triage-gmail`

Output sollte identisch zu Dry-Run-Step 2 sein (ohne 🧪 Banner).

- [ ] **Step 2: Confirm a sensible subset**

Beispiel: `✓ C1 C3, ✗ C2 C4 C5, cancel` wenn keine guten Kandidaten dabei sind.

Expected:
```
✅ Gmail Triage complete.
   Added:    2 new Open Items (G-001, G-002)
   Closed:   0 items
   Re-opened: 0 items
   Dropped:  3 candidates
   Pruned:   0 items from Recently Closed (>7d old)

Current state: 2 total Open Items in Gmail.
```

- [ ] **Step 3: Verify state file**

Run: `cat /Users/nikolaibockholt/marvin/state/channels/gmail.md`

Check manuell:
- Frontmatter `last_run` ist gesetzt auf aktuellen Timestamp (ISO 8601 mit Timezone)
- `Open Items`-Tabelle hat die bestätigten Items mit IDs `G-001`, `G-002`
- Spalten korrekt befüllt: `Direction = in`, `Status = waiting`, `Draft-ID` leer
- `Pending Confirmation` ist leer (oder hat keine Tabellen-Rows nach Header)
- `Recently Closed` unverändert (leer bei Bootstrap)

Run: Schema-Check aus Task 1 Step 2:
```bash
FILE=/Users/nikolaibockholt/marvin/state/channels/gmail.md
grep -q '^channel: gmail$' $FILE && \
grep -q '^last_run:' $FILE && \
grep -q '^## Open Items$' $FILE && \
grep -q '^## Pending Confirmation$' $FILE && \
grep -q '^## Recently Closed$' $FILE && \
echo "OK: gmail.md valid" || echo "FAIL"
```
Expected: `OK: gmail.md valid`

- [ ] **Step 4: Commit state**

```bash
cd /Users/nikolaibockholt/marvin
git add state/channels/gmail.md
git commit -m "state: initial gmail triage run — N open items tracked"
```

---

## Task 6: Smart-Close Round-Trip Test (Reply-Variante)

**Files:**
- Modify: `state/channels/gmail.md` (via /triage-gmail)

**Context:** Verifiziere dass der Reply-Lifecycle (Open → Closed via reply) funktioniert. Dafür brauchen wir ein Item, bei dem Nikolai nach dem initialen Triage-Run tatsächlich antwortet.

- [ ] **Step 1: Pick one Open Item and reply in Gmail UI**

Wähle ein `G-00X` aus `state/channels/gmail.md` aus. Gehe in Gmail, öffne den Thread, antworte tatsächlich (echte Reply, nicht nur Draft). Sende.

- [ ] **Step 2: Run triage again**

`/triage-gmail`

Expected:
```
Smart-Close Candidates (1):
  [G-00X] {counterpart} — Du hast am <ts> in diesem Thread geantwortet → resolution: replied

Commands: ...
```

- [ ] **Step 3: Confirm smart-close**

`close G-00X`

Expected:
```
✅ Gmail Triage complete.
   Added:    0
   Closed:   1 items (1 replied, 0 archived)
   ...
```

- [ ] **Step 4: Verify state**

Run: `grep 'G-00X' /Users/nikolaibockholt/marvin/state/channels/gmail.md`
Expected:
- `G-00X` steht unter `## Recently Closed`, **nicht** mehr unter `## Open Items`
- Resolution-Spalte zeigt `replied`

- [ ] **Step 5: Commit state**

```bash
cd /Users/nikolaibockholt/marvin
git add state/channels/gmail.md
git commit -m "state: gmail smart-close reply round-trip verified"
```

---

## Task 7: Smart-Close Round-Trip Test (Archive-Variante)

**Files:**
- Modify: `state/channels/gmail.md` (via /triage-gmail)

**Context:** Verifiziere dass der Archive-Lifecycle (Open → Closed via archive ohne reply) funktioniert. Gmail-spezifisch — Slack hatte das nicht.

- [ ] **Step 1: Pick one Open Item and archive in Gmail UI**

Wähle ein anderes `G-00Y` aus `state/channels/gmail.md` (nicht das aus Task 6). Gehe in Gmail, öffne den Thread, archiviere (`E`-Shortcut oder Archive-Button) — **ohne zu antworten**.

- [ ] **Step 2: Run triage again**

`/triage-gmail`

Expected:
```
Smart-Close Candidates (1):
  [G-00Y] {counterpart} — Thread aus INBOX archiviert → resolution: archived

Commands: ...
```

Falls `replied`-Resolution statt `archived` angezeigt wird: Der Agent hat eine Sent-Message gefunden — vermutlich hast du doch geantwortet. Prüfe den Thread.

- [ ] **Step 3: Confirm smart-close**

`close G-00Y`

Expected:
```
✅ Gmail Triage complete.
   Added:    0
   Closed:   1 items (0 replied, 1 archived)
   ...
```

- [ ] **Step 4: Verify state**

Run: `grep 'G-00Y' /Users/nikolaibockholt/marvin/state/channels/gmail.md`
Expected:
- `G-00Y` steht unter `## Recently Closed`
- Resolution-Spalte zeigt `archived`

- [ ] **Step 5 (optional): Re-Open-Test**

Wenn jemand auf den archivierten Thread G-00Y antwortet, sollte der nächste `/triage-gmail` G-00Y als Re-Open-Kandidat zeigen. Optional, wenn Gelegenheit kommt.

- [ ] **Step 6: Commit state**

```bash
cd /Users/nikolaibockholt/marvin
git add state/channels/gmail.md
git commit -m "state: gmail smart-close archive round-trip verified"
```

---

## Task 8: Heuristic Calibration Round 1

**Files:**
- Modify: `.claude/agents/channel-gmail.md` (refine heuristic + blacklist)
- Modify: `state/projects/marvin-infrastructure.md` (log calibration)

**Context:** Nach ~5 Triage-Runs (oder ~1 Woche Nutzung) zeigt sich, wo die Heuristik zu viele false positives produziert oder echte Items missed. Einmal bewusst justieren, dokumentieren, committen.

- [ ] **Step 1: Review past runs**

Sammle subjektive Einschätzung über mehrere Runs:
- Welche false positives waren häufig? (z.B. spezifische interne Bots, Newsletter ohne `List-Unsubscribe`-Header, Vendor-Updates die wie Anfragen aussehen)
- Welche echten Items fehlten? (z.B. Mails mit mir nur in CC die echte Anfragen sind, Threads mit langer Latenz wo `last_run` schon vorbeigegangen ist)
- Welche Domains tauchen wiederholt auf, die als Bot/Notification gefiltert werden sollten?

- [ ] **Step 2: Adjust heuristic in agent file**

Edit `.claude/agents/channel-gmail.md`:

**Falls neue Notification-Domains identifiziert** (z.B. `intercom.io`, `mailchimp.com`, `personio.de`):
- Unter "Auto-Filter → Sender-Domain in Notification-Blacklist" ergänzen.

**Falls neue Sender-Patterns** (z.B. `news@`, `info@`):
- Vorsichtig sein — `info@gomedicusgroup.com` könnte legitim sein. Prüfen.
- Wenn ja, unter "Auto-Filter → Sender-Pattern matched" ergänzen.

**Falls Mailing-List-Header gemisst werden** (z.B. echte Anfragen über interne Verteiler):
- Subagent-Workflow-Step 4 anpassen: `to:me` Filter aufweichen für bekannte interne Domains? — Diskutieren mit User vor Code-Change. In MVP nicht ändern, in Notes dokumentieren für Phase 2.5.

- [ ] **Step 3: Log calibration**

Edit `state/projects/marvin-infrastructure.md`. Unter dem `## Channel-Agents Gmail MVP (29.04.2026)`-Block (aus Task 4) ergänze:

```markdown
- {YYYY-MM-DD} — Kalibrierung Round 1: {was geändert in Stichworten}. Begründung: {N false positives über M Runs, oder M echte Items gemisst}.
```

- [ ] **Step 4: Run triage again to verify**

`/triage-gmail --dry`

Prüfe, ob das vorher problematische Pattern jetzt sauber ist. Falls nicht: weitere Anpassungen, gleicher Cycle.

- [ ] **Step 5: Commit**

```bash
cd /Users/nikolaibockholt/marvin
git add .claude/agents/channel-gmail.md state/projects/marvin-infrastructure.md
git commit -m "refine: channel-gmail heuristic calibration round 1"
```

---

## Task 9: Update CLAUDE.md Documentation

**Files:**
- Modify: `CLAUDE.md` — Channel-State-Tree, Agents-Tabelle, Commands-Tabelle

**Context:** Wenn ein neues Team-Member (oder Future-Claude) MARVIN öffnet, muss der Gmail-Channel aus CLAUDE.md ersichtlich sein. Ergänzt die existierende Slack-Dokumentation.

- [ ] **Step 1: Locate state-architecture block**

Run: `grep -n 'channels/' /Users/nikolaibockholt/marvin/CLAUDE.md`
Expected: Zeigt Zeilen, in denen aktuell `slack.md` referenziert wird (z.B. `state/channels/slack.md`).

- [ ] **Step 2: Edit the state-tree diagram**

Edit `CLAUDE.md`. Suche den State-Tree-Block (markdown code-fence mit `state/`):

Aktueller Block enthält:
```
├── channels/             Kanalzentrierte Inbound-Queues (SSoT für "someone waiting on me")
│   ├── slack.md          Slack DMs + @-Mentions, getracked via /triage-slack
│   └── ...               Gmail, Notion, Calendar, Drive (spätere Phasen)
```

Neu:
```
├── channels/             Kanalzentrierte Inbound-Queues (SSoT für "someone waiting on me")
│   ├── slack.md          Slack DMs + @-Mentions, getracked via /triage-slack
│   ├── gmail.md          Gmail Primary-Tab Threads, getracked via /triage-gmail
│   └── ...               Notion, Calendar, Drive (spätere Phasen)
```

- [ ] **Step 3: Add agent to the Agents section**

Edit `CLAUDE.md`. Suche die Agents-Tabelle/Liste unter "### Agents (`.claude/agents/`)".

Aktueller Block hat:
```markdown
- **channel-slack** — triagiert Slack-Inbox, klassifiziert Action-Needed-Items. Spawned von `/triage-slack`. Model: sonnet.
```

Direkt darunter ergänzen:
```markdown
- **channel-gmail** — triagiert Gmail Primary-Tab, klassifiziert Threads die Antwort verlangen, erkennt Smart-Close (Reply ODER Archive). Spawned von `/triage-gmail`. Model: sonnet.
```

- [ ] **Step 4: Add command to the Commands section**

Edit `CLAUDE.md`. Suche die "Slash Commands (inside MARVIN)" Tabelle.

Aktuelle Tabelle hat eine Zeile:
```markdown
| `/triage-slack` | Triage Slack inbox: offene Items klassifizieren, Smart-Close erkennen |
```

Direkt darunter ergänzen:
```markdown
| `/triage-gmail` | Triage Gmail Primary-Tab: offene Threads klassifizieren, Smart-Close (Reply ODER Archive) erkennen |
```

- [ ] **Step 5: Verify edits**

Run: `grep -c 'channel-gmail' /Users/nikolaibockholt/marvin/CLAUDE.md`
Expected: Mindestens `1` (in Agents-Sektion). Realistisch `1`.

Run: `grep '/triage-gmail' /Users/nikolaibockholt/marvin/CLAUDE.md`
Expected: Mindestens 1 Match (Commands-Tabelle).

Run: `grep 'gmail.md' /Users/nikolaibockholt/marvin/CLAUDE.md`
Expected: Mindestens 1 Match (State-Tree).

- [ ] **Step 6: Commit**

```bash
cd /Users/nikolaibockholt/marvin
git add CLAUDE.md
git commit -m "docs: document channel-gmail agent + /triage-gmail command in CLAUDE.md"
```

---

## Task 10: Final Integration Smoke Test

**Files:**
- No changes; manual verification

**Context:** Schluss-Check: Alle Bausteine existieren, schema-valide, und ein kompletter Run läuft durch.

- [ ] **Step 1: Verify all artifacts exist**

Run:
```bash
cd /Users/nikolaibockholt/marvin && \
test -f state/channels/gmail.md && \
test -f .claude/agents/channel-gmail.md && \
test -f .claude/commands/triage-gmail.md && \
grep -q 'GOOGLE_USER_EMAIL' .env.example && \
grep -q 'channel-gmail' CLAUDE.md && \
grep -q '/triage-gmail' CLAUDE.md && \
echo "OK: all artifacts in place" || echo "FAIL: missing artifact"
```

Expected: `OK: all artifacts in place`

- [ ] **Step 2: Verify schema validity of state file**

```bash
FILE=/Users/nikolaibockholt/marvin/state/channels/gmail.md
grep -q '^channel: gmail$' $FILE && \
grep -q '^last_run:' $FILE && \
grep -q '^## Open Items$' $FILE && \
grep -q '^## Pending Confirmation$' $FILE && \
grep -q '^## Recently Closed$' $FILE && \
echo "OK: gmail.md valid" || echo "FAIL"
```

Expected: `OK: gmail.md valid`

- [ ] **Step 3: Verify agent frontmatter**

```bash
FILE=/Users/nikolaibockholt/marvin/.claude/agents/channel-gmail.md
grep -q '^name: channel-gmail$' $FILE && \
grep -q '^description:' $FILE && \
grep -q '^model: sonnet$' $FILE && \
echo "OK: agent valid" || echo "FAIL"
```

Expected: `OK: agent valid`

- [ ] **Step 4: Run one final live triage**

`/triage-gmail` — sollte sauber durchlaufen ohne neue Fehler.

Expected:
- Output zeigt Pending/Smart-Close/Re-Open-Sektionen
- Falls keine neuen Items: alle Sektionen 0 Items
- Falls neue Items: User confirmt oder cancelt — egal welches Verhalten, kein Crash

- [ ] **Step 5: Push**

```bash
cd /Users/nikolaibockholt/marvin
git push
```

Expected: Alle Commits landen im `NikolaiGoMedicus/marvin-chiefofstaff` Remote.

---

## Post-Implementation: Was als nächstes?

Nach Abschluss dieses Plans ist der Gmail-MVP live. Natürliche Follow-ups (NICHT Teil dieses Plans):

1. **Phase 2.5 — `/draft`-Refactor + Outbox-Migration:** Die Outbox in `current.md` durch direkte State-Schreibung in `state/channels/{channel}.md` ersetzen. Cross-channel (Slack + Gmail). Eigene Spec/Plan.
2. **Slack DM-Gap fix:** Slack-Subagent kann private DMs nicht über `slack_list_channels` finden. Workaround entwickeln (z.B. hartcodierte DM-Channel-IDs in `.env`).
3. **Notion / Calendar / Drive Channel-Agents:** Phase 3+, jeweils eigene Spec.
4. **`/inbox-all` Aggregator:** Cross-Channel-Übersicht. Erst sinnvoll wenn ≥3 Channel-Agents existieren.
5. **Auto-Trigger via Cron / `/start`-Hook:** Wenn Triage-Workflow stabil läuft, Background-Run alle X Stunden statt manuell.

Diese bekommen eigene Specs + Pläne, wenn sie an der Reihe sind.
