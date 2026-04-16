# Current State

Last updated: 2026-04-16 16:27

## Active Priorities

1. **AI Services Rollout** — T1 fertig (Ø Sicherheit 3,1/5). Office Hours Do 15:00 (Kickoff 16.04.). Nächste: T2 Form an Basti+Jens (~21.04.), Prompt-Workshop planen.
   - **Ricarda Staar** — Setup-Session 16.04. 15:30. [Rollenseite](https://www.notion.so/34357538249e81e68722ccaf8de6e91e)
   - **Sabrina Deffner** — Kernbedarf = Use-Case-Discovery (nicht Setup). [Rollenseite](https://www.notion.so/34357538249e8127b094f0e614343b20)
   - **Antonia Gebhardt** — Stufe 2 gestartet (15.04.), Check-in KW 16 (22.04.). [Rollenseite](https://www.notion.so/33b57538249e81319fb6cadaad9a5eb2). T1 nachholen.
   - **Thomas Flieger** — ✅ Setup komplett. Pipedrive MCP ✅.
   - **Janina Huebsch** — ✅ Setup komplett. Pipedrive Anrede-Problem: Custom-Feld "Begrüßung" anlegen + testen vor Di 21.04. [Webinar-Guide](https://docs.google.com/document/d/1y86DSiPAij2zw6SwI3ALhZcdAQGqOrZRK9gQIAfG8OE/edit)
   - **Notion:** [AI Org](https://www.notion.so/2fd57538249e804abc35fb9d874b2829) · [AI Playbook](https://www.notion.so/34357538249e814688cfdb0434dc973f) · [Prompt-Bibliothek](https://www.notion.so/33057538249e8163960ce8e02607ff32) · [Datenschutz-Leitfaden](https://www.notion.so/33057538249e81e69759e6e668324627) · [T1-Auswertung](https://docs.google.com/document/d/1wMYAwTYDV3i6_DmYwMQSSm4w3LCf-ijgVd4qCykkUDI/edit)
2. **GoMedicus MVP** — ⚠️ **Muss live.** Timeline: Kids Juni, Lütjensee+Kronprinzenbau Juli, 2 weitere Okt. PVS: Tomedo bevorzugt.
   - Staging → Prod offen: GOM-2335 (Phone Validation), GOM-1977 (Birthday Field)
   - Corti Template: ✅ unblocked (GOM-2446). GOM-2689 Transcript: ✅ non-blocking decided. GOM-2736 BDT: ✅ Platzierung decided.
   - GOM-2730 Multi-Service Pricing: Feedback Basti+Jens ausstehend
3. **Kronprinzenbau IT-Planung** — Phase 1: 23 Arbeitsplätze, Bestand-Mix. SSoT: [Definition IT-Ausstattung](https://www.notion.so/33c57538249e81bb8268e9345c6d86a5). [Notion Projektseite](https://www.notion.so/33c57538249e814f80c9e437e75f460e)
   - ⚠️ **Parallelbetrieb-Risiko:** Jens hat angedeutet → Bestand-Mix fällt weg, komplett neu nötig. Jan Kreimeyer Termin ausstehend (Email 15.04.).
   - 🔴 **Deadline 18.04.:** Michael — Hardware-Inventar Bestand liefern + Netzwerk-Preset entscheiden (Lütjensee-Preset wiederverwenden?)
   - Offen: Rezeptdrucker-Modell, Cherry ST-1506 Kartenleser
   - Angebot bis 15.05. Lambda-Woche 20.-24.07. bestätigt.
4. **Lütjensee** — Go-Live Juli, PVS-Migration KW 31 (ab 3. August), Konversion KW 28. Lambda-Angebot 49.740 € → zu teuer, Nachverhandlung läuft. Telefonassistent: Doc Medico Interim ab Konversion.
5. **Website** — "GoMedicus Prime" Ärztekammer-Prüfung offen.
6. **GoMedicus Practices** — paeDOC Website-Migration läuft. Zugangsdaten gesichert, Notion + Obsidian-Archiv erstellt. [Notion Migration](https://www.notion.so/32f57538249e8154a5ddfdebbff083e4). **Email-Migration IONOS → Plesk:** Staged Rollout geplant (6 Phasen), [Notion-Ausführungsplan](https://www.notion.so/33357538249e81d1b086f2a2b2412f0f) + Playbook-Spec erstellt. Nächste: Sebastian Luitle briefen + Phase 1 (Discovery) starten. Außerdem offen: Domain-Transfer Draft absenden, Aurelia kontaktieren (Email-Klärung, kinderaerzte-im-netz Update).
7. **Telefon AI Agent (ElevenLabs)** — Phase 1: Info-Rückrufe automatisieren. [Analyse](https://docs.google.com/document/d/1iLLsmqja-sS2tuCjkJ6po5VbiVjOILr6MKvrkqAAnTo/edit) · [Notion](https://www.notion.so/31957538249e81ec8907ee2b299f28b7). Offen: Konzept v6 schreiben, Slack-Entwurf posten. Code: `~/Documents/web/elevenlabs-knowledge`.
8. **Tomedo CUA Agent** — Hybrid-Architektur produktiv. Repo: [GoMedicus/cua-tomedo](https://github.com/GoMedicus/cua-tomedo). Offen: Popup "Kontaktdaten prüfen" deaktivieren, `enter_diagnosis` + `trigger_aktionskette` Smoke Tests, Medikation-Flow stabilisieren, Hinweis-Fenster automatisch schließen.
9. **Voice Onboarding Agent ("Dr. Onboard")** — Demo-App steht. Repo: `~/Documents/web/gom-voice-onboarding/`. Friederike Review der Inhalte ausstehend. EdApp API-Anbindung offen (Free Tier hat keinen API-Zugang).

## Open Threads

### Work - Lütjensee

**Datenschutz-Signing App** — ✅ Deployed + in Benutzung. [Repo](https://github.com/GoMedicus/gom-luetjensee-datenschutzsign) · [Notion](https://www.notion.so/30c57538249e81e9b846c75d2025c3a8) · Server: `192.168.0.1:3000`, VPN `remote.dr-muenchow.de`

**Beschilderung Redesign** — Figma-Designs erstellt (02.04.). Alle 7 Schilder im GoMedicus-Branding angelegt.
- **Figma:** [Beschilderung Lütjensee](https://www.figma.com/design/lfUJPLGbBMtYidLtzTk8qj)
- **Spec:** Obsidian `Projekte/Lütjensee/Beschilderung-Redesign-Spec.md` · [Google Doc](https://docs.google.com/document/d/13gq96mEYMitGFCvKHrPyLxZuz4LS3zH6qGgdHsvFyzE/edit) (geteilt mit Henry)
- **Schilder:** E1 Hauptpraxis (68×32,2cm), E2 Großbaier Privatpraxis (68×30cm), E3 Garbe (68×30cm), S1 Stele (55×48cm, dunkel+hell), S3 Kontakt (55×15cm), S4 Sprechzeiten (55×15cm). Stele 2-seitig.
- [ ] Stefan Haupt: Auf Schildern? (Eigenes oder auf E1?)
- [ ] Stele dunkel oder hell entscheiden
- [ ] URL klären (gomedicus.com vs. luetjensee.gomedicus.com)
- ✅ Henry per Slack gebrieft (02.04.)
- [ ] Nikolai: Designs selbst reviewen + händisch in Figma finalisieren
- [ ] Jens-Review (nach Nikolais Feinschliff)
- [ ] Nach Feedback: Druckdaten exportieren + Hersteller beauftragen

**Praxis-WLAN** — Eingerichtet (20.03.), 2 SSIDs (`Praxis-Luetjensee` + `GoMedicus-Gast`). ✅ WLAN-Schild für Wartezimmer erstellt ([Figma](https://www.figma.com/design/F5XMSl8u6pg7z73gxCMmzH)).
- [ ] Schild ausdrucken + im Wartezimmer aufhängen
- [ ] Hexnode MDM: 3 Lütjensee-iPads supervised enrollen. **Anleitung fertig:** [Google Doc](https://docs.google.com/document/d/18ILfetnrSv9ZAdFNP1A0Z-BUQ7N4iwveM6zy3N3D5OY/edit) + Vault `Wissen/Hexnode-iPad-Enrollment-Anleitung.md`. Session mit Flo gestartet (08.04.), noch nicht abgeschlossen. → Hexnode-Instance gehört zu MKD, siehe Abschnitt MedKitDoc Hardware.
- [ ] MacBook Air für Praxis-Arzt einrichten (Telemedizin)

**Hardware-Inventar** — ✅ Ist-Aufnahme komplett + ✅ Mail an Lambda gesendet (02.04.): 9 PCs + 1 Laptop + 1 Server + 7 Monitore + 9 Drucker + 1 Scanner + 4 Kartenleser + 2 APs.
- Obsidian: `Projekte/Lütjensee/Hardware-Inventar-Luetjensee.md`
- ✅ Lambda-Angebot AG-4023 erhalten (09.04.) — Nachverhandlung läuft
- [ ] Talkmaster-PC Funktion klären

**Lambda-Angebot AG-4023** — 49.740 € brutto, Nachverhandlung läuft (Budget 25-30k). Fehlend: TI-Anbindung, Datenmigration. Managed Services 837 €/Monat.
- [ ] Flo: Mail an Lambda/Martin für Verhandlungsgespräch
- [ ] Jens + Flo: Strategische Abstimmung Rahmenvertrag
- [ ] Friederike: Sabrinas Urlaub vs. KW 31/32 prüfen (On-site-Support)
- [ ] TI-Anbindung Kosten bei Lambda anfragen
- [ ] Klären: Datenmigration medatixx → Tomedo
- [ ] Pascom + Doc Medico Weiterleitung klären

**Telefonanlage** — Wartungsvertrag bis 14.02.2027, wird zusammen mit PVS-Migration KW 31 (August) umgestellt. Checklisten-Deadline auf 01.08.2026 verschoben.
- **Betreuer:** Thilo Weckwerth (tetewe.de) — tw@tetewe.de
- [ ] Rechnung (20.02.) an Buchhaltung/Arved weiterleiten
- [ ] Neue Telefonlösung evaluieren (Deadline: vor 14.02.2027)

**EDV-Umstellung**
- Workshop vor Sommerferien, Datum kommunizieren
- PVS-Entscheidung: Lütjensee als Pilot für Medatixx oder DocZeros
- Hardware-Erneuerung schrittweise nötig

**Website dr-muenchow.de** — Live: hausarztzentrum-luetjensee.web.app. Custom Domain: Email an Olaf Reinhardt (Strato-Zugang) raus, Antwort abwarten. Plan: dr-muenchow.de + luetjensee.gomedicus.com → Firebase, alte Mobirise-Seite abstellen.
- [ ] HRB für Rhein-Neckar MVZ GmbH verifizieren
- [ ] Strato-Zugangsdaten abwarten → Firebase Custom Domain konfigurieren
- [ ] Datenschutz-Formular zum Download

**Kontakte & Partner** → Obsidian `Arbeit/GoMedicus/Kontakte.md`
- Praxis: 04154-71 21 · Rezept: 04154-709 38 48 · Mo/Di/Do 8–18, Mi/Fr 8–12
- LANFOCUS (TI): Daniel Doobe — 040/65 65 665
- PC-Fun (IT): Olaf Rajek — 04552-999896

**BARMER — Gesicherte Mailverbindung** — PGP-Setup steht
- Alias-Datei (6 KKs): [Drive MedKitDoc](https://drive.google.com/file/d/1MkaainGdUrhsfDhwVYyUWFwuKdma60QJ/view)
- [ ] Slack an Friederike senden (SVLFG-Anleitung + aktualisierte Alias-Datei)

**Warten auf**
- Olaf Rajek — IP→Sprechzimmer Mapping (Email 12.03.) ⚠️ stale
- Friederike — Tomedo-Import-Test (fehlende Felder 3108/4111/3110) ⚠️ stale seit 13.03.
- Philipp Gonser — ZDS Bürosysteme Feedback (Mail 05.02.) ⚠️ sehr stale
- Corti.ai / Adam Culbertson — Addendum v3 versendet (14.04.), Feedback abwarten. [v3 Doc](https://docs.google.com/document/d/1Z2voUKJNa3Q-DrM3vWtHTYjisSuWRd3YsOvgGTiPmnY/edit)

### Work - Website

- [ ] "GoMedicus Prime" — Ärztekammer-Prüfung abwarten (Philipp plant Termin mit Justiziarin)

### Work - AI & Systems Office (ehem. CDIO Rolle)

**"Niko's Office" Meeting 16.04.** mit Jens, Tim-Ole, Flo. [Meeting-Notizen](https://docs.google.com/document/d/1WN_J2IvpAiD1D0jvGfxn3WWHKzhr0N3Mo7BTTa8Ph9c/edit). Office heißt jetzt **"AI and Systems Office"** mit 3 Säulen:
**Tim-Ole 1:1 (15.04.):** [Meeting-Notizen](https://docs.google.com/document/d/1ac88fa1JB55ityZ_E3CWbg1uwE-cmvH0ZrjZDdV93g0/edit) — CDIO-Seite fast fertig, 2 offene Jens-Punkte. Strategie-Shift Bottom-up → Top-down bestätigt.
1. **AI Infrastructure / Enablement** — AI-first Org
2. **Systems Enablement / People Enablement** — Onboarding, Effizienz, Personio-Management (von Sebastian L. übernehmen)
3. **IT Systems** — Praxis-IT, Vendor-Management, Hardware

**Org-Struktur (Jens):** Platform Entity (extern, eigener CEO) | Corporate Office | Platform Ops | Care Operations | People Office (Flo) | Marketing | Growth | **AI Tech & Systems Office (Nikolai)**

**Notion-Restrukturierung:** Org-Struktur in Notion Spaces umsetzen. 1-Woche-Test in "Praxisintegration" mit 4er-Gruppe (Nikolai, Jens, Tim-Ole, Flo). Datenbank-Pflicht für alle. **Zugesagt: Do 17.04. Nachmittag.**

**Franzi Löle** — Doctolib-Hintergrund, PVS-Projektleitung bei Dr. Lipp (2 Jahre). Start 1.8. oder 1.9. Bestätigt: Lambda = bester Vendor. Sie + Antonia fragen bei Dr. Lipp nach wechselwilligen IT-Kandidaten.

**Kernaussage Jens:** Alles was nicht auf die 3 Säulen einzahlt, muss abgegeben oder gestrichen werden.

[Notion Spec](https://www.notion.so/32d57538249e8015a424f04a61f0a348) · [Ownership](https://www.notion.so/2e757538249e804cbf10ea312f83ec39)
- Verbleibende Jens-Blocker: O2 Roadmap-Datum + PM Plattform Budget
- **Hiring IT Ops Lead** — Personio Job 2594644, 3 Bewerbungen/kein Match. [Optimierungs-Doc](https://docs.google.com/document/d/1_DSjzfoVBsxCjg2n2KxRyqR4vzkIJYB5f-Q_P9yHk8Y/edit) an Flo (16.04.)
  - [ ] Flo: Feedback zum Optimierungs-Doc + IT-Stellenanzeige verfeinern (gemeinsam)
  - [ ] Nach Feedback: Titel + Text in Personio aktualisieren
  - [ ] Active Sourcing starten (LinkedIn: Tomedo/medatixx/TI/Hexnode) + Franzi/Antonia-Kontakte
  - [ ] Basel Abdul Fattah absagen
  - [ ] Klären: Wer hat "HR & People Manager" in Personio angelegt und warum (16 leere Stellen ohne Titel aufräumen)
- [ ] **Notion Org-Struktur umsetzen — Deadline Do 17.04. Nachmittag**
- [ ] 30-60-90 Plan weiterentwickeln (Jens-Deliverable)
- [ ] Personio-Management Übernahme von Sebastian L. planen
- [ ] Meeting mit Antonia + Franzi Löle organisieren (IT-Migrations-Erfahrungsaustausch)
- [ ] Nikolai: Slack-Drafts an Jens absenden (CDIO-Diskussionen abgeschlossen + Skills-Seite aktualisiert)
- [ ] Nikolai: O5 Scope-Definition auf Notion-Seite (CDIO) formalisieren
- [ ] Jens: Verbindliche AI-Policy definieren
- [ ] Hardware: Flos M4-Upgrade (Alice' Rechner), Henrys Upgrade
- [ ] Flos Cloud-Onboarding abschließen
- [ ] Häufigere 1h-Gespräche über Praxis-Pipeline einplanen

### Work - Series A Tech DD Prep

**DD läuft.** Owners: Ben (CTO) + Nikolai (CDO). [DD Master](https://www.notion.so/32757538249e8151b9e2d55985c58b96) · [Tech DD](https://www.notion.so/32757538249e8181a8cbd5c317fe7d4d) · [Fragenkatalog](https://www.notion.so/32957538249e81e58f51dfe4ff3ec27f) (24✅/22🟡/7🔴)
- **Investor-Feedback (16.04.):** Investoren wollen Operational Maturity + Benchmarks. Nikolais Anteil ~20%.
- **IT-Integration Deliverables:** [Scorecard](https://docs.google.com/document/d/16CycnHLBl1N1quuo1_t-e6X2iOnot-ofIllwBBfPhjI/edit) (WIP, 31% — 16/51 Meilensteine) · [Playbook](https://docs.google.com/document/d/1lShnhdqXWIOQvIVjhThVLlkMY80hq7x8W9XYst6Lva8/edit) (WIP, 5 Phasen) · [Drive](https://drive.google.com/drive/folders/1gnJY9eTsSUAFF80FUvXhgEPzrnVPmkhT)
  - [ ] CDIO-Profil + Hiring-Pipeline — noch nicht erstellt
- ⚠️ **§393 SGB V (Cloud C5):** GoMedicus braucht ggf. eigenes C5-Testat. Prüfauftrag Sebastian Schulz

**Offen:**
- [ ] Ben: IP-Transfer Cloudnonic dokumentieren (LOI Precondition! 🔴 Blocker)
- [ ] Ben: Skalierungskonzept (KW13)
- [ ] Ben: PenTest-Status (3,5 Jahre alt, 11 offene Findings)
- [ ] Ben: DSFA aktualisiert seit Jul 2022?
- [ ] Nico: Governance-Doku Grundgerüst (KW13, braucht Ben-Input)
- [ ] Staging→Prod Deployment-Sprint (43 Urgent Bugs auf 0)
- [ ] DSGVO formale Dokumente (VVT, TOM, AVV-Register) mit Legal/DSB
- [ ] Produktroadmap Timelines mit Ben/Alice abstimmen

**Risiken:**
- 🔴 IP-Transfer Cloudnonic = LOI Precondition (Blocker)
- 🟡 PenTest 3,5 Jahre alt — neuer Test nötig
- 🟡 DSFA 4 Jahre alt — Aktualisierung nötig
- 🟡 Monitoring/Uptime-Daten unklar

**Cleura / EU-Cloud** — Post-MVP-Thema. [Market Scan](https://www.notion.so/34157538249e81a4a375f8db5ef51f46) · [Antworten-Draft](https://www.notion.so/34157538249e81e09bdee6305d6bfc37). Ben-DM steht, nicht gesendet.

**MKD DD** ([Notion](https://www.notion.so/32757538249e812a9d64db9830f7afb6)) — 🟡 Teildaten, 7/9 Deliverables rot
- Confluence gesichtet (27.03.): Multi-Tenancy, Infrastructure, SW-WI-01, 8 ADRs → Erkenntnisse in Notion
- DSFA (Jul 2022) nur als PDF — manuell zu sichten
- Owner "???" bei 3 Deliverables → Sebastian klären
- [ ] Sebastian: MKD DD TODO-Liste mit 7 roten Deliverables + Owner-Klärung

### Work - MFA Onboarding Guide

**Review abgeschlossen (18.03.)** — 12 Issues behoben (4 kritisch: Delegationsrecht)
- [Review-Dokument](https://docs.google.com/document/d/1kHeQawxNl8jM5qhAxvoZ5O7X_58W4MvM0QpWt6hOhsY/edit) · [Guide](https://docs.google.com/document/d/1ZiBHVPvc3DKjKOd3PDzfP1fO4GAJbw-RG1WhgRrind8/edit) · [Vorher/Nachher](https://docs.google.com/document/d/15IYAft8Yu3hYLUv5_zSdHREAvztmwLAVCECzGC2Etak/edit)
- [ ] Review-Dokumente an Philipp, Friederike, Michael teilen
- [ ] Feedback einarbeiten (23 offene Fragen)
- [ ] TBD-Items auflösen
- [ ] Finale Version deployen + Pilot-Test

### Work - Lambda / HSK

- [ ] **🔴 Kronprinzenbau (Deadline 18.04.):** Michael Füllemann — Hardware-Inventar Bestand + Netzwerk-Preset Entscheidung
- [ ] Michael Füllemann → 2x SMC-KT + 2x Cherry Kartenleser an Lambda
- [ ] Michael Füllemann → Adressen Robert & Nele an Paul Epple
- [ ] Paul Epple → Angebot Telemedizin-Setup + VPN-Gateways

**GoMedicus Kids — Tomedo-Migration** — 3 Standorte (Bisingen, Altensteig, Fellbach), 21 Arbeitsplätze. [Notion](https://www.notion.so/33d57538249e8192b88dea25a0180cce) · [Lambda-Anforderungen](https://docs.google.com/document/d/1CXYSWt_W2XXCcnTFhAEaHooETPJn-PN9xfCBqJWi0AA/edit). Inventar komplett, Email an Lambda (Jan) raus.
- [ ] Seidemann-Ticket → Serverstruktur-Details an Lambda liefern (KW 16!)
- [ ] Internet-Infos 3 Standorte — bei Lambda nachfragen
- [ ] Zollsoft-Rahmenvertrag mit Martin (Lambda) klären
- [ ] Lambda (Jan): Angebot erstellen

**Lütjensee — Tomedo-Migration KW 31**
- [ ] Nikolai: Email Medizintechnik-Inventar, Video-Walkthrough, Raumplan, Labor-Info, WLAN-Details an Lambda
- [ ] Nikolai: Augustwoche (ab 3.8.) mit Familie blocken
- [ ] Florian: Harte PVS-Deadline konkretisieren
- [ ] Martin (Lambda): Angebot erstellen

### Work - Doc Cirrus

- Neuen Präsentationstermin finden + bei Isabell buchen
- **Testzugang:** `eb3e6401000.trial.doc-cirrus.com` (Customer 11556)
- [ ] Benjamin API-Docs Zugangsinfo weiterleiten (Sol-Partner-Programm nötig)

### Work - Hardware-Standards Zentrale

**Erledigt (27.03.)** — Notion-Seite erstellt, IT Onboarding Checklist verlinkt
- **Notion:** [Hardware-Standards — Zentrale](https://www.notion.so/33057538249e8129ba77c675d7b6a4c8)
- 3 Profile: Office/Admin (MacBook Air M4), Dev/Creative (MacBook Pro M4 Pro), PVS/medatixx (Windows, unter Vorbehalt)
- [ ] medatixx Remote-Klärung abwarten → Profil C aktualisieren oder entfernen

### Work - MedKitDoc Hardware-Verwaltung

**Hexnode MDM** — `medkitdoc.hexnodemdm.com`. 4 iPads konfiguriert (3 ✅, 1 🟡 Policy prüfen). [Notion](https://www.notion.so/34157538249e81278deadf1846e2e9c8) · [Anleitung](https://docs.google.com/document/d/18ILfetnrSv9ZAdFNP1A0Z-BUQ7N4iwveM6zy3N3D5OY/edit)
- [ ] Web Clips aus Kiosk-Profil entfernen (Quelle unklar)
- [ ] ADE-Token ABM ↔ Hexnode erneuern (Hexnode-Support kontaktieren)
- [ ] Automation-Refactor: Policy auf Device Group mappen
- [ ] Configurator Blueprint "MedKitDoc iPad" anlegen
- [ ] Klären: Wer hat Hexnode-Account aufgesetzt? 2 ADE-Accounts

### Work - MARVIN Infrastructure

**GitHub Repo:** [NikolaiGoMedicus/marvin-chiefofstaff](https://github.com/NikolaiGoMedicus/marvin-chiefofstaff) (private). Erster Push 16.04.
**Auto-Sync:** Stop-Hook committed+pushed nach Session-Save. Nightly Safety Net via launchd um 23:00 (`com.marvin.nightly-sync`).
**Hooks:** PreCompact (auto-save vor Komprimierung), Stop (auto-checkpoint + push), PostToolUse (QMD reindex), PreToolUse (Vault frontmatter check).
**UI:** Flicker-Free aktiviert (`CLAUDE_CODE_NO_FLICKER=1`), TUI fullscreen.
**Agents:** ✅ logging + context-refinement agents fertig (16.04.). `/end` + `/update` spawnen beide automatisch. `/draft` + `/compact` Skills live.
**Routines (Cloud):**
- [ ] Morning Briefing Routine — erstellt, Google Workspace Connector noch aktivieren, testen
- [ ] Weekly Report Routine — Prompt ready, noch nicht angelegt
- [ ] Routines nach Test scharfschalten

### Work - Slack MCP Integration

**MARVIN Slack App** — Bot + User Token aktiv, Read + Post funktioniert. Bot Scope: `channels:manage`. User Scopes: `channels:write`, `groups:write`.
- ✅ **Slack-Konsolidierung komplett (14.04.):** 4 archiviert, 27 umbenannt (v2-Schema), Descriptions gesetzt. Workspace-Permissions nach Umbau zurückgesetzt.
- [ ] MCP-Server um Search-Tool erweitern (nutzt User Token)

### Work - GoMedicus Platform

**QA Bug Review — Video MVP Testing (20.03.)** — 46 Items, 8 kritisch
- [Google Doc DE](https://docs.google.com/document/d/1unofwTdNlppTddQex3PPLOa9n0Y0eaBaNKNOL9_M_2w/edit) · [EN](https://docs.google.com/document/d/1zVaDHpeI7D6hU9-m5SKiNrxbPeA2Fdk2zY5rmXiHBSs/edit)
- [ ] Docs an Alice, Basti, Nicolas teilen
- [ ] Priorisierungs-Meeting + Linear-Tickets
- [ ] Dedizierter Video-Call-Test (Transkription + AI Summary)

**Cancellation Flow — Video Appointments (10.04.)** — Nicolas hat 9 offene Business-Fragen + 5 Edge Cases aufbereitet. Proposed Decisions Doc erstellt (MVP-Linie: 24h-Frist, voller Refund innerhalb, keiner danach, Cancel+New pre-filled, keine Limits/Gebühren/Sonderregeln).
- **Nicolas' Doc:** Cancellation Constraints.docx (Drive)
- **Proposed Decisions:** [Google Doc](https://docs.google.com/document/d/1f4fI5sW4qxYCdta8pabQ6noHDIdGP4hjrYgN4e5e4to/edit) — intern geteilt
- [ ] Monday Platform Sync: 9 Punkte durchgehen + Entscheidungen treffen
- [ ] Nach Sync: Dev Ticket finalisieren

**Service Visibility & Categorization (27.03.)**
- [Summary-Doc](https://docs.google.com/document/d/1JKTW3Ncd7NQKOIUKUoGzG8h-iYc0QZugPavaCZqT-lo/edit) in Drive 01 Buchungs- und Terminsystem
- 2-Dimensionen-Modell: Listing Visibility (patient/public/hybrid/none) + Routable Flag
- 15 Services gemappt: 5 Public, 10 Routing-only
- [ ] Slack an Nicolas, Juanma, Alice senden (Entwurf steht)
- [ ] Team-Feedback abwarten → Technical Spec

**GOM-2638 — Buchungsflow Rechtsdokumente Platzierung**
- [Spec-Doc](https://docs.google.com/document/d/1Xjaks1_9ySgA_G0Q6rdNYR7cegUJugIY7Ttw2wxlXEY/edit) erstellt (02.04.) — beide Flows (Gast + registriert), Terminologie, Checkbox-Logik
- ✅ Sebastian Schulz Review abgeschlossen (02.04.), Feedback eingearbeitet (07.04.): Schritt 3 aufgeteilt (3.1 Name+Email, 3.2 Stammdaten), Datenschutzhinweise prominent auf Landing Page, AGB in Plattform abrufbar
- PR #855 (Auth-Flow) in Review
- ⚠️ Formatierung im Doc noch manuell fixen (Heading-Styles Schritt 3.1/3.2)
- [ ] Alice: Antwort auf Trägergesellschaftswechsel-Frage (Fast-Follow oder Launch-Scope?)
- [ ] Nach Alice-Feedback: Scope-Abgrenzung ggf. anpassen + Link auf GOM-2638 posten

**PVS-Workflow-Analyse (Ben, Feb 2026)** — [Google Doc](https://docs.google.com/document/d/1jcDjpRT9Z3j37tabVdR3fLNxw9UpPrcsV6Lgm5slzLc/edit). Tomedo API v4.22.8 + Medatixx FHIR R4 Workflow-Mapping, Multi-TG Patient-Sync Konzept v1.0, Datenmigrations-Plan (DRAFT). Drive: 09 Plattform-Architektur. [Notion: PVS Integration](https://www.notion.so/31357538249e81bea8abde305bc9a8c0). Review Philipp ausstehend.

**Offene Issues:**
- GOM-2689 — ✅ Transcript Failure UX: **Non-blocking MVP entschieden (14.04.)** — Jens + Sebastian approved. Arzt kann Konsultation ohne Transcript abschließen, manuelles Notizfeld als Fallback. Re-Record/Retry als Fast-Follow. Decision auf Linear gepostet.
- GOM-2335 — 🟡 Staging. Phone Validation (Prod-Deployment nötig)
- GOM-1977 — 🟡 Staging. Birthday Field (hängt seit Januar)
- GOM-1976 — 📋 Notification Events — Product Definition mit Alice
- [ ] Call mit Nele — PVS-Feldnutzung
- [ ] Corti/CTI Update ans Team

**Evaluationen:**
- **Payment: Stripe** — [Spec-Doc](https://docs.google.com/document/d/1w9U6Deno9z7evq0dQDMDmXTIT4swlcpA4hWjflMUCNo/edit) (Payment + GOÄ Invoice, 3 MVZ Connected Accounts). [DPIA-Doc](https://docs.google.com/document/d/1L8dDuk1FE2B51eHBEr3bI0qa139q7hGDqoEoPku2MCA/edit). MVP-Basispreis: Zi. 3+A5+75 = 48,26 €. Offen: Vergütungsmodell — [Decision-Paper](https://docs.google.com/document/d/1SKPVHwf2qUEbqUul5jv5c5vTMVRaSqiON9MPD9IS1m4/edit) an Jens (14.04.).
- **Analytics Tool** — Plausible CE Self-Hosted. Docs fertig ([Notion](https://www.notion.so/31757538-249e-81a8-a2b7-e80ba5cbbd1f)). Nächste: Docs an Ben, GA/PostHog entfernen, VPS aufsetzen.
- **Corti ICD Agent** — Blocker: Nur ICD-10-CM (US), nicht GM (DE). Arnim fragen.
- **ICD-10-GM Synonym Search** — [GOM-2345](https://linear.app/gomedicusgroup/issue/GOM-2345). TODO: Slack an Sebastian Schulz.

### Work - M&A Pipeline Automatisierung

**Datenbeschaffung SH** — 82 MVZ + 25 Praxen/GZ. [Sheet](https://docs.google.com/spreadsheets/d/1GoHewFn53wSNUgq5WfgEHcIJ4zwlj2B2AXUk6dVVdlU/edit) · Repo: `~/Documents/web/ma-pipeline/`
- ⚠️ DSGVO-Klärung bei Sebastian Schulz — Freigabe vor Outreach nötig
- [ ] Slack an Flo/Arved posten (Entwurf steht)
- [ ] Sebastian Schulz: DSGVO-Einschätzung abwarten
- [ ] Flo: Excel-Liste zum Merge + Sheet reviewen

**Pipeline-Konsolidierung** — SSoT: [Deal Tracking](https://www.notion.so/eeefeba00f664cf7ba94f019cfcfbd2b?v=c13e2dea37224d96a61f1f956f7ae75f). Funnel: Ansprache→Qualifizierung→Termsheet→DD→Angebot→Closing. Folgetermin Flo: Do 16.04. 16:00.
- Offen: Feld-Mapping, Workflow auf Notion verankern, Name-Spalte nach vorne

### Work - Brand University Bewertung WS 25/26

**BS/DI-07 AI for Design Intelligence — Bewertungen fertig (09.04.)**
- 25 Studenten, 13 Gruppen, Noten 91–96. PDFs generiert via Template Form-Fill.
- **Output:** `/Desktop/grades/output/` (25 PDFs, Datum 17.02.2026)
- **Script:** `/Desktop/grades/generate_pdfs.py` (venv `.venv`, pypdf)
- **Obsidian:** `Arbeit/Brand University/Bewertung-AI-DI-WS2526.md`
- [ ] 4 Matrikelnummern nachliefern (Xiangdong Hao, Jiehan Wu, Ming Xu, Qiantian Luo) → Script erneut laufen lassen
- [ ] PDFs an Prüfungsamt einreichen

### Work - Brand University "Marketing & AI" SuSe 2026

13 Studenten, international, Englisch. [Day 1 Slides](https://docs.google.com/presentation/d/1Chsejvpao7X4-23_3oSqNi5b66eiWtqojVL5_KbLi0I/edit) · [Day 2 Slides](https://docs.google.com/presentation/d/1czeHGbnyQDNaoG4OK3Kblv_do7NdMMlJcRvCGuxpN2g/edit) (38 Slides, fertig). Vault: `Arbeit/Brand University/Kurse/`
- [ ] **Day 2 Review + Prep (morgen Fr 17.04.!):** Deck checken, Demos rehearsen, 3 Dummy Social Posts + 4 Briefs vorbereiten
- [ ] Day 2 Visual Polish: GIFs/Images
- [ ] GIFs Day 1 (Slides 35+50) + Slide-Formatting finalisieren
- [ ] Days 3-4 Detail-Specs (näher am Termin)
- [ ] RunPod ComfyUI Setup (Days 7-9)

### Work - Reporting

- [ ] Bisingen Q3 PDF — Daten extrahieren
- [ ] PVS-Reporting Lütjensee: Arved muss VPN einrichten + testen. [Anleitung](https://docs.google.com/document/d/1ZiETE2Sf4PIIzO8qEMHCjbcyezmHyTfN0al7G5xZ07E/edit)
- [x] ~~Slack Channel Naming v2~~ ✅ Komplett umgesetzt (14.04.)

### Work - Starface

- **⚠️ macOS Tahoe Fax-Inkompatibilität:** Rangendingen betroffen, Lösung offen
- **Sabrina CLIP / Rufnummernanzeige (16.04.):** Patientensteuerung-Team telefoniert mit Starface. Julia Wittmann bestätigt: angezeigte Nummer = `+4971218913250` (Reutlingen, Ansage für Rückrufer). Sabrina war auf `071218913251` konfiguriert (eine Durchwahl daneben, keine Ansage). **Ticket an Swissnet versendet (16.04.):** Umstellung Sabrina (UserID 7016218) von 251 → 250. Support: `it-mailer@swissnet.de`. Luana (gleiche Rolle) ist KW 16 krank, Verifizierung steht aus.
  - [ ] Swissnet: Rückmeldung zur Umstellung abwarten
  - [ ] Nach Umstellung: Sabrina Testanruf machen lassen
  - [ ] Luana: Nach Rückkehr Rufnummernanzeige verifizieren
- **Cloud:** go-medicus.starface-cloud.com · 37 Benutzer, 4 Premium Apps
- **Partnerwechsel:** Swissnet-ICT empfohlen, Rückmeldung ausstehend
- [ ] Swissnet-ICT Rückruf abwarten → Umzugsformular

### Work - LMS / Mitarbeiterschulungen (EdApp-Ersatz)

**EdApp wird zum 20.04. eingestellt.** SafetyCulture-Migration nur Free bis 10 User. Flo braucht System für Lütjensee-MA-Schulungen.
- **Evaluation:** Obsidian `Projekte/LMS-Evaluation-EdApp-Ersatz.md` — Shortlist: TalentLMS (Empfehlung), Haekka (Slack-native), SC Training, ILIAS, 360Learning
- **Empfehlung:** TalentLMS Starter ($69/Mo, 40 User, SCORM-Import, sofort produktiv)
- **Meeting:** 15.04. mit Sebastian Luitle (30 Min, nur EdApp-Thema)
- **anonymerhinweis@gomedicus.com** — Eingerichtet von Sebastian L. (14.04.)
- ✅ **SCORM-Export aller 6 Kurse (14.04.):** Via EdApp API extrahiert + als SCORM 1.2 verpackt. Tomedo-Grundlagen in TalentLMS getestet — funktioniert. Alle ZIPs in `~/Downloads/`: gomedicus-tomedo-grundlagen, gomedicus-arzeko, benutzung-der-softwaretools, hzv-patienteneinschreibung, gomedicus-willkommen + original abrechnungsschulung.
- ✅ **TalentLMS Free-Tier registriert (14.04.):** Erster SCORM-Import erfolgreich getestet.
- ✅ **Alle 6 SCORM-Pakete importiert (15.04.)** in TalentLMS.
- ✅ **Alle 6 SCORM-Pakete gefixt (15.04.):** Exit-Slides (53 Stück) gestrippt, finale Completion-Slides angehängt, expandable-list → scrolling-media konvertiert (12), image-galleries → scrolling-media (2), EdApp-Surveys gedroppt (9), EdApp-Spiele → Reflexions-Slides (5), Softwaretools-Intro-Title vorangestellt. Videos (4 in Willkommens-Kurs) als Hinweis-Slides markiert. Alle `-FIXED.zip` in `~/Downloads/`.
- [ ] Smoke-Test: Alle 6 FIXED-Kurse neu hochladen + durchklicken
- [ ] **Sebastian liefert Videos nach** für Willkommens-Kurs (E-Mail Warum + Wie, Slack Warum + Wie) → in 4 Hinweis-Slides einbauen
- [ ] Entscheidungs-Doc für Flo (Free vs. Starter $69/Mo vs. Plus $279/Mo) — Kernfrage: 125 MAs alle rein oder Rotation? Compliance-Tracking-Pflicht klären
- [ ] Abrechnungsschulung durchklicken (hat 3 unbekannte Slide-Typen `list`, `scrollable`, `image` — können stocken)
- [ ] Entscheidung Fr 18.04.
- [ ] Nach Entscheidung: Migration + Flo informieren

### Work - AI Services Rollout

- **Office Hours:** Do 15:00 weekly (ab 16.04.). **Ownership:** Nikolai (Enablement) + Flo (OKRs)

**Offene Setups:**
- [ ] Sebastian L.: Google Auth + 30 Plesk E-Mail-Adressen ([Anleitung](https://docs.google.com/document/d/10_OZwtcmvcH1lcqLGZliPsJuMEF2RDcFxyZGEXmQIgE/edit))
- [ ] Google Cloud App auf Production schalten (16 User aktiv)
- [ ] Phil: DXT deinstallieren + Config mit vollem uvx-Pfad

**Nächste Schritte:**
- [ ] T1-Auswertung an Flo teilen
- [ ] T2 Form: Vorschau prüfen, auf 16 Namen erweitern, an Basti+Jens (~21.04.). [Form](https://docs.google.com/forms/d/18FEtF2zVqjbUpCmgZnhNNqCb7Pc9BOq7mMYZcNuyv_k/edit)
- [ ] Prompt-Workshop planen
- [ ] Antonia: Stufe 2 Workflows — Check-in KW 16 (22.04.)
- [ ] T1-Befragung Antonia nachholen
- [ ] Jens: Ownership "Prozess & Adoption" (Alice-Nachfolge)
- [ ] Agent-Demo für Basti, Henry, Jens

**Claude Skills Library:**
- [Skills Program](https://www.notion.so/33f57538249e811782e0cad8c575d3ef) — technisch korrigiert, unter AI Playbook
- [ ] Jens: Working Session Corporate Document Style
- [ ] Erstes Claude Project "GoMedicus Corporate Docs" aufsetzen

**Offene Initiativen:**
- [ ] CEO Onboarding (Jens), GF Onboarding (Philipp), OKRs mit Flo

### Work - QM Handbuch Revision

**Kapitel 1 ins Original übertragen (26.03.)**
- [QM Handbuch](https://docs.google.com/document/d/1AGF06N7QfL0Jbsrzul_JN8c_KccxMGQ2AqFIg_OkW6k/edit) · [Finales Kap. 1](https://docs.google.com/document/d/1r8QJD4DLEXYtxKd3-8S0trt8sw3SvBdU0gIwXOV9cuc/edit)
- [ ] Styling im Original prüfen (Schriftart, Spacing)
- [ ] Named Version "Kapitel 1 Revision März 2026" anlegen
- [ ] Inhaltsverzeichnis aktualisieren

### Work - Org-Struktur

- **3 Entwürfe:** [Nikolai](https://docs.google.com/document/d/1DI0YH8pAUSXKvcJkjRZMRiQHE-P5KlXLrjS-rfqe5kI/edit) vs. [Jens](https://www.notion.so/GoMedicus-Organizational-Structure-31957538249e811cb14de4dc22afe218) vs. [Florian](https://www.notion.so/Restructuring-31757538249e8094a7afdd7e3a0753e6)
- **Klärungsdokument:** [5 Entscheidungen](https://docs.google.com/document/d/1mAaVXkSFsip_Q1K8Bvic_Qlw8Bht4eNPBXU_EmfYKWQ/edit)
- [ ] Klärungsdokument teilen + Sync-Call einplanen

### Work - Notion Konsolidierung

- Phase 1-3 komplett. Phase 2 (Tagging) + Phase 4 (Owner-Übergabe) offen.
- [Repositories DB](https://www.notion.so/c08f96f57cbb4b5789ce4b3dcbd9342f) — Views + Owner zuweisen
- [ ] Phase 2 ausführen (~46 Seiten taggen)
- [ ] Phase 4: Owner-Briefings

### Work - BDT Export / Import

- [GOM-2108](https://linear.app/gomedicusgroup/issue/GOM-2108) · Obsidian: `Projekte/BDT Spec/`
- BDT-Datei von Friedrich: Encoding+Datum gefixt, ⚠️ LF statt CR+LF (Byte-Prefixe falsch). Tomedo-Import-Test steht aus.
- **arztkonsultation ak / Takeda** — ✅ Ausgeliefert. Onboarding-Guide bereinigt ([Google Doc](https://docs.google.com/document/d/159MlPMtVxmGMTddQXpjsxA5PACf6TtaDXbcUmC45rCc/edit)). **Videosprechstunden-Integration:** Steffi fragte nach Status (08.04.), Gmail-Draft mit Update erstellt (10.04.) — MVP-Betrieb im April geplant, Payment-Priorisierung als Variable.
  - [x] ~~Gmail-Draft an Steffi abgesendet (Videosprechstunden-Integration Status)~~ ✅
  - [ ] Endpoint 3.4 (JWT) aus Partner-Doc entfernen?

### Work - Alice Albers Offboarding

Alice letzer Tag 07.04. Wissenstransfer ✅. [Notion Übergabe](https://www.notion.so/33357538249e81db98d4d3dc050c1d8d)
- [ ] PM-Nachfolge: Interim-Freelancer ASAP (500-700€/Tag), Festanstellung Q3

### Work - People / Onboarding

- **People-Inbox AP-Matrix:** Obsidian `Arbeit/GoMedicus/Wissen/People-Inbox-AP-Matrix.md`
- **Automation Repo:** `~/Documents/web/gom-people-mail-automation/` — Code fertig, Deployment offen
- [ ] Google Service Account + Domain-Wide Delegation
- [ ] Notion DB `📬 people@ Inbox` anlegen
- [ ] Erster Dry-Run mit echten Secrets
- [ ] AP-Matrix mit Jens/Arved/Michael validieren
- **Onboarding:** [Tracker](https://www.notion.so/30e57538249e81278a15f7d3da80dd9c) · [IT Checklist](https://www.notion.so/30e57538249e81ac8fc9d1c6474ed309)
- Antonia Gebhardt: Start 01.04., Manager Digital Health Ops, Zentrale. Mac versenden + Monitor bestellen (Samsung Odyssey G50F). Adresse erfragen!
- Ricarda Staar: MacBook versenden
- Daria Krune: MFA Bisingen, Start 01.09.2026
- [ ] MacBooks vorbereiten + Lambda-Ticket

### Privat - Strom / GWB Börnsen

- **⚠️ ~3.500 € Stromrechnung offen** — GWB Börnsen (040 3020844-0), kein Abschlag läuft. SmartMeter + HA Dashboard ✅.
- [ ] Frau: GWB anrufen — Abschlag klären (~185-190 €/Monat)
- [ ] GWB Arbeitspreis erfragen → HA eintragen
- [ ] USB-Verlängerung SkyConnect + Zigbee-Router (Wechselrichter-Dose instabil)

### Privat - Solaranlage Börnsen

3,6 kWp, Baujahr 2013. EEG ~17 Ct/kWh bis 2033. Doku: Obsidian `Privat/Projekte/Solaranlage/`
- [ ] IBN-Monat klären + Solarteur kontaktieren (Dachbegutachtung)
- [ ] Hybrid-WR recherchieren (Upgrade-Plan)

### Privat

- **Serviceplan Group** — Alexander Schill (Global CCO) Gespräch in ~2 Wochen. Strategie-Doc: Obsidian `Privat/Karriere/Bewerbungen/`
- **Telefónica** — Docs komplett, 150k. Einreichen oder Serviceplan abwarten?
- **Headhunter** — 4Talents, Egon Zehnder, Heidrick & Struggles, Monroe Consulting

### Privat - Claudio (Telegram Bot)

- **Repo:** `~/Documents/web/claudio` · [GitHub](https://github.com/NikolaiGoMedicus/claudio)
- Production-ready, MARVIN-Integration aktiv
- [ ] Reddit Post posten
- [ ] Kollegen zum Testen einladen
- [ ] Phase 2: Hybrid Streaming + Inline Keyboard Tool Approval

### Privat - Meshtastic

- **Nodes:** Heltec "Nikolaibibo" (stationär) + T-Echo "NikoEcho" (mobil). Mesh funktioniert.
- **Channel-Key:** `y16rmJjsUAldQLGExn98FSYwo250kESttuIyliEpbuw=`
- [ ] GPS-Fix + Reichweite testen

### Privat - Flipper Blackhat

- BlackHat OS V1.0, SSH: 192.168.178.37
- [ ] aircrack-ng installieren, Bjorn starten

### Work - CDIO Rollenbild & OKRs

- [ ] CDIO-OKRs als separates Dokument fürs 1:1
- [ ] 1:1 mit Tim-Ole — eigenes Framing
