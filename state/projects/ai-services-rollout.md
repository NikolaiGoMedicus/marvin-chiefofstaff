---
project: ai-services-rollout
status: active
owner: nikolai
updated: 2026-04-22
tags: [work, ai, enablement, priority]
---

# AI Services Rollout

## Status

T1 fertig (Ø Sicherheit 3,1/5). Office Hours Do 15:00 weekly (ab 16.04.). Nächste: T2 Form an Basti+Jens (~21.04.), Prompt-Workshop planen. **Ownership:** Nikolai (Enablement) + Flo (OKRs).

## Teilnehmer

- **Ricarda Staar** — Setup-Session 16.04. 15:30. [Rollenseite](https://www.notion.so/34357538249e81e68722ccaf8de6e91e)
- **Sabrina Deffner** — Kernbedarf = Use-Case-Discovery (nicht Setup). [Rollenseite](https://www.notion.so/34357538249e8127b094f0e614343b20)
- **Antonia Gebhardt** — Stufe 2 gestartet (15.04.), Check-in 22.04. 10:00. [Rollenseite](https://www.notion.so/33b57538249e81319fb6cadaad9a5eb2). T1 nachholen. **22.04.:** Pro-Upgrade nötig geworden (Limit erschöpft = starkes Adoption-Signal). Hat [Reporting-Sheet](https://docs.google.com/spreadsheets/d/1vQ5ng5dUc4KpEWyLkfZLEzo-eywpbe0bXhIhAlvZSWA/edit) geliefert — 3-Horizonte-Framework (Heute/Quick Fix/Claude-Layer/Plattform) für 4 Reporting-Prozesse (AK/eTermin, Zanadio, SV KVT/MKD, SV MV/BB/MKD) + 5 offene Fragen. Call-Plan siehe unten.
- **Thomas Flieger** — ⚠️ Pipedrive MCP hat seit 09.04. NIE funktioniert ("Failed to spawn process: No such file or directory" — kein Node.js + Claude Desktop erbt kein Shell-PATH). Meeting 20.04. 09:30–10:10: Node LTS installiert, PATH-Fix (.zshrc export /usr/local/bin), Shell-Wrapper-Config bereitgestellt. Verifikation nach Neustart ausstehend.
- **Janina Huebsch** — ✅ Setup komplett. Pipedrive Anrede-Problem: Custom-Feld "Begrüßung" anlegen + testen vor Di 21.04. [Webinar-Guide](https://docs.google.com/document/d/1y86DSiPAij2zw6SwI3ALhZcdAQGqOrZRK9gQIAfG8OE/edit)

## Thomas Flieger Follow-ups (16.04. + 20.04.)

- [ ] Thomas: Pipedrive MCP nach Neustart verifizieren (Node LTS + Shell-Wrapper-Config)
- [ ] Grit-Anbindung: mit Sebastian klären (Thomas braucht Grit als weitere Vertriebskraft, volle Pipedrive-Anbindung)
- [ ] Workflow ↔ Pipedrive-Schnittstelle: Automatisierungsoptionen ermitteln
- [ ] Korian-Verknüpfungsfehler: Duplikate konsolidieren (Korian AG Deutschland ID 354 + Töchter + 2x Intensivpflege). Dr. Schulz (Medical Director Korian, 229 Einrichtungen) hat eingehend Nachfrage gestellt → **Wiedervorlage 21.04.**
- [ ] Nächste Thomas-Session: UC1 Korian-Cleanup live, UC2 Webinar-Follow-up-Demo, UC3 1100 Alt-Deals Reaktivierung als Homework

## Offene Setups

- [ ] Sebastian L.: Google Auth + 30 Plesk E-Mail-Adressen ([Anleitung](https://docs.google.com/document/d/10_OZwtcmvcH1lcqLGZliPsJuMEF2RDcFxyZGEXmQIgE/edit))
- [ ] Google Cloud App auf Production schalten (16 User aktiv)
- [ ] Phil: DXT deinstallieren + Config mit vollem uvx-Pfad

## Nächste Schritte

- [ ] T1-Auswertung an Flo teilen
- [ ] T2 Form: Vorschau prüfen, auf 16 Namen erweitern, an Basti+Jens (~21.04.). [Form](https://docs.google.com/forms/d/18FEtF2zVqjbUpCmgZnhNNqCb7Pc9BOq7mMYZcNuyv_k/edit)
- [ ] Prompt-Workshop planen
- [ ] Antonia-Call 22.04. durchführen (siehe Antonia-Sektion unten)
- [ ] T1-Befragung Antonia nachholen
- [ ] Jens: Ownership "Prozess & Adoption" (Alice-Nachfolge)
- [ ] Agent-Demo für Basti, Henry, Jens — **Kandidat: Zanadio-Versand-Workflow** (aus Antonias Sheet)

## Antonia Operations Reporting (ab 22.04.)

**Input:** [Sheet *Optimierung Reporting Digital Operations*](https://docs.google.com/spreadsheets/d/1vQ5ng5dUc4KpEWyLkfZLEzo-eywpbe0bXhIhAlvZSWA/edit) — 4 Prozesse × 4 Horizonte + 5 offene Fragen.

**Sechs Hebel aus Prep-Session 22.04.:**

1. **3-Horizonte-Framework als T2-Deliverable-Template** für die anderen 16 Teilnehmer nachbauen lassen.
2. **Quick Wins heute:** Tomedo-Statistik AK+Zanadio (identisches Rückgrat: Terminart-Kürzel + Verordnungstext-Filter) — heute ohne Claude machbar, sofort Zeit sparen, Adoption-Multiplier.
3. **Zanadio = Agent-Demo-Case** (ersetzt künstlichen Demo für Basti/Henry/Jens): Tomedo-Export → Einwilligung prüfen → conditional Anonymisierung → PDF-Template → verschlüsselter Versand.
4. **Plattform-Spalte → Linear-Epic "Operations Reporting"** — 4 Feature-Specs mit Akzeptanzkriterien, verlinkt mit MKD-Integration-Roadmap.
5. **5 offene Fragen als Team-Mapping:**
   - Datenschutz → existierender Leitfaden + Jens als Adoption-Owner
   - Rezept↔AK-Zuordnung → Basti/Dev (Produktfrage)
   - Tomedo "nicht stattgefunden"-Status → Tomedo-Support
   - Folgetermin-Identifikation → Tomedo-Logic
   - MKD-Plattform-Datenfluss → MKD-Integration-Roadmap
6. **Antonia als Lead "Operations-Reporting-Track"** im AI Playbook — falls sie im Call zustimmt, dokumentiert Learnings dort + präsentiert Blueprint im Team.

**Call-Struktur 30 min:** 5' Framing + Lob → 8' Quick-Win-Entscheidung → 10' Zanadio-Agent-Case → 5' Offene-Fragen-Mapping → 2' Commitments.

**Open (nach Call):**
- [ ] Commitments festzurren + hier dokumentieren
- [ ] Linear-Epic "Operations Reporting" anlegen (4 Kinder-Issues aus Sheet-Spalte 4)
- [ ] Offene Fragen an jeweilige Owner dispatchen
- [ ] T2-Template aus Antonias Matrix ableiten und an die anderen T2-Teilnehmer geben

## Claude Skills Library

- [Skills Program](https://www.notion.so/33f57538249e811782e0cad8c575d3ef) — technisch korrigiert, unter AI Playbook
- [ ] Jens: Working Session Corporate Document Style
- [ ] Erstes Claude Project "GoMedicus Corporate Docs" aufsetzen

## Offene Initiativen

- [ ] CEO Onboarding (Jens), GF Onboarding (Philipp), OKRs mit Flo

## Links

- [AI Org](https://www.notion.so/2fd57538249e804abc35fb9d874b2829)
- [AI Playbook](https://www.notion.so/34357538249e814688cfdb0434dc973f)
- [Prompt-Bibliothek](https://www.notion.so/33057538249e8163960ce8e02607ff32)
- [Datenschutz-Leitfaden](https://www.notion.so/33057538249e81e69759e6e668324627)
- [T1-Auswertung](https://docs.google.com/document/d/1wMYAwTYDV3i6_DmYwMQSSm4w3LCf-ijgVd4qCykkUDI/edit)
