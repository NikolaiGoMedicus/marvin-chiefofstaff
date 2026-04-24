---
title: Channel-Agents — Spezialisierte Agenten pro Integration-Kanal
date: 2026-04-24
status: design
author: Nikolai + MARVIN
mvp_scope: Slack-Agent (Phase 1), Gmail-Agent (Phase 2)
---

# Channel-Agents — Design Spec

## 1. Motivation

MARVINs aktuelle State-Architektur ist **projektzentriert** (`state/projects/*.md`). Sie beantwortet die Frage "wo steht Projekt X?" gut, aber nicht "was ist über Kanal Y an mich reingekommen und braucht noch meine Reaktion?".

Nikolai verliert ohne zusätzliche Struktur den Überblick, welche eingehenden Threads pro Kanal (Gmail, Slack, Notion, Calendar, Drive) noch Interaktion von ihm verlangen — insbesondere bei Gmail mit hohem Volumen. Das führt dazu, dass Items durchs Raster fallen.

Diese Spec beschreibt **Channel-Agents**: spezialisierte Subagenten pro Integration, die eine kanalzentrierte Inbound-Queue pflegen und Nikolai erlauben, pro Kanal sauber zu triagen.

## 2. Design-Entscheidungen (Constraints)

Aus dem Brainstorming vom 2026-04-24:

| # | Frage | Entscheidung |
|---|-------|--------------|
| 1 | Kern-Problem | **D** — "Items fallen nicht durchs Raster" (Tracking pro Kanal) |
| 2 | Was ist "offenes Item"? | **D** — Hybrid: Agent schlägt Kandidaten vor, User bestätigt ✓/✗ |
| 3 | Wann wird der Agent aktiv? | **D** — On-Demand via Command, später optional `/start`-Hook |
| 4 | Channel- vs Project-State | **C** — Orthogonal: Channel = inbound queue, Project = längsseitiger Arc |
| 5 | MVP-Scope | **B→A** — Slack zuerst, Gmail danach, Rest später |
| 6 | Aktionen pro Item | **D** — Draft-Assistenz via bestehendem `/draft`, plus Smart-Close-Detection |

## 3. Architektur

### 3.1 Grundprinzipien

- **Subagent klassifiziert, Haupt-MARVIN schreibt.** Der Channel-Subagent liest, fetcht, klassifiziert. Alle Schreibvorgänge auf State-Files passieren durch Main-MARVIN nach User-Confirmation. Spiegelt bestehendes Muster (`logging`/`context-refinement`).
- **Ein File pro Kanal als SSoT.** `state/channels/{channel}.md`. Kein verschachteltes Verzeichnis für MVP.
- **Per-Channel-Isolation.** Jeder Channel-Agent kennt nur seinen Kanal. Keine Cross-Channel-Logik im Subagent. Cross-Kanal-Aggregation (später) macht Main-MARVIN durch Grep über `state/channels/*.md`.
- **Orthogonal zu Project-State.** Channel-State = "Someone's waiting on me via this channel" (inbound). Project-State = längsseitiger Arc + Waiting-On (outbound). Links optional, keine Auto-Schreibungen zwischen den Layern.

### 3.2 Übersichts-Diagramm

```
┌─────────────────────────────────────────────────────────────┐
│  USER                                                        │
│  └─ /triage-slack                                            │
│        │                                                     │
│        ▼                                                     │
│  ┌──────────────────┐     ┌───────────────────────────────┐ │
│  │ MAIN MARVIN      │────▶│ SUBAGENT channel-slack        │ │
│  │ (orchestrator)   │     │ (model: sonnet, eigener ctx)  │ │
│  │                  │     │                               │ │
│  │ - spawn agent    │     │ Tools:                        │ │
│  │ - collect result │     │  - Read state/channels/..     │ │
│  │ - confirm w/ user│     │  - mcp__slack__* (read)       │ │
│  │ - write state    │◀────│  - Returns candidate list     │ │
│  │ - invoke /draft  │     └───────────────────────────────┘ │
│  └──────────────────┘                                        │
│        │                                                     │
│        ▼                                                     │
│  state/channels/slack.md  ◀── single source of truth         │
└─────────────────────────────────────────────────────────────┘
```

## 4. Komponenten (Slack-MVP)

### 4.1 Subagent-Definition: `.claude/agents/channel-slack.md`

```yaml
---
name: channel-slack
description: Triage incoming Slack DMs + mentions; classify action-needed items; detect smart-close
model: sonnet
---
```

**Inputs:**
- `state/channels/slack.md` (last_run-ts, offene Items)
- Slack MCP (`mcp__slack__*` für Read-Operationen)
- Nikolai-User-ID (aus `.env` oder im Prompt-Template)

**Responsibilities:**
1. Fetch alle **DMs an Nikolai** + **@-Mentions** seit `last_run`
2. Fetch für alle offenen Items den letzten Thread-State (hat Nikolai inzwischen geantwortet?)
3. Klassifikations-Heuristik anwenden (siehe 4.3)
4. Strukturierten Report an Main zurückgeben (Candidates + Smart-Close-Vorschläge)

**NICHT verantwortlich:** Schreiben in State, Senden, Draft-Generation.

### 4.2 Slash-Command: `.claude/commands/triage-slack.md`

```markdown
# /triage-slack

Triage offene Slack-Items.

Instructions:
1. Read state/channels/slack.md for last_run.
2. Spawn channel-slack subagent with prompt "triage since last_run".
3. Present agent's candidate list + smart-close-suggestions inline.
4. Wait for user confirmation (e.g., "✓ 1 2 3, ✗ 4 5, close 7 8").
5. Write state/channels/slack.md:
   - Confirmed candidates → Open Items (assign new IDs)
   - Smart-Close confirmations → Recently Closed (with ts)
   - Update last_run
6. Prune Recently Closed older than 7 days.
```

### 4.3 Klassifikations-Heuristik

**Flag als Action-Needed-Kandidat wenn:**
- Message ist DM an Nikolai UND letzter Beitrag von anderem User → ✓
- @-Mention Nikolai in Channel UND Nachricht enthält `?` oder Imperativ → ✓
- Thread, in dem Nikolai participated, letzter Beitrag von anderem (Message-Alter ≥ 1h) → ✓

**Re-Open-Logik:** Wenn ein Item in `Recently Closed` ist und ein neues Event (Reply, Mention) auf demselben Thread eintrifft, wird es als neuer Kandidat in `Pending Confirmation` aufgenommen. Alte closed-Historie bleibt erhalten.

**Auto-Filter (nicht als Kandidat):**
- Bot-Messages, Slack-System-Nachrichten
- Newsletter-/Broadcast-Channels
- Reaction-only (👍, ✅)
- `@here` / `@channel` Mentions (nur direkte `@Nikolai` zählen)
- Eigene (Nikolai-authored) Messages

**Pro Kandidat:** `reason`-Feld für Nachvollziehbarkeit.

**Optionale Projekt-Heuristik:** Channel-Namen (`#gomedicus-dev`) oder Keywords im Text (`Kronprinzenbau`, `Lütjensee`) gegen `ls state/projects/` matchen, als `project:`-Tag beigeben.

### 4.4 State-Schema: `state/channels/slack.md`

```markdown
---
channel: slack
last_run: 2026-04-24T16:45:00+02:00
updated: 2026-04-24
---

# Slack Channel State

## Open Items

| ID | Since | Source | Summary | Project | Link |
|----|-------|--------|---------|---------|------|
| S-042 | 2026-04-23 | DM Henry | Inventar-Tabelle Review | design-assets-rollout | slack://... |

## Pending Confirmation
_(wird bei jedem /triage-slack neu gefüllt, nach Bestätigung geleert)_

## Recently Closed (last 7 days)

| ID | Closed | Source | Resolution |
|----|--------|--------|------------|
| S-040 | 2026-04-24 16:45 | DM Jens | replied |

## Snoozed
_(optional, Phase 2+)_
```

**ID-Schema:** `S-{n}` für Slack, `G-{n}` für Gmail, `N-{n}` für Notion etc. Auto-inkrementiert (max-existing + 1), Main-MARVIN als Single Writer.

## 5. Data Flow & Lifecycle

### 5.1 Item-Lifecycle

```
Slack Event (DM, @mention, reply)
          │
          │  next /triage-slack
          ▼
Subagent klassifiziert → Pending Confirmation
          │
   ┌──────┴──────┐
 User ✗         User ✓
   │             │
 (dropped)   Open Items
                  │
        ┌─────────┴─────────┐
   Nikolai antwortet   manueller Close
   in Slack            "close S-042"
        │                  │
  Smart-Close bei     Direkt nach
  nächstem Triage     Recently Closed
        │                  │
        └────────┬─────────┘
                 ▼
        Recently Closed (7d TTL)
```

### 5.2 End-to-End (konkret)

**`/triage-slack` Flow:**

1. Main liest `last_run` aus State.
2. Main spawned `channel-slack`-Subagent mit Prompt: *"Triage since {last_run}."*
3. Subagent:
   - Fetcht neue DMs + Mentions via Slack-MCP
   - Prüft offene Items auf Smart-Close-Kandidaten
   - Klassifiziert und returnt strukturiert:
     ```
     candidates: [
       {tmp_id: "C1", source: "DM Henry", summary: "...", reason: "...", project: "..."},
       ...
     ]
     smart_close: [
       {id: "S-040", reason: "Nikolai replied at 16:45"},
       ...
     ]
     ```
4. Main zeigt inline, wartet auf Confirmation.
5. Main editiert `state/channels/slack.md`:
   - Confirmed Candidates → Open Items (neue IDs vergeben)
   - Smart-Close-Bestätigungen → Recently Closed
   - `last_run` aktualisieren
6. Main pruned Recently Closed > 7 Tage.

### 5.3 Integration mit `/draft`

Channel-Agent generiert **keine** Drafts. Draft-Flow bleibt wie bisher:

```
User:  "draft reply to S-042"
Main:  - liest S-042 aus state/channels/slack.md
       - fetcht Slack-Thread-Context via MCP
       - ruft /draft-Logik mit Channel=Slack, Target=Henry, Context=S-042
Main:  [zeigt Draft, wartet auf Review]
User:  "send"
Main:  sendet, markiert S-042 für Smart-Close (oder direkt closed, wenn explizit)
```

**Bestehende Regel (Memory):** Slack-Messages werden nie direkt gesendet. Draft-Review-Zyklus ist Pflicht.

### 5.4 Cross-Link zu Project-State

Wenn Subagent `project: design-assets-rollout` klassifiziert:
- `project`-Spalte in `state/channels/slack.md` wird gefüllt (Link zu `state/projects/design-assets-rollout.md`)
- **Keine** automatische Schreibung ins Project-File
- Optional: Project-File kann manuellen Verweis haben (`- Offene Slack-Nachfrage → state/channels/slack.md#S-042`)

## 6. Error Handling & Edge Cases

### 6.1 Error Handling

| Szenario | Behandlung |
|----------|------------|
| Slack MCP unavailable | Subagent returnt `error: mcp_unavailable`; Main zeigt Fehler, State unverändert |
| `state/channels/slack.md` fehlt | Main bootstrappt aus Template (leere Sektionen + `last_run: null`); erster Run fetcht letzte 7 Tage |
| User-Confirmation invalide | Main fragt nochmal, Pending bleibt stehen |
| Malformed Subagent-Output | Main bricht ab, `last_run` unverändert |
| Duplicate IDs | Auto-inkrement `max(existing) + 1`, Single-Writer-Modell verhindert Races |
| Smart-Close false positive | Smart-Close ist **Vorschlag**, nicht Auto-Close — User muss bestätigen |

### 6.2 Edge Cases

- **Antwort außerhalb Slack** (z.B. Telefon): Smart-Close merkt's nicht → manueller `close S-042` nötig. Akzeptabel.
- **Broadcast-Mentions** (`@here`, `@channel`): Ausgefiltert.
- **Eigene Drafts**: Nie als Kandidat.
- **Retroaktive Mentions**: Beim nächsten Triage erfasst, wenn in `last_run`-Cut-off.

## 7. Testing-Strategie

LLM-basierte Klassifikation gegen Live-MCP-Daten → klassisches Unit-Testing begrenzt sinnvoll.

1. **Dry-Run-Modus:** `/triage-slack --dry` klassifiziert, schreibt aber nicht. Nützlich zum Heuristik-Einschwingen.
2. **State-Schema-Validierung:** Checker prüft Frontmatter + Sektionen + eindeutige IDs beim Bootstrap.
3. **Manuelle Kalibrierung über ~1 Woche:** Heuristik-Prompts iterativ nachschärfen.
4. **Smart-Close-Audit:** Recently Closed behält 7 Tage Resolution-Info → false positives leicht spottbar.
5. **Erster manueller Test:** State-File mit 2–3 bekannten Items seeden, `/triage-slack` laufen lassen, Output prüfen.

Keine automatisierten CI-Tests — persönliches Tooling, Kalibrierung durch Nutzung.

## 8. Phase 2: Gmail

Gleiche Struktur, angepasste Heuristik:

- **Action-Needed:** Thread-letzte Msg von anderem, addressed to Nikolai, nicht Newsletter/Notification (List-Id-Header), nicht Auto-Reply
- **Auto-Filter:** Listen-IDs matchen gegen Newsletter-Blacklist; Auto-Generated-Header; bekannte Notification-Absender (GitHub, Stripe, etc.)
- **Volumen-Handling:** Agent zeigt bei initialer Klassifikation zuerst Top-20 Kandidaten; User kann "mehr" anfordern
- **Smart-Close:** Thread-Check, ob Nikolai seit Item-Erstellung geantwortet hat
- **ID-Schema:** `G-{n}`
- **State:** `state/channels/gmail.md`

Phase 2 wird eigene Spec bekommen, sobald Slack-MVP ~2 Wochen gelaufen ist und die Heuristik eingeschwungen ist.

## 9. Nicht im MVP (explizit Out-of-Scope)

- Scheduled Background-Runs (Cron/launchd)
- Auto-Writes in `state/projects/*.md` aus Channel-Agent
- Snooze-/Defer-Funktionalität
- `/inbox-all` Aggregator-Command über alle Kanäle
- Gmail-Label-/Slack-Reaction-Manipulation durch Agent
- Notification/Push-Integration
- Kanäle: Gmail, Calendar, Drive, Notion (kommen in späteren Phasen)

## 10. Success Criteria für den Slack-MVP

- Nach `/triage-slack` hat Nikolai eine klare Übersicht über offene Slack-Items ohne durch die Slack-UI scrollen zu müssen
- Smart-Close-Detection erkennt ≥ 80% der abgeschlossenen Items korrekt
- Klassifikations-Heuristik hat weniger als 30% false positives nach 1 Woche Nutzung
- `state/channels/slack.md` bleibt greppbar und manuell editierbar (kein Binary-Format, kein DB)
- `/triage-slack` läuft in < 30s bei typischer Tages-Last

## 11. Offene Punkte (zur Implementierungs-Zeit zu klären)

- Exakter Prompt für den `channel-slack`-Subagenten — iterativ in Phase 1 entwickeln, nach ~1 Woche Nutzung kalibrieren.
- Konkrete Auswahl der Slack-MCP-Methoden (`slack_search_users`, `slack_read_channel`, `slack_get_thread_replies`, `slack_read_thread`, ...) — in Implementation-Plan zu bestimmen, abhängig davon was MCP real liefert.
- **Rate-Limit-Default:** Wenn Slack-MCP bei einem Fetch ein Rate-Limit returnt, bricht der Subagent ab und returnt `error: rate_limited` mit `retry_after`. Main zeigt die Meldung; Triage kann nach Wartezeit erneut laufen. Keine partiellen Writes. (Kann im Plan verfeinert werden.)
- **Nikolai-User-ID-Source:** `.env`-Variable `SLACK_USER_ID` (konsistent mit bestehender `.env`-Konvention für Integrationen). Fallback auf Hardcoding nur wenn `.env`-Load im Subagent-Kontext problematisch ist.
