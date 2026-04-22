# Current State

Last updated: 2026-04-22 23:15

> **Modulare State-Architektur (seit 21.04.):** Details leben in `state/projects/*.md`. Diese Datei ist der Index + aktuelle Prioritäten. Für die alte Monolith-Version siehe `current.md.pre-migration`.

## Active Priorities

1. **AI Services Rollout** — Antonia-Call 22.04. ✅. Follow-up 23.04. 15:30 "Workflow-Konkretisierung" geplant (Prep: 4 Ziel-Docs). Linear-Epic "Operations Reporting" + T2 Form next. → [projects/ai-services-rollout.md](projects/ai-services-rollout.md)
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
- [Privat](projects/privat.md) — Strom, Solar, Karriere, Claudio, Meshtastic, Flipper, Laser Forge

## Outbox

_Drafts, die auf Absenden warten. Drafts landen hier durch `/draft park`, werden durch `/draft send` rausgeschickt._

| # | Ziel | Thema | Ort |
|---|------|-------|-----|
| 1 | Flo Kleinau (f.kleinau@gomedicusgroup.com) | IT Operations Manager – Praxis-IT: Fazit zu den 3 aktiven Bewerbungen | Gmail Draft `r-4148311281209141750` |
| 2 | Paul Gonser (p.gonser@gomedicusgroup.com) | Antragswesen | Gmail Draft `r-195552586130492000` |

## Stale Threads (>14 Tage ohne Bewegung)

_Keine aktiven Stale Threads. Aufgeräumt 21.04._

## Today's Focus / Notes

- Antonia AI Check-in 22.04.: Prep-Session abgeschlossen. Antonias Reporting-Sheet analysiert (4 Prozesse × 4 Horizonte + 5 offene Fragen). Sechs Hebel + Call-Struktur erarbeitet. Details in ai-services-rollout.md.
- Zanadio-Workflow als Agent-Demo-Kandidat identifiziert (ersetzt künstlichen Demo für Basti/Henry/Jens).
- Antonia-Call-Commitments noch pending — linear-Epic "Operations Reporting" anlegen nach Call.
- Lambda Support-Tickets (22.04.) raus: (1) Tunnelblick DNS-Warnung `fmichels` (Franziska, unkritisch — Tomedo-Connection ok, Einschätzung erbeten); (2) Neuer VPN-Zugang Benjamin Heinke für read-only Tomedo-DB (Scope-Fragen offen, Lütjensee als Start vorgeschlagen). Beide an support@lambda-itsystems.de + Paul Epple CC. → warten auf Antwort, ggf. nach 2-3 Tagen nachhaken.
- Nils Graßmann (Style & Grace) Follow-up gesendet (22.04.): komplette Asset-Link-Liste nachgereicht, da Original-Sharing-Notifications 21.04. offenbar nicht ankamen. Angebot weiterhin bis ~05.05. erwartet.
- Tomedo Exploration M0-M5 ✅ (22.04., ~2h): Greenfield-Repo + private GitHub, read-only DB-Zugang, 2314 Tabellen, 11 Entity-Docs, 3 Reusable-Queries für Antonia. Details in [tomedo-exploration.md](projects/tomedo-exploration.md). Next: Queries an Antonia + Linear-Epic "Operations Reporting".
- Hiring IT Ops Manager Triage (22.04. Abend): 12 Bewerbungen, 9 rejected, 3 aktiv. Nikolai-Favorit: Malekkhouyan (moderner Stack, Entwicklungspotential). Lakhani → Absage vorgesehen. Crumbach → Flos Meinung abwarten. Fazit-Mail an Flo als Gmail-Draft geparkt. Details in [ai-systems-office.md](projects/ai-systems-office.md).
- **Tomedo® Praxisfragebogen** (22.04. 17:30): Maria Schweinitz (zollsoft) will Fragebogen zweimal ausgefüllt — paeDOC + Hausarztzentrum Lütjensee (Flo forwarded, Gmail `19db55bd6bb20c87`). Konsolidierter Draft in Notion: [🧾 Tomedo® Praxisfragebogen — Drafts](https://www.notion.so/34a57538249e81ba88b2d463cb9fc1d6) (Parent: Praxis-IT Rollout). Lütjensee ~70%, paeDOC ~50% vorbefüllt. Modul-Tabellen (15 Module/Praxis) mit Empfehlungen. ⚠️ Diskrepanz: paeDOC Standort 3 = Fellbach (current.md) vs. Rangendingen (DD-Architekturdoc) — klären. Next: Nikolai füllt Lücken + Module, dann Transfer in Asana-Form.
