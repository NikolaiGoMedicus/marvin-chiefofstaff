---
project: luetjensee
status: active
owner: nikolai
updated: 2026-04-28
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

## Hardware-Inventar

✅ Ist-Aufnahme komplett + ✅ Mail an Lambda gesendet (02.04.): 9 PCs + 1 Laptop + 1 Server + 7 Monitore + 9 Drucker + 1 Scanner + 4 Kartenleser + 2 APs.

- Obsidian: `Projekte/Lütjensee/Hardware-Inventar-Luetjensee.md`
- ✅ Lambda-Angebot AG-4023 erhalten (09.04.) — Nachverhandlung läuft
- [ ] Talkmaster-PC Funktion klären
- **Hinweis SMC-B (24.04.):** Die 4 Kartenleser im Inventar sind nicht nach SMC-B vs. eGK differenziert — Inventar ist "Entwurf, Abgleich mit Franzi ausstehend". Für SMC-B-Info: Tomedo-Admin, LANFOCUS (Daniel Doobe, 040/65 65 665), oder Franzi direkt fragen.

## Stefan Haupt — Onboarding & Hardware

Stefan ist **Weiterbildungsassistent** (bezahlt nach Marburger Bund, Quelle: Lütjensee Status Update 16.03., Phillipp Gonser). Hauptsächlich Praxis vor Ort + gelegentlich Telemedizin von zuhause. AEKSH-Mitglied (Ärztekammer Schleswig-Holstein).

### Geräte-Setup
- **MacBook (Apple):** ✅ Im Einsatz seit ~25.03.2026 (Apple-Rechnung BD85087227, mit Antonia/Barbara/Jens beschafft). Use-Case Telemedizin (in Praxis + von zuhause). Voraussetzung war WLAN-Aufrüstung 14.03. durch Olaf Rajek (R260025).
- **Windows-Laptop:** Hardware vorhanden, Setup ausstehend (28.04.). Use-Case **ausschließlich medatixx x.comfort** (PVS-Doku, BDT-Import, Patienten-Neuanlage). Praxis lokal + VPN-Remote für gelegentliche Doku von zuhause.
- **Lifecycle-Plan:** Nach Tomedo-Migration (KW 31, ab 03.08.) wird der Windows-Laptop an **Henry Krause** weitergegeben (medatixx tot). Stefan arbeitet danach nur noch mit MacBook (Tomedo nativ + Telemedizin).

### Open Items (aktiv 28.04.)
- [ ] **medatixx-Ticket** an support.xcomfort@medatixx.de — x.comfort-Client-Install auf Windows-Laptop + Stefans User-Rechte für BDT-Import heben (Admin-/Power-User für Patientenstamm + BDT-Modul). Mail-Draft 28.04.
- [ ] **VPN-User „haupt"** über Olaf Rajek (PC-Fun, 04552-999896, Olaf@pc-fun.de) anlegen lassen — analog zu Arveds `schneider`. Mail-Draft 28.04. — **fehlt: Stefans Mobilnummer für SMS-PW**.
- [ ] **Telemedizin-Plattform** (MacBook-Track): Klären, was Lütjensee aktuell nutzt oder ob neu einzurichten — separater Track.
- [ ] **Stefan in Tomedo-Praxisfragebogen** ergänzen ([Notion-Draft](https://www.notion.so/34a57538249e81ba88b2d463cb9fc1d6)) — Behandler-Liste, eigener Arbeitsplatz, BDT-Workflow Tomedo-seitig validieren.
- [ ] **AEKSH-Kammerbeitrag**: Stefan-Mail an people@ vom 13.04. (cc Flo) — „Kosten einmalig übernehmen". Status nach 2 Wochen unklar, bei Flo/Buchhaltung nachfragen.

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

## Tomedo-Migration KW 28 (06.–10.07.) + KW 31 Telefon

**Angebots-Stand (Lambda-Thread):** Hardware-Inventar (9 PCs / 7 Mon / 9 Drucker / 4 Kartenleser / 2 APs / 9 Räume + Flos +1) ist 02.04. inline an Martin Hakenesch raus. Lambda-Angebot 09.04. (AG-4023) basiert darauf, MacMinis-Variante 27.04. zum Unterschreiben geschickt. Ball liegt bei Jens.

- [ ] **Jens: Lütjensee-Angebot (MacMinis-Variante, Jan-Mail 27.04.) unterschreiben**
- [ ] Nikolai: Augustwoche (ab 3.8.) mit Familie blocken
- [ ] Florian: Harte PVS-Deadline konkretisieren

### Konversions-Vorbereitung (für KW 28, nicht für Angebot)

Diese Punkte sind **kein Angebots-Blocker** — Lambda arbeitet im Angebot mit Puffer. Werden vor Ort / Walkthrough KW 28 gebraucht:
- [ ] Medizintechnik-Inventar erstellen
- [ ] Video-Walkthrough Praxis (1 Tag Aufwand)
- [ ] Raumplan / Grundriss
- [ ] Labor-Anbieter + Anbindung dokumentieren
- [ ] WLAN-Topologie (über die 2 AP-Modelle hinaus: SSIDs, VLANs)
- [ ] Telefonanlage-Modell + aktuelles Setup
- [ ] Stefan Haupt: BDT-Import-Workflow Tomedo-seitig validieren (Lambda-Walkthrough KW 28)

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

## Tomedo Praxisfragebogen (zollsoft)

Maria Schweinitz (zollsoft) will Praxisfragebogen für Lütjensee ausgefüllt haben (Flo-Mail 22.04., Gmail `19db55bd6bb20c87`). Konsolidierter Draft in Notion: [🧾 Tomedo® Praxisfragebogen — Drafts](https://www.notion.so/34a57538249e81ba88b2d463cb9fc1d6) (auch paeDOC). ~70% vorbefüllt.

- [ ] Lücken füllen: E-Mail-Adresse, vollständige Adresse, MA-Count, mobile APs, iPads, Laboranbindung, Telefonanlage-Modell, Diagnostik-Geräte-Ansprechpartner
- [ ] Klären: Betriebsstätten-Count (Großbaier Privatpraxis = eigene BSNR?), Stefan Haupt im Scope?
- [ ] Modul-Entscheidungen: 15 Module (Ja/Nein/Vielleicht)
- [ ] In Asana-Form abtippen: https://form.asana.com/?k=o58O1lEV_ECVJQbwY1g9vA&d=502525010300487

## Waiting On

- Corti.ai / Adam Culbertson — Addendum v3 versendet (14.04.), Feedback abwarten. [v3 Doc](https://docs.google.com/document/d/1Z2voUKJNa3Q-DrM3vWtHTYjisSuWRd3YsOvgGTiPmnY/edit) — direkte Abhängigkeit zu [mkd-integration.md](mkd-integration.md) Phase 1 Corti-Features
- Seidemann IT Solutions — Admin-Zugang + Teamviewer Bisingen-Server (Email 17.04.)
- Lambda Support (22.04.) — Ticket 1: Tunnelblick DNS-Warnung `fmichels` (Franziska Michel, unkritisch — Tomedo-Connection ok, Einschätzung erbeten). Ticket 2: VPN-Zugang Benjamin Heinke für read-only Tomedo-DB, Lütjensee als Startpunkt vorgeschlagen (Scope-Fragen offen). An support@lambda-itsystems.de + Paul Epple CC. → Nachhaken nach 2–3 Tagen falls keine Antwort.
