---
project: lms-edapp-ersatz
status: active
owner: nikolai
updated: 2026-04-30
tags: [work, lms, people, evaluation, decision-pending]
---

# LMS / Mitarbeiterschulungen (EdApp-Ersatz)

## Status

**Re-Eval 30.04.:** DSB-Constraint gelockert — Sebastian Schulz hat bestätigt: kein DE-/EU-Pflicht-Hosting nötig (nur Corporate-Mailadressen + Corporate-Schulungsdaten, kein PII). Optionsraum von 2 DE-Anbietern auf 6 internationale erweitert. Alte eLeDia-Empfehlung aus 29.04. zurückgezogen.

**Top 3 nach Re-Eval (30.04.):**

1. **TalentLMS Pro (Cyprus/US — Epignosis) — €8.300/Jahr** — Self-Service, +$6/extra User skaliert linear, B+ modern UX, SCORM rock-solid. **Primär-Empfehlung.**
2. **Coassemble Team (AUS) — €6.600/Jahr** — Self-Service, sehr modern UX, unlimited Learners, ABER 5-Creator-Limit + "50% Discount applied"-Promo (Risiko Verdopplung). **Wenn ≤5 Content-Creator + Promo dauerhaft:** Value-Sieger.
3. **360Learning (FR) — €15–18k/Jahr** — Sales-driven, AI + Collaborative Learning, native Personio. **Nur wenn:** AI-Mehrwert + native Personio + Collaborative-Learning strategisch genutzt werden.

**Raus aus dem neuen Topf:**
- Docebo (überdimensioniert, Min 250 User → bei 150 zahlt man trotzdem 250-User-Setup)
- Absorb LMS (€13–18k/J ohne klaren Mehrwert vs. 360Learning)
- Eurekos (Pricing zu intransparent für schnelle Decision; spannend, aber Sales-Cycle 2–3 Wochen)

**Raus aus altem Topf:**
- eLeDia Moodle (€1.800/J) — Moodle-UX disqualifiziert sich bei "modern UX"-Anforderung
- reteach (€2.388/J) — bei Wegfall DE-Constraint vs. 360Learning eine Liga unterhalb
- iSpring Learn — RAUS wegen RU-Heritage (HQ Cyprus, Engineering-Team Russland)

**Aktuelle Brücke:** TalentLMS Free-Tier (5 User) — wird ggf. zu Pro-Plan upgegradet (kein Bonus für Bestand bei Decision, aber operativ pragmatisch wenn Pick = TalentLMS).

## Decision-Setup für Arved + Flo

**Artefakt (Refresh 30.04.):** [Google Doc — LMS-Entscheidungsvorlage](https://docs.google.com/document/d/19-836LmBu96DDUjkkxOxSx5zrI2B8rgOSyOf5zf5XTY/edit)
- TL;DR, Was sich seit 29.04. geändert hat, Pricing-Matrix (6 Anbieter × 50/100/150/250 User), 1-Pager pro Anbieter, Empfehlung mit Decision-Tree, Migrationsplan, Risiken, 5 Decision-Fragen, Anhang
- Pricing-Daten: Listenpreise (TalentLMS, Coassemble) + Vendr-Marketplace echte Contract-Werte (360Learning $28.872 Median, Docebo $40.390 Median über 124 Käufe, Absorb $20k Median über 49 Käufe)
- Empfehlung: TalentLMS Pro als Default; Coassemble wenn 5 Creator reichen + Promo dauerhaft; 360Learning wenn AI/Personio/Collaborative kritisch

**Beteiligte:**
- Nikolai (Eval, Empfehlung)
- Arved Schneider (CFO, Budget-Freigabe)
- Florian Kleinau (HR-Owner, MA-Roll-out)
- Sebastian Schulz (DSB, AVV-Sichtprüfung — Constraint mündlich 30.04. freigegeben)

## Migration-Fortschritt (Vorarbeit)

- ✅ **SCORM-Export aller 6 Kurse (14.04.):** Via EdApp API extrahiert + als SCORM 1.2 verpackt. ZIPs in `~/Downloads/`: gomedicus-tomedo-grundlagen, gomedicus-arzeko, benutzung-der-softwaretools, hzv-patienteneinschreibung, gomedicus-willkommen + original abrechnungsschulung.
- ✅ **Alle 6 SCORM-Pakete gefixt (15.04.):** Exit-Slides gestrippt, Completion-Slides angehängt, EdApp-Spezifika konvertiert. Alle `-FIXED.zip` in `~/Downloads/`. **Portabel** — funktionieren in jedem Standard-LMS.
- ✅ **Markt-Re-Eval (29.04.):** 12 deutsche Anbieter bewertet, US-Tools ausgeschlossen, Top 2 identifiziert.
- ✅ **Constraint-Reset (30.04.):** DSB-Freigabe für non-DE/EU-Anbieter. Optionsraum auf 6 internationale Top-Player erweitert.
- ✅ **Pricing-Matrix gebaut (30.04.):** 6 Anbieter × 50/100/150/250 User. Listenpreise + Vendr-Median + Schätzungen für Sales-Driven mit Quellenangabe.
- ✅ **Decision-Doc Refresh (30.04.):** Bestehendes Google Doc komplett überarbeitet — neue TL;DR, Pricing-Matrix, 1-Pager pro Anbieter, Decision-Tree, Migrationsplan TalentLMS Pro, Risiken-Mitigation.

## Pricing-Snapshot (30.04.)

| Anbieter | Modell | 150 User/J | €/Lizenz/J | Quelle |
|----------|--------|------------|------------|--------|
| Coassemble Team | Self-Service | €6.600 | €44 | Listenpreis |
| TalentLMS Pro | Self-Service | €8.300 | €55 | Listenpreis |
| Eurekos | Sales | €5–12k | €30–80 | GetApp + Schätzung |
| Absorb LMS | Sales | €13–18k | €85–120 | Vendr Median $20k |
| 360Learning | Sales | €15–18k | €100–120 | Vendr Median $28.872 |
| Docebo | Sales (Min 250) | €25–30k | €170–200 | Vendr Median $40.390 |

## Open Items

- [ ] **Decision mit Arved + Flo:** Doc-Link teilen, Entscheidung anhand Decision-Tree (3 Fragen)
- [ ] **TalentLMS-Sales-Quote (falls Pick = TalentLMS):** 150-User-Tier exakt bestätigen via Email (1 Tag Reaktion)
- [ ] **Coassemble-Sales-Klärung (falls Pick = Coassemble):** "50% Discount applied" — dauerhaft oder Promo? Email
- [ ] **Bei Pick:** Buchung + 6 SCORM-Pakete migrieren (1–2 Tage Setup)
- [ ] **Sebastian Schulz (DSB):** AVV-Sichtprüfung schriftlich nach Vertragsabschluss (~1h)
- [ ] **TalentLMS Free 30 Tage parallel laufen lassen**, dann kündigen oder upgraden
- [ ] **Flo informieren:** Lütjensee-MA-Schulungen können nach Migration starten
