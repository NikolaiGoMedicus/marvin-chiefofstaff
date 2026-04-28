# Current State

Last updated: 2026-04-28 09:09

> **Modulare State-Architektur (seit 21.04.):** Details leben in `state/projects/*.md`. Diese Datei ist der Index + aktuelle Prioritäten. Für die alte Monolith-Version siehe `current.md.pre-migration`.

## Active Priorities

1. **AI Services Rollout** — Antonia-Call 22.04. ✅. Follow-up 23.04. 15:30 "Workflow-Konkretisierung" noch heute. Linear-Epic "Operations Reporting" + T2 Form next. → [projects/ai-services-rollout.md](projects/ai-services-rollout.md)
2. **GoMedicus Platform & MVP** — ⚠️ Muss live. Practice Management Redesign + GOM-2862/2863 (Urgent) dominieren Dev. GOM-1976 Notification Events: waiting on Cloudnonic review. → [projects/gomedicus-platform.md](projects/gomedicus-platform.md)
3. **Kronprinzenbau IT-Planung** — 🔴 Deadline 18.04. bei Michael überfällig. Angebot bis 15.05. → [projects/kronprinzenbau.md](projects/kronprinzenbau.md)
4. **Lütjensee** — Go-Live Juli. Lambda-Nachverhandlung 49,7k → 25-30k läuft. → [projects/luetjensee.md](projects/luetjensee.md)
5. **GoMedicus Kids — Tomedo-Migration** — PaeDoc-Umstellung ca. Ende August 2026 (Datum offen, Flo-Stand 27.04.). KW 19 Bisingen-Timeline prüfen. → [projects/gomedicus-kids.md](projects/gomedicus-kids.md)
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
- [GOM-2530 MCP Server PoC](projects/gom-mcp-poc.md) — Adriano PR #819 getestet (27.04.), smoke test OK. Warte auf Nikolai-Entscheidung re Feedback.
- [Privat](projects/privat.md) — Strom, Solar, Karriere, Claudio, Meshtastic, Flipper, Laser Forge

## Outbox

_Drafts, die auf Absenden warten. Drafts landen hier durch `/draft park`, werden durch `/draft send` rausgeschickt._

| # | Ziel | Thema | Ort |
|---|------|-------|-----|
| 1 | Flo Kleinau (f.kleinau@gomedicusgroup.com) | IT Operations Manager – Praxis-IT: Fazit zu den 3 aktiven Bewerbungen | Gmail Draft `r-4148311281209141750` |
| 2 | Arved Schneider (a.schneider@gomedicusgroup.com) | Claude AI @ GoMedicus — Kurz-Briefing für dein Debrief | Gmail Draft `r2985519939217385353` |
| 3 | Flo Kleinau (f.kleinau@gomedicusgroup.com) | Kennedy Chikaodili Idoko — Pre-Screening-Aufgabe | Draft fertig (24.04.), noch nicht als Gmail Draft angelegt — Nikolai entscheidet |
| 4 | Henry Krause (Slack DM) | Design-Assets Inventar — Bitte um Co-Füllung der ❓-Zeilen | Copy-Paste-Text bereitgestellt (Session 24.04.) — Widget-Draft unsichtbar, Nikolai sendet manuell |
## Stale Threads (>14 Tage ohne Bewegung)

_Keine aktiven Stale Threads. Aufgeräumt 21.04._

## Today's Focus / Notes

- **Janina-Termin neu gesetzt: Di 28.04. 13:00–13:50** (nach Ausfall 22.04. + Ablehnung 27.04.). Meet `kxv-bsqh-tdf`. Slot ist tight: Nima endet 13:00 → Janina → Claude×Antonia 14:00.
- **⚠️ Konflikt morgen Di 28.04. 11:00 (Arved AI Sync) vs. 11:30 (JF | GoM x ak)** — noch nicht aufgelöst.
- **🟠 OKR-Finalisierungs-Meeting 24.04. mit Jens + Tim-Ole — noch nachzubereiten.** Action Items → [ai-systems-office.md](projects/ai-systems-office.md). Transcript: [Google Doc](https://docs.google.com/document/d/19vdjk7lEBwYzxPO4Hra_FNddUlUf0mR1vSiSA53JFL4/edit).
- **Outbox-Drafts pending (4):** Flo Hiring-Fazit, Arved Claude-Briefing, Kennedy Pre-Screening (noch kein Gmail-Draft), Henry Inventar-Bitte (Slack DM) — warten auf Nikolai-Freigabe.
- **Design-Assets Rollout:** Nils-Angebot 24.04. (2.945–4.560 €). Warte auf Michael+Flo Mengen-Klärung → dann Mail an Nils. Details in [design-assets-rollout.md](projects/design-assets-rollout.md).
