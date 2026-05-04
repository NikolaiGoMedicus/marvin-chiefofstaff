---
project: ak-takeda
status: active
owner: nikolai
updated: 2026-05-04
tags: [work, arztkonsultation, takeda, sharepoint, reporting]
---

# arztkonsultation (ak) / Takeda — SharePoint Report

## Status

Stefanie Schalitz (IT-PM ak) hat gefragt, wie das technische Update eines SharePoint-Report-Sheets laufen soll. Approach geklärt: Editor-Rechte auf die Datei (analog Friederike, die bereits Editor-Rechte hat) → Claude/Nikolai schreibt über Nutzerrolle rein, kein Azure-/App-Setup nötig. Email an Steffi + Christian Schneider 04.05. gesendet.

**Nächster Schritt:** Nikolai klärt mit Friederike das konkrete Setup (welche SharePoint-Datei, welche Rolle), dann Update an Steffi.

## Context / Notes

- Nikolais initiale Frage nach "API Key" war technisch unsauber — MS 365 nutzt OAuth2 / Azure AD, keine klassischen API Keys.
- Friederike hat bereits Editor-Rechte auf die relevante Datei → ihr Pattern ist der Ansatz.
- Verbundener älterer Thread: BDT-Endpoint-Spec mit Steffi (Session 2026-03-20).

## Open Items

- [ ] Mit Friederike klären: konkretes SharePoint-Datei-Setup + welche Rechte Nikolai braucht
- [ ] Update an Steffi Schalitz nach Friederike-Klärung

## Waiting On

- Friederike — Klärung SharePoint-Setup (noch nicht angefragt, nach ak-Steffi-Email 04.05.)

## Links

- Stefanie Schalitz (IT-PM ak): stefanie.schalitz@arztkonsultation.de (vermutl.)
- Christian Schneider (CC auf 04.05.-Email)
