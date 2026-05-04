# Current State

Last updated: 2026-05-04 15:14

> **Modulare State-Architektur (seit 21.04.):** Details leben in `state/projects/*.md`. Diese Datei ist der Index + aktuelle Prioritäten. Für die alte Monolith-Version siehe `current.md.pre-migration`.

## Active Priorities

1. **AI Services Rollout** — Antonia-Call 22.04. ✅. Follow-up 23.04. 15:30 "Workflow-Konkretisierung" noch heute. Linear-Epic "Operations Reporting" + T2 Form next. → [projects/ai-services-rollout.md](projects/ai-services-rollout.md)
2. **GoMedicus Platform & MVP** — ⚠️ Muss live. Practice Management Redesign + GOM-2862/2863 (Urgent) dominieren Dev. GOM-1976 Notification Events: waiting on Cloudnonic review. → [projects/gomedicus-platform.md](projects/gomedicus-platform.md)
3. **Kronprinzenbau IT-Planung** — 🔴 Deadline 18.04. bei Michael überfällig. Angebot bis 15.05. → [projects/kronprinzenbau.md](projects/kronprinzenbau.md)
4. **Lütjensee** — Go-Live Juli. Lambda-Nachverhandlung 49,7k → 25-30k läuft. → [projects/luetjensee.md](projects/luetjensee.md)
5. **GoMedicus Kids — Tomedo-Migration** — PaeDoc-Umstellung **ca. September 2026** (Jan-Stand 28.04., nach Borkum-Messe). Jan braucht Server-Zugänge **alle 3 Standorte** (nicht nur Bisingen). → [projects/gomedicus-kids.md](projects/gomedicus-kids.md)
6. **AI & Systems Office (Jens-Deliverables)** — 30-60-90 + Hiring IT Ops Lead. → [projects/ai-systems-office.md](projects/ai-systems-office.md)
7. **Series A Tech DD** — 🔴 IP-Transfer Cloudnonic blockt LOI. → [projects/series-a-dd.md](projects/series-a-dd.md)

- [Pflegeheim-Scraper AOK-Webinar](projects/pflegeheim-scraper-aok.md) — ⏳ waiting: Liste an Sebastian 04.05. 13:46. Frau Oldenburg Versand 05.05., Webinar 19.05.

## Secondary / laufend

- [GoMedicus Practices (paeDOC)](projects/gomedicus-practices.md)
- [MKD Integration Roadmap](projects/mkd-integration.md) · [MKD Hardware](projects/mkd-hardware.md)
- [Claude Design Setup](projects/claude-design-setup.md) · [Brand University](projects/brand-university.md)
- [M&A Pipeline](projects/ma-pipeline.md)
- [LMS / EdApp-Ersatz](projects/lms-edapp-ersatz.md) — Decision-Doc refreshed 30.04. DSB-Constraint gelockert. Empfehlung: TalentLMS Pro. Top 3: TalentLMS Pro / Coassemble / 360Learning. Entscheidung mit Arved + Flo ausstehend.
- [MFA Onboarding Guide](projects/mfa-onboarding-guide.md) · [People / Onboarding](projects/people-onboarding.md) · [Alice Offboarding](projects/alice-offboarding.md)
- [BDT Export/Import](projects/bdt-export.md) · [Email Templates — siehe GoMedicus Platform](projects/gomedicus-platform.md)
- [ak/Takeda — SharePoint Report](projects/ak-takeda.md) — Editor-Rechte-Approach via Friederike-Pattern. Klärung + Update an Steffi offen.
- [Antragswesen](projects/antragswesen.md) — Bundle-aware Architektur fertig (28.04.). Aktueller Allgemeinmed-Antrag: 13 Gaps offen + Trägerstruktur-Klärung (3 MVZs entdeckt) bei Phil.
- [Pipedrive MCP](projects/pipedrive-mcp.md) · [Slack MCP](projects/slack-mcp.md) · [MARVIN Infrastructure](projects/marvin-infrastructure.md)
- [Telefon AI Agent](projects/telefon-ai-agent.md) · [Tomedo CUA Agent](projects/tomedo-cua-agent.md) · [Tomedo Exploration](projects/tomedo-exploration.md) · [Voice Onboarding](projects/voice-onboarding.md)
- [Starface](projects/starface.md) · [Doc Cirrus](projects/doc-cirrus.md) · [Hardware-Standards](projects/hardware-standards.md)
- [QM Handbuch](projects/qm-handbuch.md) · [Notion Konsolidierung](projects/notion-konsolidierung.md) · [Reporting](projects/reporting.md)
- [Website](projects/website.md) · [Design-Assets Rollout (Lüt/KB/Kids)](projects/design-assets-rollout.md) · [Lütjensee Designer-Brief (superseded)](projects/luetjensee-designer-brief.md)
- [Claude Admin / Lizenzmanagement](projects/claude-admin.md) — Pricing, Jahresplan-Hebel, Arved-Debrief (23.04.)
- [Platform Analytics & Session Recording](projects/platform-analytics.md) — 3-Phasen-Strategie (Plausible → Matomo → PostHog). PostHog-Empfehlung zurückgezogen (DSGVO). Phase 1 (Plausible Event-Spec) läuft.
- [GOM-2530 MCP Server PoC](projects/gom-mcp-poc.md) — Adriano PR #819 getestet (27.04.), smoke test OK. Jens-Handoff-Doc erstellt (30.04.). Warte auf Nikolai-Entscheidung: Feedback an Adriano + ob/wann Doc mit Jens teilen.
- [Privat](projects/privat.md) — Strom, Solar, Karriere, Claudio, Meshtastic, Flipper, Laser Forge · [Adobe Bewerbung](projects/adobe.md) — Unterlagen komplett uberarbeitet (Forest Green Tech-Editorial Mono CI, de-AI-fied, Speaking-Sektion). Nachster Schritt: Julian Kramer (Adobe-intern) Pre-Flight + Referral-Push, dann Submit R167792.
- [**Serviceplan — Brüll-Gespräch Mi 06.05. 09:00**](projects/serviceplan.md) — 🔴 Nächste Runde mit Matthias Brüll (Vorstand Holding / Global CEO Mediaplus). Pre-Read erstellt. Antonia-Call 10:00 muss noch verschoben werden.
- [Hansa-Gym Widerspruch (Ari)](projects/hansa-gym-widerspruch.md) — 🔴 Frist Mo 11.05.2026. Fristwahrender Widerspruch heute per Email, Mo per Einschreiben.

## Outbox

_Drafts, die auf Absenden warten. Drafts landen hier durch `/draft park`, werden durch `/draft send` rausgeschickt._

| # | Ziel | Thema | Ort |
|---|------|-------|-----|
| 1 | Antonia Gebhardt + Benjamin Heinke (Group-DM) | Doctolib-Connector PVS-Bridge — Architektur-Input + Build-vs-Buy-Entscheidung | Slack Group-DM |
| 2 | Justina Pettit (Serviceplan Recruiting) | Termin-Bestätigung Brüll-Call Mi 06.05. 09:00–10:00 Uhr | Gmail Draft (r-2745024539056407098) |
## Stale Threads (>14 Tage ohne Bewegung)

_Aktiv zu beobachten:_
- **Lambda — VSS-Terminbuchungs-Fehler paeDOC** (Ticket 28.04.) — Antwort von support@lambda-itsystems.de ausstehend. Staleness-Check wenn keine Antwort bis ~12.05.

## Today's Focus / Notes

- **Datenschutz-Signing App Lütjensee (30.04.) ✅:** WinSW-Resilience-Layer eingebaut — Boot-Autostart, Auto-Restart, SCM-Recovery, Crash-Test verifiziert. Details: [luetjensee.md](projects/luetjensee.md) Datenschutz-Signing-Section. TODO: `DEPLOYMENT.md` im Repo noch nicht synchronisiert.
- **Pipedrive Begrüßung-Backfill (28.04.) ✅:** Stufe 1 durch — 1.373 Personen deterministisch gefüllt. Details: [pipedrive-mcp.md](projects/pipedrive-mcp.md).
- **Antragswesen Tool-Refactor (28.04.) ✅:** Bundle-aware, 20 → 13 Gaps. Details: [antragswesen.md](projects/antragswesen.md).
- **Kronprinzenbau (28.04.):** Bauplan 3.OG an Jan Kreimeyer (Lambda) gesendet. Antwort ausstehend.
- **Gmail-MVP (28.04.):** Spec + Plan + 5 von 10 Tasks gebaut. Tasks 4–8 + 10 offen. → [marvin-infrastructure.md](projects/marvin-infrastructure.md)
- **Pflegeheim-Scraper BB+MV (04.05.) ✅:** BIVA scraped, 597 Heime / 544 unique Emails an Sebastian. Liste in `~/Downloads/Pflegeheime_BB_MV_2026-05-04.xlsx` — Sebastian muss File noch manuell in Slack droppen.
- **AI-Org Substanz-Mail an Jens (04.05.) ✅:** Thread "BLOCKER: Workflows & Co" — 5 Architektur-Fragen + 4 Recap-Klärungspunkte + Owner-Map + Capacity-Hinweis vor Freitag-Meeting (08.05. 16:30). Jens-Antwort bis Do erwartet.
- **Baseline-First-Methodik (04.05.) ✅ Tim-Ole-aligned via O4-Thread:** Vorher/Nachher-Logik mit harten Performance-Metriken. [Template](https://www.notion.so/35657538249e812ab5e5d86eaf3f0fc6) + [DB](https://www.notion.so/05f9708610a146a1982e60417dfb45ba) live unter AI Playbook. 6 AI-Org-Termine mit Baseline-Agenda erweitert. Pilot Mi 06.05. (Antonia) + Mo 11.05. (Friederike).
- **Friederike Setup neu (04.05.):** Mo 11.05. 09:30–10:30 (Operations Weekly als ersten Pilot). 30.04. ausgefallen (Friederike Do frei).
- **Notion Housekeeping (04.05.):** Notion Intranet Architecture (war top-level) unter "The AI Org" eingehängt.
- **Serviceplan Brüll-Termin (04.05.):** Mi 06.05. 09:00–10:00 fixiert. Pre-Read-Doc erstellt (`bruell-pre-read.md`). Antonia-Call 10:00 muss noch verschoben werden (ACTION offen).
- **PaeDoc-Standardprozesse-Doc (04.05.):** Approach-Wechsel auf Aurelia-async-Befüllung + 60-Min-Klärungstermin Mi 20.05. mittags. Doc `1uQK6xV0ot5iHs3E9zEmhOOqtwOSZ-XngKvVmRV2wD9M` angelegt, Phil hat Editor-Rechte. Email an Phil raus — wartet auf Antwort. → [gomedicus-kids.md](projects/gomedicus-kids.md)
- **SharePoint-Report ak/Takeda (04.05.):** Editor-Rechte-Approach via Friederike-Pattern. Email an Steffi + Christian Schneider raus. Nächster Schritt: Friederike-Klärung. → [ak-takeda.md](projects/ak-takeda.md)
- **medatixx TT-26-094040 (04.05.):** Slack-DM an Stefan Haupt zu BDT-Import-Block. Antwort ausstehend, dann gebündeltes medatixx-Reply. → [luetjensee.md](projects/luetjensee.md)
