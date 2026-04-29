---
project: lms-edapp-ersatz
status: active
owner: nikolai
updated: 2026-04-29
tags: [work, lms, people, evaluation, decision-pending]
---

# LMS / Mitarbeiterschulungen (EdApp-Ersatz)

## Status

**Re-Eval 29.04.:** Ursprüngliche Empfehlung TalentLMS hinfällig. User-Zahl korrigiert auf 150 (statt 40), US-Hersteller raus (Datenresidenz), DE-only Anforderung. Decision verschoben auf 30.04. mit Arved + Flo.

**Top 2 nach Re-Eval:**
- **eLeDia Moodle (Erfurt) — €1.800/Jahr** (250-User-Paket, 3-Monats-Abo möglich, AVV+DSGVO+DE-Hosting)
- **reteach (Berlin) — €2.388/Jahr** (Essential-Tier, modern, native Personio-Integration)

**Empfehlung:** eLeDia Moodle. €1.764 Ersparnis über 3 Jahre, robusterer SCORM-Standard, etablierter Anbieter (20J), 3-Monats-Test risikoarm.

**Aktuelle Brücke:** TalentLMS Free-Tier (5 User) läuft als Übergang nach EdApp-Abschaltung 20.04. — wird 30 Tage parallel zur neuen Lösung gefahren, dann gekündigt.

## Decision-Setup für 30.04.

**Artefakt:** [Google Doc — LMS-Entscheidungsvorlage](https://docs.google.com/document/d/19-836LmBu96DDUjkkxOxSx5zrI2B8rgOSyOf5zf5XTY/edit)
- Geteilt mit Arved + Flo (writer, ohne Notification — Slack-Draft mit Link an Arved separat)
- Inhalt: TL;DR, Hintergrund, Optionsraum (12 Anbieter gescannt), Top-2-Vergleich nach 16 Kriterien, Compliance-Bewertung, Empfehlung, Migrationsplan, Risiken, 5 Decision-Fragen

**Beteiligte:**
- Nikolai (Eval, Empfehlung)
- Arved Schneider (CFO, Budget-Freigabe)
- Florian Kleinau (HR-Owner, MA-Roll-out)
- Sebastian Schulz (DSB, AVV-Freigabe — folgt nach Decision)

## Migration-Fortschritt (Vorarbeit)

- ✅ **SCORM-Export aller 6 Kurse (14.04.):** Via EdApp API extrahiert + als SCORM 1.2 verpackt. ZIPs in `~/Downloads/`: gomedicus-tomedo-grundlagen, gomedicus-arzeko, benutzung-der-softwaretools, hzv-patienteneinschreibung, gomedicus-willkommen + original abrechnungsschulung.
- ✅ **Alle 6 SCORM-Pakete gefixt (15.04.):** Exit-Slides gestrippt, Completion-Slides angehängt, EdApp-Spezifika konvertiert. Alle `-FIXED.zip` in `~/Downloads/`. **Portabel** — funktionieren in jedem Standard-LMS.
- ✅ **Markt-Re-Eval (29.04.):** 12 deutsche Anbieter bewertet, US-Tools ausgeschlossen, Top 2 identifiziert.

## Marktscan-Ergebnis (29.04.)

**Direkte SaaS-LMS (DE/EU):** reteach (Top 2), elearnio, keelearning (€5.628/J zu teuer), avendoo (Enterprise), chemmedia (Großkunden)
**Open-Source managed:** eLeDia Moodle (Top 2), DM Solutions (DIY), qualitus ILIAS (Anfrage, Angebot kommt nach 30.04.)
**Compliance-Content:** lawpilots, mybreev (passt nicht zu eigenen Kursen)
**Ausgeschlossen:** TalentLMS, SC Training, Haekka, 360Learning, SAP, Personio Trainings allein

## Open Items

- [ ] **Slack-Heads-Up an Arved senden** (Draft im Session-Log 29.04.)
- [ ] **Decision-Termin 30.04.:** Arved + Flo + Nikolai zur LMS-Entscheidung
- [ ] **Bei Entscheidung eLeDia:** 3-Monats-Abo buchen (€450), 6 SCORM-Pakete migrieren (1-2 Tage)
- [ ] **Sebastian Schulz (DSB):** AVV-Vorab-Check (~1h Aufwand) **nach** Decision
- [ ] **TalentLMS Free 30 Tage parallel laufen lassen**, dann kündigen
- [ ] **Flo informieren:** Lütjensee-MA-Schulungen können nach Migration starten
