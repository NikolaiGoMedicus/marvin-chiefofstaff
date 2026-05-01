---
project: marvin-infrastructure
status: active
owner: nikolai
updated: 2026-05-01
tags: [work, marvin, infrastructure]
---

# MARVIN Infrastructure

## Status

- **Major Refactor 21.04.2026 (Vormittag/Mittag):** State-Architektur von monolithischer `current.md` auf modulare Struktur (`current.md` = Index, `state/projects/*.md` = Details) migriert. Stop-Hook entfernt, Auto-Sync auf `/end` + `/commit` + nightly launchd konsolidiert, logging + context-refinement Agents parallelisiert. Commit `1ddacca`.
- **GitHub Repo:** [NikolaiGoMedicus/marvin-chiefofstaff](https://github.com/NikolaiGoMedicus/marvin-chiefofstaff) (private). Erster Push 16.04.
- **Auto-Sync (neu ab 21.04.):** Commit + Push nur noch bei `/end` und `/commit`. Nightly Safety Net via launchd um 23:00 (`com.marvin.nightly-sync`). Stop-Hook entfernt.
- **Hooks (aktiv):** PreCompact (auto-save vor Komprimierung), PostToolUse (QMD reindex), PreToolUse (Vault frontmatter check).
- **Hooks (deaktiviert):** Stop-Hook `auto-checkpoint.sh` — Datei bleibt, aber nicht mehr im Hook-Config referenziert.
- **UI:** Flicker-Free aktiviert (`CLAUDE_CODE_NO_FLICKER=1`), TUI fullscreen.
- **Agents:** logging + context-refinement agents laufen parallel bei `/end` (ab 21.04.).
- **State:** Modulare Struktur mit current.md als Index + state/projects/*.md (ab 21.04.).

## Channel-Agents Slack MVP (24.04.2026)

- **Shipped:** Channel-Agents Layer — neue Architektur-Ebene `state/channels/` zwischen Slack und MARVIN.
- **state/channels/slack.md:** Persistenter Inbox-State fur Slack-Triage. S-001 (erste Session) bereits abgeschlossen.
- **Subagent:** `.claude/agents/channel-slack.md` — spezialisierter Agent fur Slack-Inbox-Verarbeitung (liest Channels, Threads, draftet Antworten, updated state/channels/slack.md).
- **Command:** `/triage-slack` — neuer Slash-Command; ruft channel-slack Subagent auf, gibt strukturiertes Triage-Resultat zuruck.
- **CLAUDE.md:** Channel-Agents Layer + state/channels/ Konvention dokumentiert.
- **Spec + Plan:** `docs/superpowers/channel-agents-spec.md` + `docs/superpowers/channel-agents-plan.md` angelegt.
- **Status:** MVP live. Nachste Schritte: channel-email (Gmail), Channel-Index in current.md bei Bedarf erganzen.

## Channel-Agents Slack MVP — Calibration Round 1 (01.05.2026)

- **Datum:** 2026-05-01 (scheduled calibration agent, Task 7 des Slack-MVP-Plans)
- **Zeitraum:** 2026-04-24 bis 2026-05-01 (Woche 1 nach Ship)
- **Aktivität:** 1 triage-slack Live-Run (2026-04-28). 0 Action-Needed-Kandidaten. 0 False-Positives oder Misses gemeldet. Sessions 2026-04-25 + 04-26 fehlen.
- **Schlüsselbefund — DM-Gap:** `slack_list_channels` gibt keine privaten DMs zurück → DM-Workflow in Agent-Step 2 war stillschweigend nicht-funktional. Jetzt explizit mit Error-Reporting-Verhalten dokumentiert.
- **Heuristik-Änderungen:** Nur DM-Gap-Dokumentation. Keine Regel-Änderungen (zu wenig Signal für breites Tuning).
- **PR:** `feat/channel-slack-calibration-1` — offen für Nikolais Review.
- **Nächste Kalibrierung:** Round 2 nach ≥3 weiteren Live-Runs oder erstem gemeldeten False-Positive/Miss.

## Channel-Agents Gmail MVP (28.04.2026)

- **Spec:** `docs/superpowers/specs/2026-04-28-channel-agents-gmail-phase2-design.md`
- **Plan:** `docs/superpowers/plans/2026-04-29-channel-agents-gmail-mvp.md`
- **Branch:** `feat/channel-gmail-mvp` (9 Commits)
- **Status:** Tasks 0, 1, 2, 3, 9 done. Tasks 4–8 + 10 (live testing) noch offen — User testet selbst.
- **Gebaute Files:** env vars, `state/channels/gmail.md` Template, `.claude/agents/channel-gmail.md` Subagent, `/triage-gmail` Command, CLAUDE.md Doku (inkl. Code-Review-Refinements).

## Routines (Cloud)

- [ ] Morning Briefing Routine — erstellt, Google Workspace Connector noch aktivieren, testen
- [ ] Weekly Report Routine — Prompt ready, noch nicht angelegt
- [ ] Routines nach Test scharfschalten
