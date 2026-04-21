# Current State

Last updated: 2026-04-21 11:30

> **Modulare State-Architektur (seit 21.04.):** Details leben in `state/projects/*.md`. Diese Datei ist der Index + aktuelle Prioritäten. Für die alte Monolith-Version siehe `current.md.pre-migration`.

## Active Priorities

1. **AI Services Rollout** — T2 Form heute an Basti+Jens raus; Antonia Check-in morgen. → [projects/ai-services-rollout.md](projects/ai-services-rollout.md)
2. **GoMedicus Platform & MVP** — ⚠️ Muss live. GOM-2335 + GOM-1977 Staging→Prod offen. → [projects/gomedicus-platform.md](projects/gomedicus-platform.md)
3. **Kronprinzenbau IT-Planung** — 🔴 Deadline 18.04. bei Michael überfällig. Angebot bis 15.05. → [projects/kronprinzenbau.md](projects/kronprinzenbau.md)
4. **Lütjensee** — Go-Live Juli. Lambda-Nachverhandlung 49,7k → 25-30k läuft. → [projects/luetjensee.md](projects/luetjensee.md)
5. **GoMedicus Kids — Tomedo-Migration** — Bisingen KW 19 Produktivumstellung. → [projects/gomedicus-kids.md](projects/gomedicus-kids.md)
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
- [Pipedrive MCP](projects/pipedrive-mcp.md) · [Slack MCP](projects/slack-mcp.md) · [MARVIN Infrastructure](projects/marvin-infrastructure.md)
- [Telefon AI Agent](projects/telefon-ai-agent.md) · [Tomedo CUA Agent](projects/tomedo-cua-agent.md) · [Voice Onboarding](projects/voice-onboarding.md)
- [Starface](projects/starface.md) · [Doc Cirrus](projects/doc-cirrus.md) · [Hardware-Standards](projects/hardware-standards.md)
- [QM Handbuch](projects/qm-handbuch.md) · [Notion Konsolidierung](projects/notion-konsolidierung.md) · [Reporting](projects/reporting.md)
- [Website](projects/website.md) · [Lütjensee Designer-Brief](projects/luetjensee-designer-brief.md)
- [Privat](projects/privat.md) — Strom, Solar, Karriere, Claudio, Meshtastic, Flipper

## Outbox

_Drafts, die auf Absenden warten. Drafts landen hier durch `/draft park`, werden durch `/draft send` rausgeschickt._

| # | Ziel | Thema | Ort |
|---|------|-------|-----|
| _leer — nach Migration 21.04._ | | | |

## Stale Threads (>14 Tage ohne Bewegung)

Basis: letzte Sichtung in Session-Logs. Top-Kandidaten:

- **Philipp Gonser** — ZDS Bürosysteme Feedback (last: 05.02., 75 Tage) → [luetjensee.md Waiting On](projects/luetjensee.md)
- **Olaf Rajek** — IP→Sprechzimmer Mapping (last: 12.03., 40 Tage) → [luetjensee.md Waiting On](projects/luetjensee.md)
- **Friederike** — Tomedo-Import-Test (3108/4111/3110) (last: 13.03., 39 Tage) → [luetjensee.md Waiting On](projects/luetjensee.md)
- **Doc Cirrus** — Präsentationstermin bei Isabell (last: vor 27.03.) → [doc-cirrus.md](projects/doc-cirrus.md)

## Today's Focus / Notes

- **Claude Design** Onboarding läuft, Token-Validation und Test-Prompt Lütjensee stehen als nächstes → [claude-design-setup.md](projects/claude-design-setup.md).
- MARVIN-Refactor 21.04.: State modularisiert, Stop-Hook entfernt, /end + /update parallelisiert. Neue Struktur siehe `CLAUDE.md` Architecture-Sektion + [marvin-infrastructure.md](projects/marvin-infrastructure.md).
