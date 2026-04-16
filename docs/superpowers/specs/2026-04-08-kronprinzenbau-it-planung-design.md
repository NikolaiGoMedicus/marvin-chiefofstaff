# Kronprinzenbau IT-Planung — Design Spec

**Datum:** 2026-04-08
**Owner:** Nikolai (CDIO)
**Status:** Draft

## Context

GoMedicus eröffnet am 01.08.2026 eine neue Allgemeinmedizin-Praxis im Kronprinzenbau, Reutlingen (Listplatz 1). Der Standort entsteht durch Zusammenlegung der Praxen Kaiserstraße + Tübingerstraße. Start auf halber Fläche, volle Nutzung bis Januar 2027.

IT-Installation durch Lambda: 20.-23. Juli, Abnahme 24. Juli. Lambda ist "hart ausgebucht" — Lütjensee-Konversion liegt direkt davor (KW 28, 06.-10. Juli).

Nikolai muss bis 30.04. die IT-Ausstattung definieren, damit Lambda ein Angebot erstellen kann. Dieses Spec definiert die drei Deliverables dafür.

## Deliverables

### 1. Notion IT-Unterseite

Neue Seite **"🖥️ IT & Digitalisierung"** als Unterseite der bestehenden Kronprinzenbau-Hauptseite.

**Sektionen:**

#### 1.1 Owner & Taskforce
Tabelle:
| Person | Rolle | Kontakt |
|--------|-------|---------|
| Nikolai | IT-Strategie, Lambda-Koordination, Telefonie | nikolai@gomedicusgroup.com |
| Michael Füllemann | Hardware-Inventar, Medizingeräte, Projektleitung gesamt | |
| Lambda IT (Martin) | PVS-Installation, Netzwerk, TI, Hardware-Rollout | |

#### 1.2 Status-Banner
"In Planung — IT-Definition bis 30.04., Installation 20.-23.07."

#### 1.3 Raumplan IT
Zusammenfassung aus dem Rauminfrastruktur-Spreadsheet. Tabelle mit allen Räumen, Netzwerkdosen, Arbeitsplätzen. Summen: ~120 Netzwerkdosen, ~26 Arbeitsplätze.

Räume im Detail:

| Bereich | Räume | Netzwerkdosen | Arbeitsplätze |
|---------|-------|---------------|---------------|
| Empfang Zentral | 1 | 9 | 3 |
| Empfang Süd | 1 | 4 | 1 |
| Backoffice | 1 | 8 | 3 |
| Sprechzimmer West (1-4) | 4 | je 5 = 20 | 4 |
| Sprechzimmer Süd (5-8) | 4 | je 5 = 20 | 4 |
| Arztzimmer (S1-S5) | 5 | je 4 = 20 | 5 |
| Funktionsräume (1-2) | 2 | je 6 = 12 | 2 |
| Labor (Süd) | 1 | 4 | 1 |
| Urin-Labor (West) | 1 | 3 | 0 (kein Rechner) |
| Telemedizinräume (1-2) | 2 | je 3 = 6 | 0 (Spezial-Setup) |
| BE/Infusion (1-2) | 2 | je 2 = 4 | 2 |
| Wartebereiche (West + Süd) | 2 | je 3 = 6 | 0 |
| Küchen (West + Süd) | 2 | je 2 = 4 | 0 |
| Technikraum | 1 | — | 0 |
| **Gesamt** | | **~120** | **~26** |

#### 1.4 Netzwerk & Infrastruktur

**Konnektor/TI:**
- Neue Betriebsstättennummer nach Zulassungsausschuss 23.06.
- Konnektor-Routing für E-Rezept + eAU an jedem Arbeitsplatz
- Jeder Rechner muss individuell konfiguriert werden (Learning Lütjensee: aufwändig)

**WLAN (2-SSID-Pattern aus Lütjensee):**
- Praxis-WLAN (WPA3, Staff only)
- GoMedicus-Gast (WPA2/3 mixed, Patienten)
- VLAN-Trennung
- AP-Planung: Mindestens 2 APs (West + Süd), ggf. 3 je nach Fläche

**Server/Backup:**
- Tomedo-Server (Mac oder VM — mit Lambda klären)
- Backup-Konzept definieren (Learning Lütjensee: fehlte)

#### 1.5 Arbeitsplatz-Standard pro Raumtyp

| Raumtyp | PC/Mac | Monitor | Drucker | Kartenleser | Sonstiges |
|---------|--------|---------|---------|-------------|-----------|
| Empfang Zentral | 3x | 3x Curved 100cm (eingelassen) | 1x Netzwerk + 1x Rezept | 2x eGK | Steharbeitsplatz |
| Empfang Süd | 1x | 1x | — | — | Steharbeitsplatz |
| Backoffice | 3x | 3x | 1x Drucker/Kopierer + 1x Scanner | — | |
| Sprechzimmer | je 1x | je 1x | je 1x Rezeptdrucker | — | |
| Arztzimmer | je 1x | je 1x | — | — | |
| Funktionsraum | je 1x | je 1x | — | — | Medizingeräte-Anschlüsse |
| Labor | 1x Steh | 1x | — | — | Notebook laborfähig |
| BE/Infusion | je 1x | je 1x | — | — | |

#### 1.6 Medizingeräte → Tomedo-Anbindung

Aus dem Medizingeräte-Spreadsheet (Spalte Kronprinzenbau):

| Gerät | Status | Anbindung |
|-------|--------|-----------|
| Sono stationär + Echo-Schallkopf | Neuanschaffung | Tomedo |
| Clarius Sono mobil (iPad) | Aus Kaiserstraße | Standalone |
| Langzeit-RR (AMEDTEC ECGpro) | Neuanschaffung | Tomedo |
| EKG (Schiller Cardiovit FT-2 Wifi) | Neuanschaffung | Tomedo |
| LuFu | Neuanschaffung | Tomedo |
| Ergometer + Belastungs-EKG | Neuanschaffung | Tomedo |
| Sauganlage (Strässle DT80) | Neuanschaffung | — |

#### 1.7 Telefonie
- Neuer Telefonservice-Dienstleister (seit KW 14)
- Anforderungen: Leitungen pro Empfang + Arztzimmer, IVR/Routing
- Nikolai als Owner, Deadline 30.04.

#### 1.8 Telemedizin-Setup (2 Räume)
Pro Raum:
- Bildschirm mit Kamera (~800€)
- Rechner (~800€)
- Lautsprecher + Mikrofon (~150€)
- Akustik-Wandverkleidung (~1.000€)
- Konsolentisch + Sessel + Pflanzen
- Netzwerk: 3 Dosen pro Raum

#### 1.9 Offene Entscheidungen

| Entscheidung | Wer | Bis wann | Status |
|-------------|-----|----------|--------|
| Hardware-Inventar Kaiserstr./Tübingerstr. | Michael | 18.04. | ⬜ Offen |
| Netzwerk-Preset Lambda (analog Lütjensee?) | Nikolai + Lambda | 18.04. | ⬜ Offen |
| Server-Typ: Mac vs. VM vs. Cloud | Nikolai + Lambda | 30.04. | ⬜ Offen |
| Neue BSNR: Wann verfügbar? | Philipp (KV) | 23.06. | ⬜ Abhängig von ZA |
| Paddock-Geräte: Wann umbauen? | Michael + Lambda | 01.08. | ⬜ Offen |
| Telefonanlage: Welcher Anbieter/Modell? | Nikolai | 30.04. | ⬜ Offen |
| AP-Anzahl/Positionierung | Nikolai + Lambda | 30.04. | ⬜ Offen |

#### 1.10 Kontakte & Partner

| Partner | Kontakt | Zuständigkeit |
|---------|---------|---------------|
| Lambda IT | Martin Hakenesch | PVS, Netzwerk, Hardware, TI |
| (lokaler IT-Partner tbd) | — | Vor-Ort-Support nach Installation |

#### 1.11 Timeline

| Datum | Meilenstein |
|-------|-------------|
| 09.04. | Lambda-Call (Lütjensee + Kronprinzenbau ansprechen) |
| 18.04. | Hardware-Inventar Bestand von Michael |
| 30.04. | IT-Definition komplett (Nikolai) |
| 15.05. | Lambda-Angebot eingeholt |
| 23.06. | Zulassungsausschuss → neue BSNR |
| 06.-10.07. | Lütjensee Konversion (Lambda) |
| 20.-23.07. | **Kronprinzenbau IT-Installation** |
| 24.07. | Abnahme / Testing |
| 28.07. | Mitarbeiterschulung |
| 01.08. | **Betriebsstart** |

---

### 2. Aufgaben-DB verfeinern

Bestehende 2 IT-Tasks bleiben als Meilensteine. Neue granulare Tasks:

| Task | Phase | Owner | Deadline |
|------|-------|-------|----------|
| Hardware-Inventar Kaiserstr./Tübingerstr. einsammeln | Phase 1 | Michael | 18.04. |
| Netzwerk-Konzept mit Lambda klären | Phase 1 | Nikolai | 18.04. |
| Arbeitsplatz-Standard pro Raumtyp definieren | Phase 1 | Nikolai | 25.04. |
| TI-Setup planen (neue BSNR nach 23.06.) | Phase 1 | Nikolai | 30.04. |
| Telefonie-Lösung festlegen | Phase 1 | Nikolai | 30.04. |
| WLAN-Planung (APs, SSIDs, VLANs) | Phase 1 | Nikolai | 30.04. |
| Medizingeräte-Anbindung Tomedo spezifizieren | Phase 1 | Nikolai + Michael | 30.04. |
| Telemedizinraum-Setup spezifizieren | Phase 1 | Nikolai | 30.04. |
| Lambda-Angebot einholen | Phase 2 | Nikolai | 15.05. |
| IT-Installation koordinieren (20.-23.07.) | Phase 4 | Nikolai | 20.07. |

---

### 3. Lambda IT-Anforderungsdokument (Notion-Unterseite)

Eigene Notion-Seite **"📋 IT-Anforderungen für Lambda"** unter der IT-Unterseite. Enthält alles was Lambda für ein Angebot braucht:

1. Projektübersicht (Standort, Praxistyp, Start 01.08.)
2. Raumplan mit IT-Bedarf pro Raum
3. Arbeitsplatz-Spezifikation pro Raumtyp
4. Netzwerk-Anforderungen (~120 Dosen, Konnektor-Routing, 2 SSIDs)
5. TI-Anforderungen (neue BSNR, Konnektor für alle Plätze)
6. Medizingeräte-Liste mit Tomedo-Anbindung
7. Telefonie-Anforderungen
8. Telemedizin-Setup (2 Räume)
9. Hardware-Bestand (Platzhalter → Michael)
10. Strategische Entscheidung: Neue Geräte für Kronprinzenbau, alte → Paddock ab 01.08.
11. Timeline: Installation 20.-23.07., Abnahme 24.07.
12. Abhängigkeiten: Lütjensee KW 28 direkt davor, Lambda-Kapazität knapp

---

## Lütjensee-Learnings eingearbeitet

- ✅ Konnektor-Routing-Komplexität dokumentiert
- ✅ 2-SSID-WLAN-Pattern übernommen
- ✅ Hardware-Inventar proaktiv bei Michael angefragt (nicht warten)
- ✅ Lambda-Kapazität als Risiko benannt
- ✅ Backup-Konzept als offene Entscheidung (fehlte bei Lütjensee)
- ✅ Kontakte/Partner-Sektion (Single-Point-of-Contact-Risiko)
- ✅ Server-Deployment-Reihenfolge in Timeline

## Verification

Nach Umsetzung prüfen:
1. IT-Unterseite in Notion erreichbar unter Kronprinzenbau-Hauptseite
2. Alle Tabellen korrekt formatiert und Daten aus Spreadsheets übernommen
3. ~10 neue Tasks in der Aufgaben-DB mit korrekten Owners, Deadlines, Phasen
4. Lambda-Anforderungsdokument als Unterseite verlinkt
5. Morgen beim Lambda-Call: Nikolai kann die Notion-Seite als Referenz nutzen
