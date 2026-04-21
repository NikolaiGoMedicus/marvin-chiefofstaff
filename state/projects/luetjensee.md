---
project: luetjensee
status: active
owner: nikolai
updated: 2026-04-21
tags: [work, lambda, priority, praxis]
---

# Lütjensee

## Status

Go-Live Juli, PVS-Migration KW 31 (ab 3. August), Konversion KW 28. Lambda-Angebot 49.740 € → zu teuer, Nachverhandlung läuft. Telefonassistent: Doc Medico Interim ab Konversion.

## Datenschutz-Signing App

✅ Deployed + in Benutzung. [Repo](https://github.com/GoMedicus/gom-luetjensee-datenschutzsign) · [Notion](https://www.notion.so/30c57538249e81e9b846c75d2025c3a8) · Server: `192.168.0.1:3000`, VPN `remote.dr-muenchow.de`

## Beschilderung Redesign

Figma-Designs erstellt (02.04.). Alle 7 Schilder im GoMedicus-Branding angelegt.

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

## Praxis-WLAN

Eingerichtet (20.03.), 2 SSIDs (`Praxis-Luetjensee` + `GoMedicus-Gast`). ✅ WLAN-Schild für Wartezimmer erstellt ([Figma](https://www.figma.com/design/F5XMSl8u6pg7z73gxCMmzH)).

- [ ] Schild ausdrucken + im Wartezimmer aufhängen
- [ ] Hexnode MDM: 3 Lütjensee-iPads supervised enrollen. **SSoT Anleitung:** [📱 iPad & Hardware Deployment (Notion)](https://www.notion.so/34157538249e81278deadf1846e2e9c8) — Vanilla Way (ADE + Configurator Wiederherstellen) am 20.04. verifiziert. → Hexnode-Instance gehört zu MKD, siehe [mkd-hardware.md](mkd-hardware.md).
- [ ] MacBook Air für Praxis-Arzt einrichten (Telemedizin)

## Hardware-Inventar

✅ Ist-Aufnahme komplett + ✅ Mail an Lambda gesendet (02.04.): 9 PCs + 1 Laptop + 1 Server + 7 Monitore + 9 Drucker + 1 Scanner + 4 Kartenleser + 2 APs.

- Obsidian: `Projekte/Lütjensee/Hardware-Inventar-Luetjensee.md`
- ✅ Lambda-Angebot AG-4023 erhalten (09.04.) — Nachverhandlung läuft
- [ ] Talkmaster-PC Funktion klären

## Lambda-Angebot AG-4023

49.740 € brutto, Nachverhandlung läuft (Budget 25-30k). Fehlend: TI-Anbindung, Datenmigration. Managed Services 837 €/Monat.

- [ ] Flo: Mail an Lambda/Martin für Verhandlungsgespräch
- [ ] Jens + Flo: Strategische Abstimmung Rahmenvertrag
- [ ] Friederike: Sabrinas Urlaub vs. KW 31/32 prüfen (On-site-Support)
- [ ] TI-Anbindung Kosten bei Lambda anfragen
- [ ] Klären: Datenmigration medatixx → Tomedo
- [ ] Pascom + Doc Medico Weiterleitung klären

## Tomedo-Migration KW 31

- [ ] Nikolai: Email Medizintechnik-Inventar, Video-Walkthrough, Raumplan, Labor-Info, WLAN-Details an Lambda
- [ ] Nikolai: Augustwoche (ab 3.8.) mit Familie blocken
- [ ] Florian: Harte PVS-Deadline konkretisieren
- [ ] Martin (Lambda): Angebot erstellen

## Telefonanlage

Wartungsvertrag bis 14.02.2027, wird zusammen mit PVS-Migration KW 31 (August) umgestellt. Checklisten-Deadline auf 01.08.2026 verschoben.

- **Betreuer:** Thilo Weckwerth (tetewe.de) — tw@tetewe.de
- [ ] Rechnung (20.02.) an Buchhaltung/Arved weiterleiten
- [ ] Neue Telefonlösung evaluieren (Deadline: vor 14.02.2027)

## EDV-Umstellung

- Workshop vor Sommerferien, Datum kommunizieren
- PVS-Entscheidung: Lütjensee als Pilot für Medatixx oder DocZeros
- Hardware-Erneuerung schrittweise nötig

## Website dr-muenchow.de

Live: hausarztzentrum-luetjensee.web.app. Custom Domain: Email an Olaf Reinhardt (Strato-Zugang) raus, Antwort abwarten. Plan: dr-muenchow.de + luetjensee.gomedicus.com → Firebase, alte Mobirise-Seite abstellen.

- [ ] HRB für Rhein-Neckar MVZ GmbH verifizieren
- [ ] Strato-Zugangsdaten abwarten → Firebase Custom Domain konfigurieren
- [ ] Datenschutz-Formular zum Download

## Kontakte & Partner

→ Obsidian `Arbeit/GoMedicus/Kontakte.md`

- Praxis: 04154-71 21 · Rezept: 04154-709 38 48 · Mo/Di/Do 8–18, Mi/Fr 8–12
- LANFOCUS (TI): Daniel Doobe — 040/65 65 665
- PC-Fun (IT): Olaf Rajek — 04552-999896

## BARMER — Gesicherte Mailverbindung

PGP-Setup steht.

- Alias-Datei (6 KKs): [Drive MedKitDoc](https://drive.google.com/file/d/1MkaainGdUrhsfDhwVYyUWFwuKdma60QJ/view)
- [ ] Slack an Friederike senden (SVLFG-Anleitung + aktualisierte Alias-Datei)

## Waiting On

- Olaf Rajek — IP→Sprechzimmer Mapping (Email 12.03.) ⚠️ stale
- Friederike — Tomedo-Import-Test (fehlende Felder 3108/4111/3110) ⚠️ stale seit 13.03.
- Philipp Gonser — ZDS Bürosysteme Feedback (Mail 05.02.) ⚠️ sehr stale
- Corti.ai / Adam Culbertson — Addendum v3 versendet (14.04.), Feedback abwarten. [v3 Doc](https://docs.google.com/document/d/1Z2voUKJNa3Q-DrM3vWtHTYjisSuWRd3YsOvgGTiPmnY/edit) — direkte Abhängigkeit zu [mkd-integration.md](mkd-integration.md) Phase 1 Corti-Features
- Seidemann IT Solutions — Admin-Zugang + Teamviewer Bisingen-Server (Email 17.04.)
