# Current State

Last updated: 2026-04-30 08:29

> **Modulare State-Architektur (seit 21.04.):** Details leben in `state/projects/*.md`. Diese Datei ist der Index + aktuelle Prioritäten. Für die alte Monolith-Version siehe `current.md.pre-migration`.

## Active Priorities

1. **AI Services Rollout** — Antonia-Call 22.04. ✅. Follow-up 23.04. 15:30 "Workflow-Konkretisierung" noch heute. Linear-Epic "Operations Reporting" + T2 Form next. → [projects/ai-services-rollout.md](projects/ai-services-rollout.md)
2. **GoMedicus Platform & MVP** — ⚠️ Muss live. Practice Management Redesign + GOM-2862/2863 (Urgent) dominieren Dev. GOM-1976 Notification Events: waiting on Cloudnonic review. → [projects/gomedicus-platform.md](projects/gomedicus-platform.md)
3. **Kronprinzenbau IT-Planung** — 🔴 Deadline 18.04. bei Michael überfällig. Angebot bis 15.05. → [projects/kronprinzenbau.md](projects/kronprinzenbau.md)
4. **Lütjensee** — Go-Live Juli. Lambda-Nachverhandlung 49,7k → 25-30k läuft. → [projects/luetjensee.md](projects/luetjensee.md)
5. **GoMedicus Kids — Tomedo-Migration** — PaeDoc-Umstellung **ca. September 2026** (Jan-Stand 28.04., nach Borkum-Messe). Jan braucht Server-Zugänge **alle 3 Standorte** (nicht nur Bisingen). → [projects/gomedicus-kids.md](projects/gomedicus-kids.md)
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
- [Antragswesen](projects/antragswesen.md) — Bundle-aware Architektur fertig (28.04.). Aktueller Allgemeinmed-Antrag: 13 Gaps offen + Trägerstruktur-Klärung (3 MVZs entdeckt) bei Phil.
- [Pipedrive MCP](projects/pipedrive-mcp.md) · [Slack MCP](projects/slack-mcp.md) · [MARVIN Infrastructure](projects/marvin-infrastructure.md)
- [Telefon AI Agent](projects/telefon-ai-agent.md) · [Tomedo CUA Agent](projects/tomedo-cua-agent.md) · [Tomedo Exploration](projects/tomedo-exploration.md) · [Voice Onboarding](projects/voice-onboarding.md)
- [Starface](projects/starface.md) · [Doc Cirrus](projects/doc-cirrus.md) · [Hardware-Standards](projects/hardware-standards.md)
- [QM Handbuch](projects/qm-handbuch.md) · [Notion Konsolidierung](projects/notion-konsolidierung.md) · [Reporting](projects/reporting.md)
- [Website](projects/website.md) · [Design-Assets Rollout (Lüt/KB/Kids)](projects/design-assets-rollout.md) · [Lütjensee Designer-Brief (superseded)](projects/luetjensee-designer-brief.md)
- [Claude Admin / Lizenzmanagement](projects/claude-admin.md) — Pricing, Jahresplan-Hebel, Arved-Debrief (23.04.)
- [Platform Analytics & Session Recording](projects/platform-analytics.md) — 3-Phasen-Strategie (Plausible → Matomo → PostHog). PostHog-Empfehlung zurückgezogen (DSGVO). Phase 1 (Plausible Event-Spec) läuft.
- [GOM-2530 MCP Server PoC](projects/gom-mcp-poc.md) — Adriano PR #819 getestet (27.04.), smoke test OK. Warte auf Nikolai-Entscheidung re Feedback.
- [Privat](projects/privat.md) — Strom, Solar, Karriere, Claudio, Meshtastic, Flipper, Laser Forge · [Adobe Bewerbung](projects/adobe.md) — Unterlagen komplett uberarbeitet (Forest Green Tech-Editorial Mono CI, de-AI-fied, Speaking-Sektion). Nachster Schritt: Julian Kramer (Adobe-intern) Pre-Flight + Referral-Push, dann Submit R167792.

## Outbox

_Drafts, die auf Absenden warten. Drafts landen hier durch `/draft park`, werden durch `/draft send` rausgeschickt._

| # | Ziel | Thema | Ort |
|---|------|-------|-----|
| 1 | Antonia Gebhardt + Benjamin Heinke (Group-DM) | Doctolib-Connector PVS-Bridge — Architektur-Input + Build-vs-Buy-Entscheidung | Slack Group-DM |
## Stale Threads (>14 Tage ohne Bewegung)

_Aktiv zu beobachten:_
- **Lambda — VSS-Terminbuchungs-Fehler paeDOC** (Ticket 28.04.) — Antwort von support@lambda-itsystems.de ausstehend. Staleness-Check wenn keine Antwort bis ~12.05.

## Today's Focus / Notes

- **Janina-Termin neu gesetzt: Di 28.04. 13:00–13:50** (nach Ausfall 22.04. + Ablehnung 27.04.). Meet `kxv-bsqh-tdf`. Slot ist tight: Nima endet 13:00 → Janina → Claude×Antonia 14:00.
- **⚠️ Konflikt morgen Di 28.04. 11:00 (Arved AI Sync) vs. 11:30 (JF | GoM x ak)** — noch nicht aufgelöst.
- **🟠 OKR-Finalisierungs-Meeting 24.04. mit Jens + Tim-Ole — noch nachzubereiten.** Action Items → [ai-systems-office.md](projects/ai-systems-office.md). Transcript: [Google Doc](https://docs.google.com/document/d/19vdjk7lEBwYzxPO4Hra_FNddUlUf0mR1vSiSA53JFL4/edit).
- **Pipedrive Begrüßung-Backfill (28.04.) ✅:** Stufe 1 durch — 1.373 Personen in offenen Deals deterministisch via Anrede-Mapping gefüllt (637 Herr / 736 Frau). 0 Errors, alle verifiziert. Rollback-Daten in `/tmp/pipedrive_recon/`. Datenqualitäts-Finding: ~67% der "Personen" in offenen Deals sind eigentlich Einrichtungen → CRM-Bereinigung wäre größerer Hebel als Stufe 2. Details: [pipedrive-mcp.md](projects/pipedrive-mcp.md).
- **Janina Pipedrive-MCP-Setup (28.04.):** Live. Problem war fehlender Node — Homebrew + Node installiert, `npx` unter `/opt/homebrew/bin/npx`, absoluten Pfad in `claude_desktop_config.json` eingetragen. Eigener API-Token gesetzt.
- **Antragswesen Tool-Refactor (28.04.):** Aus One-Shot wurde Bundle-aware. 9 Standorte, 5 Person-YAMLs erweitert, render.py + Templates angepasst. 20 → 13 Gaps. Web-Recherche auf gomedicus.com hat Adressen + Tel für 8 Praxen geliefert. Strukturelle Korrektur: Träger ist "Go-medicus Zollernalb MVZ GmbH" (3 MVZs), nicht "MVZ GoMedicus Südwest GmbH".
- **Design-Assets Rollout:** Nils-Angebot 24.04. (2.945–4.560 €). Warte auf Michael+Flo Mengen-Klärung → dann Mail an Nils. Details in [design-assets-rollout.md](projects/design-assets-rollout.md).
- **Kronprinzenbau (28.04.):** Bauplan 3.OG von Michael bekommen, in Drive + Notion abgelegt. An Jan Kreimeyer (Lambda) verschickt mit WLAN-Coverage- + Notion-Zugriff-Frage. Deadline 30.04. hängt an seiner Antwort.
- **Gmail-MVP (28.04.):** Spec + Plan + 5 von 10 Tasks gebaut (Branch `feat/channel-gmail-mvp`). Tasks 4–8 + 10 (live testing) offen. → [marvin-infrastructure.md](projects/marvin-infrastructure.md)
