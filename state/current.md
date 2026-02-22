# Current State

Last updated: 2026-02-22T15:00

## Active Priorities

1. **AI Services Rollout** — Pilot läuft, Basti Kickoff Di 24.02., Jens Setup Mi 25.02., Company-Switch Claude beschlossen
2. **GoMedicus MVP** — Evaluationen besprechen Mo 24.02. (Conversations API, Payment, Corti ICD). ⚠️ Zwei Prod-Blocker: GOM-2263 + GOM-2333
3. **Lütjensee** — Datenschutz-App Deployment, EDV-Workshop planen, Lambda HSK-Umstellung Fr 27.02.
4. **Website** — "GoMedicus Prime" Ärztekammer-Prüfung offen
5. **GoMedicus practices** — keep them running

## Open Threads

### Work - Lütjensee

**Datenschutz-Signing App** — Ready for deployment, VPN + Netzwerk verifiziert
- **Repo:** [gom-luetjensee-datenschutzsign](https://github.com/GoMedicus/gom-luetjensee-datenschutzsign)
- **Server:** `192.168.0.1` (Win Server 2016), VPN via `remote.dr-muenchow.de`, VPN-User `bockholt`, RDP-User `Admin`
- **PDF-Ablage:** `\\server\Praxis\Datenschutz` · **App-URL:** `http://192.168.0.1:3000`
- **Doku:** [Notion](https://www.notion.so/30c57538249e81e9b846c75d2025c3a8) · [Figma](https://www.figma.com/design/53ii2r595F4x2shc3xhBkN) · [Drive](https://drive.google.com/drive/folders/1A1cvK80d8cPtWu7SWcjwnPHjpvMgTjHu)
- **Netzwerk:** [Notion IT-Infra](https://www.notion.so/30e57538249e819999c8e2eb8fc63096) · Obsidian: `Projekte/Lütjensee/IT-Infrastruktur.md`
- [x] Deployment auf Server (22.02. remote via VPN+RDP)
- [x] Autostart via Task Scheduler (22.02.)
- [ ] iPad-Test im Praxis-WLAN (nächster Vor-Ort-Termin)

**Telefonanlage** — Wartungsvertrag verlängert bis 14.02.2027, muss vor Jahresende ersetzt werden
- **Betreuer:** Thilo Weckwerth (tetewe.de) — tw@tetewe.de · erreichbar ab 10.03.
- **Wartung:** Software-Support aktiv bis 14.02.2027
- [x] Rechnungsadresse an Thilo senden (22.02.)
- [ ] Rechnung (20.02.) an Buchhaltung/Arved weiterleiten
- [ ] Neue Telefonlösung evaluieren (Deadline: vor 14.02.2027)

**EDV-Umstellung**
- **Workshop:** Vor Sommerferien, Datum bis 27.02. kommunizieren
- **PVS-Entscheidung:** Lütjensee als Pilot für Medatixx oder DocZeros
- **Hardware:** IT-Erneuerung schrittweise nötig

**Website dr-muenchow.de** — Live: hausarztzentrum-luetjensee.web.app
- [ ] HRB für Rhein-Neckar MVZ GmbH verifizieren
- [ ] Custom Domain verbinden (optional)
- [ ] Datenschutz-Formular zum Download

**Kontakte & Partner**
- Praxis: 04154-71 21 · Rezept: 04154-709 38 48 · Mo/Di/Do 8–18, Mi/Fr 8–12
- LANFOCUS (TI): Daniel Doobe — 040/65 65 665
- PC-Fun (IT): Olaf Rajek — 04552-999896

**Warten auf**
- Philipp Gonser — ZDS Bürosysteme Feedback (Mail 05.02.)
- Corti.ai / Arnim — Professional Secrecy Addendum (angefragt 02.02.)

### Work - Website

- [ ] "GoMedicus Prime" — Ärztekammer-Prüfung abwarten (Philipp plant Termin mit Justiziarin)

### Work - Lambda / HSK

- **Umstellung: Fr 27.02.2026, 17:00 Uhr** — ~1h Downtime, danach Ausweise neu freischalten
- [ ] Michael Füllemann → 2x SMC-KT + 2x Cherry Kartenleser an Lambda
- [ ] Michael Füllemann → Adressen Robert & Nele an Paul Epple
- [ ] Paul Epple → Angebot Telemedizin-Setup (Robert & Nele)
- [ ] Paul Epple → VPN-Gateways vorbereiten

### Work - Doc Cirrus

- **Präsentation** — Alte Termine verstrichen, neuen Termin finden + bei Isabell buchen
- **Architektur-Fragen** — Slack an Ben/Jens, warten auf Antwort
- **Testzugang:** `eb3e6401000.trial.doc-cirrus.com` (Customer 11556)
- [ ] Benjamin API-Docs Zugangsinfo weiterleiten

### Work - GoMedicus Platform

- **GOM-2263** — ⚠️ Krankenkassen-Dropdown: PRs gemergt, nicht auf Prod. Urgent, Juan Manuel.
- **GOM-2333** — ⚠️ Document Upload 403 auf Prod. Dev muss Logs prüfen.
- **GOM-2335** — ⚠️ Phone Validation zu strikt. Fix: `@Matches` Regex.
- **GOM-1976** — Notification Events mit Alice
- **GOM-1977** — Birthday Field, wartet auf Klärung
- [ ] Call mit Nele — PVS-Feldnutzung
- [ ] Corti/CTI Update ans Team
- [ ] Dokumentenstruktur mit Alice erarbeiten

**Evaluationen (besprechen Mo 24.02.)**
- **Conversations API** — SendBird/Bird/Sinch Top-Kandidaten, TI-Messenger strategisch. Obsidian: `Projekte/Plattform/Conversations API/`
- **Payment Provider** — Mollie-Empfehlung, DSFA Pflicht, DSB muss Controller-Frage klären. Obsidian: `Projekte/Plattform/Payment Provider/`
- **Corti ICD Agent** — Blocker: Nur ICD-10-CM (US), nicht GM (DE). Arnim fragen. Obsidian: `Projekte/Corti/`
- **ICD-10-GM Synonym Search** — [GOM-2345](https://linear.app/gomedicusgroup/issue/GOM-2345). ClaML geparsed (9.130 Synonyme). [Notion-Plan](https://www.notion.so/30e57538249e8172bb39dc2ebd8115a7). **TODO: Slack an Sebastian Schulz** (Draft ready).

### Work - Reporting

- [ ] Bisingen Q3 PDF — Daten extrahieren

### Work - Starface

- **Cloud:** go-medicus.starface-cloud.com
- **Bestand (laut Gamma):** SF Cloud v7.3, 37 Benutzer, 4 Premium Apps, SIP: SF Connect + Gamma NGN
- **Lizenzen:** 3x Premium (vergeben) + 2x bei Equipo bestellt (anfordern)
- **Partnerwechsel nötig:** Equipo weg, Lizenz-Erweiterung nur über Partner. Übernahmeformular (3 Parteien), Wechsel zum Folgemonat.
- **ZDS Bürosysteme:** Mail gesendet (06.02.) — noch anrufen
- **API-Spec:** `~/Downloads/starface-api.yaml`
- UCC-Lizenzen: Patientensteuerung (Login 50), Luana (8738), Maryam (6123)
- [ ] **Jana Bommes (Gamma) zurückmailen** — Partner-Empfehlung BaWü (Draft ready, Mail 17.02.)

### Work - AI Services Rollout

- **Status:** ✅ Framework komplett, Pilot läuft
- **Ownership:** Nikolai (Enablement) + Flo (Prozesse/OKRs)
- **Ordner:** `Arbeit/GoMedicus/Projekte/AI Services Rollout/`

**Notion-Seiten:**
[AI Org](https://www.notion.so/2fd57538249e804abc35fb9d874b2829) · [Grundlagen](https://www.notion.so/2ff57538249e818594cae2ba52e36a49) · [Google Workspace Setup](https://www.notion.so/30e57538249e81538810fd969c20b3e8) · [Alice](https://www.notion.so/2ff57538249e81a7b7a1ffc2130158d7) · [Basti](https://www.notion.so/2ff57538249e81f996e7d50ea856c773) · [Friederike](https://www.notion.so/2ff57538249e8108b08fc2cfdcf56887) · [Sebastian L.](https://www.notion.so/2ff57538249e8109ae9cfb48df54ae78) · [Henry](https://www.notion.so/2ff57538249e81fb83c6e986bf909984) · [Florian](https://www.notion.so/2ff57538249e81a4998bf5dd4ac49b98) · [Flo](https://www.notion.so/30557538249e815b917cc9e7badeedf5) · [Jens](https://www.notion.so/30d57538249e819999b9d45999078f5f) · [Philipp](https://www.notion.so/30d57538249e8154b44adbf58aab2edb) · [IT-Grundprinzipien](https://www.notion.so/30657538249e815f8833c18380baa3b0)

**Google Workspace MCP:**
- Setup-Anleitung in Notion + Obsidian, Phillipp per Mail informiert (21.02.)
- Jens: Config-Datei erstellt (22.02.), DXT hat nicht funktioniert → manuelle Config. Braucht noch `uvx` + Auth.
- [ ] Config-Datei an Jens senden
- [ ] Jens: `uvx` installieren lassen
- [ ] Google Cloud App auf Production schalten (vor Jens-Setup Mi 25.02.)
- [ ] Alternativ: Basti + Jens als Test-User eintragen

**Rollout Plan:**
- KW 7-8: Pilot Alice ✓
- KW 9-10: Welle 1 Basti — Kickoff 24.02.
- KW 11-12: Welle 2 Friederike + Sebastian L. — 09.03.
- KW 13-14: Welle 3 Henry + Florian — 23.03.

**Meetings:**
- Office Hours: Do 15:00 weekly (Alice, Basti, Arvid, Jens)
- Alice Check-in: Mi 10:00 bi-weekly (nächste: 25.02.)
- Arvid Sync: Di 11:00 recurring
- Jens Setup: Mi 25.02. 11:00 (einmalig)
- Monthly: Mo 02.03. 14:00
- Jens/Nikolai: Fr 11:00 (informell)
- [ ] Calendar Recurring-Settings manuell setzen

**CEO Onboarding (Jens):**
- [ ] Setup-Session: Claude Desktop + Integrations + Voice Ink
- [ ] Claude Project "Practice Acquisitions" mit Lütjensee-Blueprint
- [ ] Morning Briefing live testen

**GF Onboarding (Philipp):**
- [ ] Setup-Session: Claude Desktop + Integrations
- [ ] Mitarbeiterübersicht GoMedicus Kids als Test
- [ ] Lohnjournal bei Schneider anfordern
- [ ] Ersten SOP-Entwurf mit Cowork

**Bigger Initiatives:**
- [ ] Integration Agent — Wiederholbare Praxis-Integration (Owner: Nikolai)
- [ ] Lütjensee Blueprint — Playbook für Übernahmen (Owner: Jens + Nikolai)
- [ ] SOPs digitalisieren — Notion als Grundlage für AI-Workflows
- [ ] AI Onboarding standardisieren

**Accountability:** Nikolai = Integration + Notion + Enablement · Jens = Vision + Acquisitions + Board

**Feedback-System:**
[Fragen-Vorlage](https://docs.google.com/document/d/1NSWJOUY488Eos4Cg8Ow7LfJ9Su0jz1iJhpGZrxligFQ/edit) · [Tracking](https://docs.google.com/spreadsheets/d/13kjX2gwigWD6vykoTgZQq_7oMux0FyEC2wy4QZi-uzk/edit) · [Notion](https://www.notion.so/30d57538249e81398f24e19e69170871)
- [ ] Google Forms erstellen (T1 + T2)
- [ ] Alice T1 versenden (überfällig ~27.02.)
- [ ] Form-Links in Notion + Sheet nachtragen

| Person | Kickoff | T1 | T2 |
|--------|---------|----|----|
| Alice | 13.02. ✓ | ~27.02. ⚠️ | ~10.04. |
| Basti | 24.02. | ~10.03. | ~21.04. |
| Jens | 25.02. | ~11.03. | ~22.04. |
| Friederike | 09.03. | ~23.03. | ~04.05. |
| Sebastian L. | 09.03. | ~23.03. | ~04.05. |
| Henry | 23.03. | ~06.04. | ~18.05. |
| Florian | 23.03. | ~06.04. | ~18.05. |
| Philipp | TBD | TBD+2w | TBD+7w |

- [ ] OKRs mit Flo im Workshop

### Work - BDT Export

- [GOM-2108](https://linear.app/gomedicusgroup/issue/GOM-2108) · Obsidian: `Projekte/BDT Spec/BDT-Field-Mapping.md`
- Wartet auf Juanma Review

### Work - MKD Light MVP

- **Linear:** [MKD Post-MVP - Stability](https://linear.app/gomedicusgroup/project/mkd-post-mvp-stability-a026c5424ef0) (Ziel: 27.02.)
- Offene Tickets: GOM-2249 (Tatiana), GOM-2250–2253 (Tatiana), GOM-2256 (Juan Manuel)
- GOM-2243 (Alejandro) — UI-Items offen
- In Review: GOM-2239, GOM-2241 (Jefersson)
- PCM Dashboard: GOM-2192 (Nicolas)

### Work - Platform Strategy

- **Milestones 2026:** Video MVP, MKD Integration, PVS Integration
- **Video MVP:** KBV-zertifizierter Player (xpertyme, Arzt-Konsultation)
- **PVS:** Medatixx vs. Doc Cirrus
- **ROA Board:** 107 Issues, de facto tot → Clean Slate empfohlen

### Work - People / Onboarding

- [Onboarding Tracker](https://www.notion.so/30e57538249e81278a15f7d3da80dd9c) · [IT Checklist](https://www.notion.so/30e57538249e81ac8fc9d1c6474ed309)
- **Ricarda Staar** — MacBook versenden (Nikolai), Workspace (Sebastian L.)
- **Barbara Sauter** — Ärztin Rangendingen, Start evtl. 01.03.
- **Dr. Maja Michels** — ⚠️ Nicht im KVBW-Arztregister
- **Daria Krune** — MFA Bisingen, Start 01.09.2026
- [ ] MacBooks vorbereiten + Lambda-Ticket
- [ ] Personio Onboarding-To-dos (5 Personen)

### Privat

- **Anthropic Bewerbung** — Abgeschickt 14.02., Head of Production Creative Studio. Auf Antwort warten.
- **Headhunter** — 4Talents, Egon Zehnder, Heidrick & Struggles starten
- **Executive Profil** — Komplett in Obsidian (`Privat/Karriere/Profil/`)

### Privat - Flipper Blackhat

- BlackHat OS V1.0, SSH: 192.168.178.37
- Offen: aircrack-ng installieren, Bjorn starten

## Recent Context

- Datenschutz-Signing App deployed auf Lütjensee Server, Autostart eingerichtet, PDF-Ablage D:\Datenschutz (22.02.)
- Jens Claude Desktop Config: DXT gescheitert, manuelle Config erstellt + in Downloads abgelegt (22.02.)
- Telefonanlage Lütjensee: Rechnungsadresse an Thilo gesendet, in State aufgenommen (22.02.)
- Mail an Olaf: RDP-Zugangsdaten + Rechnungsdaten gesendet (22.02.)
- Starface: Gamma-Bestandsdaten eingetragen, Jana Bommes Antwort-Draft (BaWü-Partner) (22.02.)
- VPN Lütjensee eingerichtet + Netzwerk-Scan (24 Geräte), Doku in Notion + Obsidian (21.02.)
- Raycast: marvin.sh mit /start, luetjensee-vpn.sh erstellt (21.02.)
- Deployment-Plan Datenschutz-App: Server-IP + VPN-Daten aktualisiert (21.02.)
- Google Workspace MCP Setup-Anleitung: Notion + Obsidian, Mail an Phillipp (21.02.)
- People-Bereich in Notion Company HQ, Onboarding Tracker + IT Checklist, 4 Onboardings dokumentiert (21.02.)
- ICD-10-GM: ClaML geparsed, GOM-2345, Sebastian Schulz beauftragt (21.02.)
- QMD Integration getestet, alle Tools lokal funktionsfähig (21.02.)
- GF Philipp + CEO Jens Notion-Seiten unter AI Org erstellt (20.02.)
- Meetings komplett eingerichtet, Feedback-System aufgesetzt (20.02.)
- GOM-2263 reopened, GOM-2333 erstellt (20.02.)
- Drei Evaluationen vorbereitet: Conversations API, Payment, Corti ICD (20.02.)
- Datenschutz-Signing App komplett + Patientenexemplar (19.02.)

## Quick Links

- [Linear - GoMedicus](https://linear.app/gomedicusgroup)
- [Marketing (Notion)](https://www.notion.so/30357538249e810e9365f0574cc97c05)
- [GoMedicus Network (Notion)](https://www.notion.so/2e657538249e81619e03cf98f0f16010)
- [Plattform (Drive)](https://drive.google.com/drive/u/0/folders/16i2AZpKUACGBRrwbP659UbTpmMYYJMPv)
- [Lütjensee Checkliste](https://docs.google.com/spreadsheets/d/1BDrXcuvBEi9iSgVYRRzIKegkSUuuk0OQsmc63NDrYUg/edit)
- [Notification Events](https://docs.google.com/spreadsheets/d/1HUATT13KxgeAdSL6ErLm85C-3QH8JbVL3uIfE-y5eQo/edit)
- [Doc Cirrus Testzugang](https://eb3e6401000.trial.doc-cirrus.com/login)

---

*This file is updated by MARVIN at the end of each session.*
