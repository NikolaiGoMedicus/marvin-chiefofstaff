---
title: Channel-Agents Phase 2 — Gmail-Agent Design
date: 2026-04-28
status: design
author: Nikolai + MARVIN
phase: 2 (Gmail-MVP)
builds_on: docs/superpowers/specs/2026-04-24-channel-agents-design.md
---

# Channel-Agents Phase 2 — Gmail-Agent Design

## 1. Kontext

Die [Channel-Agents-Spec vom 24.04.](2026-04-24-channel-agents-design.md) definiert die Architektur (Subagent + Slash-Command + flat State-File pro Kanal). Phase 1 (Slack) ist seit 24.04. live und stabil.

Diese Phase-2-Spec ergänzt die Gmail-spezifischen Design-Entscheidungen, die in der Phase-1-Spec nur skizziert waren. Architektur, Lifecycle und Patterns bleiben identisch zu Slack — diese Spec dokumentiert nur die Stellen, an denen Gmail anders behandelt wird.

## 2. Pain-Anker (warum Gmail Phase 2)

**Tracking, nicht Filtering.** Nikolai verliert Threads aus dem Blick, wo jemand auf seine Antwort wartet. Das Volumen-Filter-Problem ("80 Mails/Tag") ist hier explizit **nicht** das Ziel — Gmail's eigenes Tab-System (Primary/Promotions/Updates/Social) löst das schon ausreichend.

Das System soll konkret beantworten: *"Welche Threads warten auf eine Antwort von mir, und wie alt sind die?"*

## 3. Gmail-spezifische Design-Entscheidungen

| # | Frage | Entscheidung | Begründung |
|---|-------|--------------|------------|
| 1 | Universe (was scannen) | Nur `category:primary` | Google's ML hat schon entschieden "1:1-Korrespondenz". Volumen sinkt um ~90%. |
| 2 | Heuristik | Reply-State, nicht Read-State | Read = "ich hab's gesehen", Reply = "ich hab geantwortet". Nur letzteres = "wartet auf mich". |
| 3 | Adressierung | `to:me` only, kein CC | CC = FYI, kein "wartet auf". Mailing-Listen kennen `To:` nicht. |
| 4 | Scope MVP | Nur inbound-Tracking | `/draft` + Outbox-Migration ist eigene Phase 2.5 — cross-channel, eigene Spec. |
| 5 | Lifecycle-Status | `waiting` → `drafted` → `sent` → `closed` | Mehrstufig, weil Gmail-Drafts zwischen Trigger und Send langlebiger sind als Slack-Replies. |
| 6 | Smart-Close-Trigger | Reply ODER Archive | Archive in Gmail = "ich lasse es bewusst los". Slack hat kein Archive — Gmail-Spezifikum. |
| 7 | Bootstrap-Window | 14 Tage | Slack hatte 7d. Email-Replies sind langsamer; ein 7d-Fenster verpasst legitime offene Threads. |

## 4. Architektur

Identisch zur Phase-1-Architektur. Drei Files:

```
.claude/agents/channel-gmail.md         (Subagent, Sonnet, read-only)
.claude/commands/triage-gmail.md        (Slash-Command)
state/channels/gmail.md                 (State-File, einzige SSoT)
```

Plus CLAUDE.md-Update (Channel-Liste, Agents-Tabelle, Commands-Tabelle).

## 5. Components

### 5.1 Subagent: `.claude/agents/channel-gmail.md`

```yaml
---
name: channel-gmail
description: Triage Gmail Primary-Tab für Threads, die auf Nikolais Antwort warten; klassifiziere Action-Needed-Items; erkenne Smart-Close-Kandidaten (Reply oder Archive)
model: sonnet
---
```

**Tools (Read-Only):**
- `mcp__google-workspace__search_gmail_messages`
- `mcp__google-workspace__get_gmail_thread_content`
- `mcp__google-workspace__get_gmail_messages_content_batch`
- `mcp__google-workspace__list_gmail_labels` (für INBOX-Label-Check beim Smart-Close-archived)
- `Read` (für State-File)

**Inputs (über Prompt):**
- `gmail_user_email` — Nikolai's Email-Adresse (aus `.env`: `GOOGLE_USER_EMAIL` oder hardcoded fallback)
- `last_run` (oder `null` für Bootstrap → 14d-Fenster)
- Aktuelle Open Items (für Smart-Close-Check)
- Recently-Closed-IDs (für Re-Open-Detection)
- Optional `dry: true`

**Workflow:**

1. **Parse Prompt** — Extract last_run + flags
2. **Fetch new candidates** via Gmail-Search:
   - Bootstrap-Run: `category:primary newer_than:14d to:me -from:me`
   - Subsequent: `category:primary after:{last_run_unix_ts} to:me -from:me`
3. **Per Thread klassifizieren:**
   - Hole Thread-Content via `get_gmail_thread_content`
   - Letzter Sender ≠ Nikolai → Kandidat
   - Letzter Sender = Nikolai (du hast schon geantwortet) → kein Kandidat
4. **Auto-Filter (drop, nie Kandidat):**
   - Sender matched `noreply@`, `no-reply@`, `notifications@`, `mailer-daemon@`, `donotreply@`
   - `List-Unsubscribe`-Header vorhanden im Original-Header
   - Bekannte Notification-Domains (initial Liste, iterativ erweitern):
     - `linear.app`, `github.com`, `notion.so`, `calendly.com`, `loom.com`, `slack.com`, `figma.com`, `vercel.com`
     - GoMedicus-interne Bots (zu identifizieren in Calibration)
   - `Auto-Submitted`-Header gesetzt (RFC 3834 — Auto-Reply, Out-of-Office)
   - Eigene gesendete Messages (`from: me`)
5. **Smart-Close für existierende Open Items** (Reihenfolge wichtig — `replied` vor `archived` prüfen, weil Reply implizit auch archiviert sein kann):
   - **Jeder Status** → Sent-Message von mir nach Item's `Since` im Thread? → close `replied`
   - **Jeder Status** → INBOX-Label auf Thread entfernt UND keine Sent-Message? → close `archived`
6. **Re-Open-Check:** Items in Recently Closed mit neuem Inbound-Event → als Kandidat aufnehmen
7. **Project-Match** über Subject + Sender-Domain gegen `state/projects/*.md` Slugs/Keywords
8. **Return YAML** (gleiche Struktur wie Slack-Subagent, mit zusätzlichen Feldern für Gmail)

**Output Format:**

```yaml
run_timestamp: 2026-04-28T18:00:00+02:00
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
    reason: "Thread aus INBOX archiviert seit 2026-04-28"
    closed_at: 2026-04-28T17:00:00+02:00
    resolution: archived
re_open:
  - id: G-005
    reason: "Neue Inbound-Message am 2026-04-28 10:00"
errors: []
```

**Rules** (analog zu Slack):
- Conservativ klassifizieren (lieber 1 Kandidat zu wenig als Rauschen)
- Reason-Feld ist Pflicht
- Keine Writes, keine Sends
- Bei `dry: true`: gleiches Verhalten, nur Flag im Output

### 5.2 Slash-Command: `.claude/commands/triage-gmail.md`

Identisch zu `/triage-slack` in Struktur. Differenzen:

- Liest `GOOGLE_USER_EMAIL` aus `.env` (statt `SLACK_USER_ID`)
- Subagent-Type: `channel-gmail`
- State-File: `state/channels/gmail.md`
- Confirm-Commands wie Slack — `close` übernimmt die vom Agent vorgeschlagene Resolution (`replied` oder `archived`):
  ```
  Commands:
    ✓ C1 C2 C3       — confirm as new Open Items
    ✗ C4 C5          — drop these candidates
    close G-007      — confirm Smart-Close (mit Agent-Resolution: replied | archived)
    reopen G-005     — re-promote to Pending
    all ✓            — confirm ALL pending candidates
    all close        — confirm ALL smart-close
    cancel           — don't write anything
  ```
  Wenn User die Resolution überschreiben will (z.B. Agent sagt `archived`, User hat in Wirklichkeit telefonisch geantwortet → `replied`): manuelle Edit von `state/channels/gmail.md`. Kein separater Command für Override in MVP.

### 5.3 State-File: `state/channels/gmail.md`

Bootstrap-Template:

```markdown
---
channel: gmail
last_run: null
updated: 2026-04-28
---

# Gmail Channel State

> **Orthogonal zu `state/projects/*.md`.** Trackt nur Email-Threads, die auf Nikolais Antwort warten. Längsseitige Projekt-Arcs leben in `state/projects/`.

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

**Spalten-Semantik (Open Items):**
- `ID`: `G-001`, monoton steigend, nie wiederverwendet (auch nach Close)
- `Since`: Datum als das Item Open wurde (nicht das Datum der ursprünglichen Mail)
- `Direction`: `in` (Phase 2 MVP) | `out` (forward-compat, nicht aktiv geschrieben)
- `Counterpart`: bei `in` der Sender-Name + Email; bei `out` (zukünftig) der/die Empfänger
- `Subject`: Email-Subject, max ~60 chars truncated; ohne `Re:`/`Fwd:` Prefix wenn möglich
- `Status`: `waiting` | `drafted` | `sent` (`sent` ist transient — beim nächsten Triage erkennt Agent das und closed)
- `Draft-ID`: Gmail-Draft-Resource-ID (z.B. `r-4148311281209141750`) oder leer
- `Project`: project slug (z.B. `ai-services-rollout`) oder leer
- `Thread`: Gmail-URL `https://mail.google.com/mail/u/0/#inbox/{thread_id}`

**Resolution-Werte (Recently Closed):**
- `replied` — Sent-Message von mir im Thread erkannt
- `archived` — INBOX-Label entfernt (manuell archiviert in Gmail)
- `dropped` — User hat bei Triage `✗` gesagt (nie ein Open Item geworden, nicht persistiert)

## 6. Lifecycle

```
Inbound Email arrives in Primary
          │
          │  next /triage-gmail
          ▼
Subagent klassifiziert → Pending Confirmation
          │
   ┌──────┴──────┐
 User ✗         User ✓
   │             │
 (dropped)   Open Items (Status: waiting)
                  │
        ┌─────────┴──────────┐
   Nikolai antwortet    Nikolai archiviert in Gmail
   in Gmail             ohne Antwort
        │                    │
  Smart-Close `replied` Smart-Close `archived`
        │                    │
        └────────┬───────────┘
                 ▼
        Recently Closed (7d TTL)
```

**Status-Transitionen:**
- `waiting` → `drafted`: heute manuell (Phase 2.5 wird das via `/draft` automatisieren)
- `drafted` → `sent`: durch User-Send in Gmail-UI; Agent erkennt beim nächsten Triage
- `sent` → Recently Closed: durch Smart-Close beim Triage-Run
- jeder Status → Recently Closed (`archived`): manuell archiviert in Gmail

## 7. Auto-Filter — Initial Blacklist

Hartcodiert im Subagenten-Workflow, iterativ in Calibration erweitert:

**Sender-Patterns (Email-Address):**
- `noreply@*`
- `no-reply@*`
- `notifications@*`
- `mailer-daemon@*`
- `donotreply@*`
- `bounces@*`
- `auto@*`

**Header-basiert:**
- `List-Unsubscribe` vorhanden → wahrscheinlich Newsletter
- `Auto-Submitted` ≠ `no` → Auto-Reply / OOO
- `Precedence: bulk` oder `Precedence: list` → Newsletter

**Domains (initial):**
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

Die Domain-Liste wird in `.claude/agents/channel-gmail.md` als bearbeitbarer Block geführt. Calibration-Round-1 (analog Slack Task 7) zieht echte Domains aus den ersten ~5 Triage-Runs nach.

## 8. Out of Scope (Phase 2.5+)

Diese Spec deckt explizit **nicht** ab. Eigene Spec/Plan bei Bedarf:

| Feature | Scope | Begründung |
|---------|-------|------------|
| `/draft` schreibt direkt in Open Items | Phase 2.5 | Cross-channel (betrifft auch Slack); eigene Diskussion über Outbox-Migration |
| Outbox in `current.md` migrieren/abschaffen | Phase 2.5 | Hängt an /draft-Refactor |
| Outbound-initiated Items (`Direction: out`) | Phase 2.5 | Schema ist forward-compat, aber kein Code befüllt das in Phase 2 |
| Auto-Trigger via Cron / `/start` | Phase 3 | Slack-MVP hat das auch nicht; on-demand reicht |
| Snooze / Defer | Phase 3 | YAGNI für jetzt |
| `/inbox-all` Aggregator | Phase 3 | Erst sinnvoll wenn ≥3 Channel-Agents existieren |
| Auto-Writes in Project-Files | Out | Kanal-Layer bleibt orthogonal |

## 9. Calibration & Success-Kriterien

**Bootstrap (Tag 0):** Erster `/triage-gmail` Run scannt 14 Tage. Erwartet werden 5–20 Kandidaten (Schätzung basierend auf typischer Inbox-Frequenz). Ein hoher Anteil ist okay — User dropped die Hälfte beim ersten Confirm.

**Calibration Round 1 (nach ~5 Runs / 1 Woche):**
- False-Positive-Rate < 30%
- Smart-Close-Detection-Rate > 80% (Reply-Detection sollte hoch sein, da Sent-Folder eindeutig ist)
- Domain-Blacklist um real beobachtete Sender erweitern

**Success-Kriterien (analog Slack-MVP):**
- `/triage-gmail` läuft in <60s bei Bootstrap, <30s bei Subsequent-Runs
- `state/channels/gmail.md` greppbar und manuell editierbar
- Nikolai braucht nicht mehr in Gmail-UI scrollen, um zu wissen, was offen ist

## 10. Offene Punkte (zur Implementierungs-Zeit)

- **`GOOGLE_USER_EMAIL`-Variable:** Existiert die in `.env`? Falls nicht: hinzufügen analog zu `SLACK_USER_ID`. Falls schon: Variable-Name verifizieren.
- **Exakter Gmail-Search-Query:** `category:primary` — verifizieren, dass das via `search_gmail_messages` korrekt gefiltert wird (Gmail-Search-Syntax)
- **Smart-Close `archived`-Detection:** Schnellster Weg ist `INBOX`-Label-Check. Verifizieren in Implementation, ob `list_gmail_labels` per-Thread funktioniert oder ob `get_gmail_thread_content` das Label-Set zurückgibt.
- **Counterpart-Display:** Bei Threads mit mehreren Sendern (Konversation mit 3+ Personen): wessen Name in Counterpart-Spalte? Default: letzter Sender. Eventuell als Calibration-Item.
- **Truncation Subject:** ~60 chars als Default, in Implementation-Plan finalisieren.

## 11. Migration / Backwards-Compat

Keine Daten-Migration nötig — `state/channels/gmail.md` ist neu.

`current.md`'s `## Outbox`-Sektion bleibt unverändert in Phase 2 — wird in Phase 2.5 angefasst.

Existing `/draft`-Workflow funktioniert weiter wie bisher (parkt in Outbox via current.md). Ein Gmail-Draft kann manuell mit einem Open Item korreliert werden, indem User die Draft-ID in `state/channels/gmail.md` einträgt — keine Tooling-Unterstützung in Phase 2.

## 12. Referenzen

- [Phase-1-Spec (Channel-Agents Slack-MVP)](2026-04-24-channel-agents-design.md) — Architektur-Grundlagen
- [Slack-MVP Implementation Plan](../plans/2026-04-24-channel-agents-slack-mvp.md) — Vorlage für Phase-2-Plan
- [State `state/channels/slack.md`](../../../state/channels/slack.md) — Live-Reference für State-File-Format
- [Subagent `.claude/agents/channel-slack.md`](../../../.claude/agents/channel-slack.md) — Vorlage für Subagent-Definition
