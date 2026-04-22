---
project: luetjensee
status: active
owner: nikolai
updated: 2026-04-22
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

## Angebotsanalyse Lambda vs. Systemhelden (20.04.)

Gegenangebot system-helden.de (Nabil Hiepler) für Lütjensee eingeholt (17.04., gültig bis 17.05.). ✅ Notion-Seite am 21.04. unter **🏥 Lütjensee — Standort-Profil & Integration** eingeordnet (vorher unter "Praxis-IT Rollout" im AI & Systems Office).

- **Notion-Analyse:** [1.2 Angebotsanalyse Lütjensee Lambda vs system-helden](https://www.notion.so/1-2-Angebotsanalyse-L-tjensee-Lambda-vs-system-helden-34857538249e81ff9ad9d58acdadd872)
- **Kennzahlen (netto, Vollumfang):**
  - Lambda AG-4023: **41.798 €** einmalig + **837 €/Monat** → 24M-TCO ~62.000 €
  - Systemhelden (V206099 + V206100): **31.524 €** einmalig + **416 €/Monat** → 24M-TCO ~41.500 €
  - Bereinigt (gleiche Leistungsbasis, ohne Schulung/Telefon): Einmal-Delta nur ~2.500 € → **Differenz kommt v.a. aus laufenden Kosten**.
- **Flos Framing an Nabil (20.04.):** "Bereinigt nehmen sich die Angebote nix" — Systemhelden fehlt einiges (Telefon, Monitore, Schulung). Antwort an Nabil ist raus.
- **Systemhelden Profil:** ~70 MA, tomedo-only seit 2014, ~350 Praxen / 4500 APs betreut. Kooperationen Stuttgart/Berlin/München für Vor-Ort-Service. Referenzen: Rick&Nick, Ortheum, Ortivity, Artemis, Verifymed. Alternativ-Modell: komplett managed (Infra + Macs mieten) → ~3.900 €/Monat.
- **Offene Hebel auf Lambda-Seite:** 80h→40h IT-Service (~4.914 € sparen), ggf. Telefonsystem streichen wenn Lütjensee behält (~1.526 € sparen).

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
- medatixx x.comfort Support: 0951 9335-300 (Mo–Fr 08–17, Sa 09–12) · support.xcomfort@medatixx.de — bis Tomedo-Migration KW 31 relevant

## BARMER — Gesicherte Mailverbindung

PGP-Setup steht.

- Alias-Datei (6 KKs): [Drive MedKitDoc](https://drive.google.com/file/d/1MkaainGdUrhsfDhwVYyUWFwuKdma60QJ/view)
- [ ] Slack an Friederike senden (SVLFG-Anleitung + aktualisierte Alias-Datei)

## Waiting On

- Corti.ai / Adam Culbertson — Addendum v3 versendet (14.04.), Feedback abwarten. [v3 Doc](https://docs.google.com/document/d/1Z2voUKJNa3Q-DrM3vWtHTYjisSuWRd3YsOvgGTiPmnY/edit) — direkte Abhängigkeit zu [mkd-integration.md](mkd-integration.md) Phase 1 Corti-Features
- Seidemann IT Solutions — Admin-Zugang + Teamviewer Bisingen-Server (Email 17.04.)
- Lambda Support (22.04.) — Ticket 1: Tunnelblick DNS-Warnung `fmichels` (Franziska Michel, unkritisch — Tomedo-Connection ok, Einschätzung erbeten). Ticket 2: VPN-Zugang Benjamin Heinke für read-only Tomedo-DB, Lütjensee als Startpunkt vorgeschlagen (Scope-Fragen offen). An support@lambda-itsystems.de + Paul Epple CC. → Nachhaken nach 2–3 Tagen falls keine Antwort.
