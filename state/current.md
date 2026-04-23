# Current State

Last updated: 2026-04-23 11:34

> **Modulare State-Architektur (seit 21.04.):** Details leben in `state/projects/*.md`. Diese Datei ist der Index + aktuelle Prioritäten. Für die alte Monolith-Version siehe `current.md.pre-migration`.

## Active Priorities

1. **AI Services Rollout** — Antonia-Call 22.04. ✅. Follow-up 23.04. 15:30 "Workflow-Konkretisierung" noch heute. Linear-Epic "Operations Reporting" + T2 Form next. → [projects/ai-services-rollout.md](projects/ai-services-rollout.md)
2. **GoMedicus Platform & MVP** — ⚠️ Muss live. Practice Management Redesign + GOM-2862/2863 (Urgent) dominieren Dev. GOM-1976 Notification Events: waiting on Cloudnonic review. → [projects/gomedicus-platform.md](projects/gomedicus-platform.md)
3. **Kronprinzenbau IT-Planung** — 🔴 Deadline 18.04. bei Michael überfällig. Angebot bis 15.05. → [projects/kronprinzenbau.md](projects/kronprinzenbau.md)
4. **Lütjensee** — Go-Live Juli. Lambda-Nachverhandlung 49,7k → 25-30k läuft. → [projects/luetjensee.md](projects/luetjensee.md)
5. **GoMedicus Kids — Tomedo-Migration** — PaeDoc-Umstellung fixiert 13.08.2026. KW 19 Bisingen-Timeline prüfen. → [projects/gomedicus-kids.md](projects/gomedicus-kids.md)
6. **AI & Systems Office (Jens-Deliverables)** — 30-60-90 + Hiring IT Ops Lead. → [projects/ai-systems-office.md](projects/ai-systems-office.md)
7. **Series A Tech DD** — 🔴 IP-Transfer Cloudnonic blockt LOI. → [projects/series-a-dd.md](projects/series-a-dd.md)

## Secondary / laufend

- [GoMedicus Practices (paeDOC)](projects/gomedicus-practices.md)
- [MKD Integration Roadmap](projects/mkd-integration.md) · [MKD Hardware](projects/mkd-hardware.md)
- [Claude Design Setup](projects/claude-design-setup.md) · [Brand University](projects/brand-university.md)
- [M&A Pipeline](projects/ma-pipeline.md)
- [LMS / EdApp-Ersatz](projects/lms-edapp-ersatz.md)
- [MFA Onboarding Guide](projects/mfa-onboarding-guide.md) · [People / Onboarding](projects/people-onboarding.md) · [Alice Offboarding](projects/alice-offboarding.md)
- [BDT Export/Import](projects/bdt-export.md) · [Email Templates — siehe GoMedicus Platform](projects/gomedicus-platform.md)
- [Antragswesen](projects/antragswesen.md) — GitHub GoMedicus/antragswesen (privat), Notion unter AI & Systems Office. MVP + Scope noch offen.
- [Pipedrive MCP](projects/pipedrive-mcp.md) · [Slack MCP](projects/slack-mcp.md) · [MARVIN Infrastructure](projects/marvin-infrastructure.md)
- [Telefon AI Agent](projects/telefon-ai-agent.md) · [Tomedo CUA Agent](projects/tomedo-cua-agent.md) · [Tomedo Exploration](projects/tomedo-exploration.md) · [Voice Onboarding](projects/voice-onboarding.md)
- [Starface](projects/starface.md) · [Doc Cirrus](projects/doc-cirrus.md) · [Hardware-Standards](projects/hardware-standards.md)
- [QM Handbuch](projects/qm-handbuch.md) · [Notion Konsolidierung](projects/notion-konsolidierung.md) · [Reporting](projects/reporting.md)
- [Website](projects/website.md) · [Design-Assets Rollout (Lüt/KB/Kids)](projects/design-assets-rollout.md) · [Lütjensee Designer-Brief (superseded)](projects/luetjensee-designer-brief.md)
- [Claude Admin / Lizenzmanagement](projects/claude-admin.md) — Pricing, Jahresplan-Hebel, Arved-Debrief (23.04.)
- [Platform Analytics & Session Recording](projects/platform-analytics.md) — 3-Phasen-Strategie (Plausible → Matomo → PostHog). PostHog-Empfehlung zurückgezogen (DSGVO). Phase 1 (Plausible Event-Spec) läuft.
- [Privat](projects/privat.md) — Strom, Solar, Karriere, Claudio, Meshtastic, Flipper, Laser Forge

## Outbox

_Drafts, die auf Absenden warten. Drafts landen hier durch `/draft park`, werden durch `/draft send` rausgeschickt._

| # | Ziel | Thema | Ort |
|---|------|-------|-----|
| 1 | Flo Kleinau (f.kleinau@gomedicusgroup.com) | IT Operations Manager – Praxis-IT: Fazit zu den 3 aktiven Bewerbungen | Gmail Draft `r-4148311281209141750` |
| 2 | Paul Gonser (p.gonser@gomedicusgroup.com) | Antragswesen | Gmail Draft `r-195552586130492000` |
| 3 | Arved Schneider (a.schneider@gomedicusgroup.com) | Claude AI @ GoMedicus — Kurz-Briefing für dein Debrief | Gmail Draft `r2985519939217385353` |

## Stale Threads (>14 Tage ohne Bewegung)

_Keine aktiven Stale Threads. Aufgeräumt 21.04._

## Today's Focus / Notes

- **23.04. Vormittag:** Claude Admin/Arved-Briefing-Draft ✅, Meeting-Prep 10:30 Tim-Ole + Jens ✅ (3-Phasen-Analytics-Modell, Claude Skills, Notion Intranet). Details in [claude-admin.md](projects/claude-admin.md) + [platform-analytics.md](projects/platform-analytics.md).
- **23.04. Mittag — Tomedo DB Discovery für Arveds Auslastungs-Reporting** ✅. `besuch`-Tabelle = Tomedo-Tagesliste (nicht `termin`). Arveds 14-Tage-Zahlen matchen DB ±1 pro Zeile. Entity-Doc + 2 Reusable-Queries (`auslastung-taegliche-besuche.sql`, `auslastung-stunden-heatmap.sql`) committed + pushed (commit `16a7ff2`). [Diskussions-Sheet für Arved + Sebastian Schulz](https://docs.google.com/spreadsheets/d/1fDMAiVdROwkzW4vzXQXLboFDpp8aAwM_FCVVo3WcE-U/edit) mit 7 Tabs erstellt. Details in [tomedo-exploration.md](projects/tomedo-exploration.md). Offen: Scope-Call mit Arved+Sebastian (DB-only Phase 1 vs. Personio parallel).
- **Antonia Follow-up 15:30** steht noch aus — Prep-Doc v2 bereit: [Google Doc](https://docs.google.com/document/d/1SJUJWtctbN5CMHsss9IhT87uAkK70ttaPDL5u7YBiek/edit). Nach Call: Linear-Epic "Operations Reporting" anlegen.
- **Outbox-Drafts pending:** Flo Hiring-Fazit, Antragswesen Paul, Arved Claude-Briefing — alle warten auf Nikolai-Freigabe.
- **Offene Praxis-Threads:** Tomedo-Praxisfragebogen (Nikolai füllt Lücken, paeDOC Standort 3 klären Fellbach vs. Rangendingen), Lambda Tickets warten auf Antwort.
