---
project: lms-edapp-ersatz
status: active
owner: nikolai
updated: 2026-04-21
tags: [work, lms, people, evaluation]
---

# LMS / Mitarbeiterschulungen (EdApp-Ersatz)

## Status

**EdApp wird zum 20.04. eingestellt.** SafetyCulture-Migration nur Free bis 10 User. Flo braucht System für Lütjensee-MA-Schulungen.

- **Evaluation:** Obsidian `Projekte/LMS-Evaluation-EdApp-Ersatz.md` — Shortlist: TalentLMS (Empfehlung), Haekka (Slack-native), SC Training, ILIAS, 360Learning
- **Empfehlung:** TalentLMS Starter ($69/Mo, 40 User, SCORM-Import, sofort produktiv)
- **Meeting:** 15.04. mit Sebastian Luitle (30 Min, nur EdApp-Thema)
- **anonymerhinweis@gomedicus.com** — Eingerichtet von Sebastian L. (14.04.)

## Migration-Fortschritt

- ✅ **SCORM-Export aller 6 Kurse (14.04.):** Via EdApp API extrahiert + als SCORM 1.2 verpackt. Tomedo-Grundlagen in TalentLMS getestet — funktioniert. Alle ZIPs in `~/Downloads/`: gomedicus-tomedo-grundlagen, gomedicus-arzeko, benutzung-der-softwaretools, hzv-patienteneinschreibung, gomedicus-willkommen + original abrechnungsschulung.
- ✅ **TalentLMS Free-Tier registriert (14.04.):** Erster SCORM-Import erfolgreich getestet.
- ✅ **Alle 6 SCORM-Pakete importiert (15.04.)** in TalentLMS.
- ✅ **Alle 6 SCORM-Pakete gefixt (15.04.):** Exit-Slides (53 Stück) gestrippt, finale Completion-Slides angehängt, expandable-list → scrolling-media konvertiert (12), image-galleries → scrolling-media (2), EdApp-Surveys gedroppt (9), EdApp-Spiele → Reflexions-Slides (5), Softwaretools-Intro-Title vorangestellt. Videos (4 in Willkommens-Kurs) als Hinweis-Slides markiert. Alle `-FIXED.zip` in `~/Downloads/`.

## Open Items

- [ ] Smoke-Test: Alle 6 FIXED-Kurse neu hochladen + durchklicken
- [ ] **Sebastian liefert Videos nach** für Willkommens-Kurs (E-Mail Warum + Wie, Slack Warum + Wie) → in 4 Hinweis-Slides einbauen
- [ ] Entscheidungs-Doc für Flo (Free vs. Starter $69/Mo vs. Plus $279/Mo) — Kernfrage: 125 MAs alle rein oder Rotation? Compliance-Tracking-Pflicht klären
- [ ] Abrechnungsschulung durchklicken (hat 3 unbekannte Slide-Typen `list`, `scrollable`, `image` — können stocken)
- [ ] Entscheidung Fr 18.04.
- [ ] Nach Entscheidung: Migration + Flo informieren
