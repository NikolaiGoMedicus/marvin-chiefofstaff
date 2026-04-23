---
project: platform-analytics
status: active
owner: nikolai
updated: 2026-04-23
tags: [work, platform, analytics, dsgvo]
---

# Platform Analytics & Session Recording

## Status

Strategische Entscheidung 23.04.: PostHog-Empfehlung aus dem Research-Brief zurückgezogen. 3-Phasen-Strategie beschlossen. Plausible bereits in Umsetzung (Event-Spec-Ausbau läuft).

## Strategie: 3-Phasen-Modell (beschlossen 23.04.2026)

**Phase 1 — Plausible maximieren (jetzt, ~6 Wochen)**
- Event-Spec maximal ausbauen: alle relevanten User-Events sauber spezifizieren und tracken
- Ziel: Datengrundlage verbessern, bevor Tool-Wechsel evaluiert wird
- Status: in Umsetzung

**Phase 2 — Matomo Self-Hosted evaluieren**
- Upgrade-Kandidat nach Phase 1 (steht bereits im Analytics-Evaluation-Doc als Upgrade-Pfad)
- Bewertungskriterien: DSGVO-Compliance (HIPAA-Leitfaden), Heatmaps, Session Recording
- Erst evaluieren wenn Plausible-Potenzial ausgeschöpft

**Phase 3 — PostHog (nur wenn Matomo nicht reicht)**
- PostHog war ursprünglich aus DSGVO-Gründen raus — Re-Einsetzen wäre inkonsistent
- Nur als Option wenn Phase 2 scheitert

## Hintergrund

- Meeting 23.04. 10:30 mit Tim-Ole + Jens: u.a. AI Workflow & Session Recording besprochen
- Research-Brief hatte PostHog empfohlen → inhaltlich zurückgezogen (DSGVO-Inkonsistenz)
- Matomo steht im bestehenden Analytics-Evaluation-Doc als Upgrade-Option

## Open Items

- [ ] Plausible Event-Spec: alle relevanten Events definieren und implementieren (Phase 1, ~6 Wochen)
- [ ] Analytics-Evaluation-Doc mit 3-Phasen-Entscheidung aktualisieren
- [ ] Phase-2-Entscheidungskriterien für Matomo schriftlich festhalten (HIPAA/DSGVO, Heatmaps, Session Recording)

## Context / Notes

Tim-Ole + Jens Meeting 23.04. 10:30 hatte drei Themen: (1) Notion Intranet Architecture, (2) Claude Skills Program, (3) AI Workflow & Session Recording. Die PostHog-Kehrtwende basiert auf DSGVO-Konsistenz-Argument: PostHog war bereits ausgeschlossen, ein Re-Einführen ohne neue Compliance-Basis wäre inkonsistent. Matomo self-hosted ist der logische nächste Schritt nach Plausible.
