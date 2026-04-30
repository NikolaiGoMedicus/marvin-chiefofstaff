---
project: tomedo-exploration
status: active
owner: nikolai
updated: 2026-04-30
tags: [work, gomedicus, tomedo, reporting, knowledge-base]
---

# Tomedo Exploration

Knowledge Base + Query-Library für Tomedo-Datenbank. Greenfield-Repo, aufgesetzt am 22.04.2026.

## Update 2026-04-23 (Nachmittag) — Telemed-Reporting für Sebastian Lüttle

**Kontext:** Live-Demo mit Sebastian Lüttle (GoMedicus Services, Reporting). Ad-hoc-Frage zu telemedizinischen Arzt-Patienten-Kontakten. Ergebnis: signifikante operative Verschiebung + neue Reusable-Query + wichtige Schema-/Business-Erkenntnisse (mehrfach iteriert während des Calls).

**Korrigierte Definition (nach Sebastians Input):**

Telemedizinischer Arzt-Patienten-Kontakt = Termin in einer von **27 Terminarten**:
- **13 Video-Terminarten** (Standort-spezifisch + GoMedicus-generisch)
- **11 Sonder-Sprechstunden** (exklusiv telemedizinisch, GKV): Apo-VSS, Depression-Beratung, Fatigue-Beratung, Inkontinenz, M.Bechterew, Brustkrebs, Diabetes-Sprechstunde, Diabetes-Lotse, Doctorbox STI, ZNA (Notaufnahme-VSS), Zanadio (+ zanadio)
- **1 Adipositas-Beratung (Novo Nordisk) = Privatleistung** — aus GKV-Count exkludieren
- **2 Telefonat-Terminarten**

Versicherungs-Split via Schein im Zielquartal:
- GKV (inkl. HZV): `kvschein.jahr/.quartal`
- HZV-Teilnehmer (Subset GKV): `hzvschein → hzvdetails.patient_ident`
- SV: `dvpschein` (falls relevant)
- Privat: kein Schein + alle Adipositas-Beratung

**Erkenntnisse:**

1. **`leistung.patient_ident` ist bei EBM-Abrechnungs-Ziffern durchweg NULL** — Pfad zu Patient muss über `leistung.invkvschein_ident → kvschein.patient_ident` laufen. Betrifft 01450, 01444, 88220, 01439. → Neuer Pattern-Doc `docs/patterns/abrechnung-ziffern-join.md`.
2. **Arzt-Tabelle heißt `nutzer`**, nicht `arzt`. `abrechnenderarzt_ident → nutzer.ident`.
3. **EBM 01450 ist nicht die vollständige Telemed-Quelle.** Sie deckt nur abgerechnete Video-Sprechstunden ab, verfehlt ~34% der Telemed-Kontakte (Telefonate + Sonder-Beratungen ohne Video-Zuschlag). Primärquelle = Terminart + Schein-Check.
4. **HZV-Teilnehmer automatisch in GKV-Count enthalten** (kvschein existiert für alle GKV-Patienten, unabhängig von HZV-Einschreibung).
5. **`besuch.terminkalender` ist in Bisingen durchgängig leer** (730/730 KW13, 100%). Pflege-Problem. Video-Exclude-Filter bei Auslastungs-Queries daher nur an gepflegten Standorten (Gosheim, Rangendingen) wirksam.
6. **Sonder-Telemed-Besuche dürfen NICHT zu Vor-Ort-Auslastung zählen** (Sebastian-Ansage). Auslastungs-Query `auslastung-taegliche-besuche.sql` seit 23.04. mit Exclude-Filter gepatcht — aber Bisingen bleibt Blindspot, solange `terminkalender` dort nicht gepflegt wird.
7. **Operative Verschiebung Bisingen → Reutlingen-Tübinger-Straße** (via EBM 01450, GKV-Video): Bisingen KW11 (185) → KW15 (31) = -83%; REU-Tü 13 → 121 = +830%. Bisher nicht quantifiziert.

**Zahlen KW13/2026 (23.-29.3.) — korrigierte Primärquelle (Terminart + Schein):**

| Segment | Pat. | Termine |
|---|---:|---:|
| Telemed-Kontakte gesamt | **234** | 283 |
| GKV inkl. HZV (kvschein Q1) | 224 | 239 |
| HZV-Subset | **102** | 112 |
| Adipositas-Beratung (Privat/Novo) | 1 | 1 |
| Privat/Selbstzahler (kein Schein) | 9 | 9 |

**Vergleich nur-EBM-01450:** 149 GKV-Pat (Delta -75 zur Terminart-Zählung = Telefonate + Sonder-Beratungen).

**Arzt-Split Bisingen KW13 (nur EBM 01450):** Dr. Philipp Moon (MooP) 133/109 (91%), Dr. Robert Bartaky (BarR) 13/13. Kompletter Arzt-Split via neue Terminart-Query noch nicht gelaufen — Follow-up.

**Neue Artefakte:**
- `queries/reusable/telemed-kontakte.sql` — parametrisiert (Zeitraum, BS), liefert KW × Standort × Arzt
- `docs/patterns/abrechnung-ziffern-join.md` — Pattern-Doc mit Verifikation
- Updates: README (Key Learnings erweitert), PROJECT_CONTEXT.md (Hard Rules + Abrechnungs-Muster-Sektion), `docs/entities/leistung.md` (Patient-Join-Tabelle)
- Notion-Update ausstehend (siehe unten)

**Offen:**
- Privat/GOÄ sauber abbilden — `l.containedonrechnung_ident → rechnung`-Pfad verifizieren
- Arzt-Kürzel-Mapping Bisingen: nur 2 Ärzte in KW13, aber das `nutzer.kuerzel`-Schema (MooP, BarR) sollte zentral dokumentiert werden
- Wenn Sebastian eigenen Zugriff will: Lambda-Ticket analog Benjamin-Heinke vom 22.04. aufsetzen

## Update 2026-04-23 — Discovery "Tagesliste" für Auslastungs-Reporting

Arved + Nikolai Call (10:16): Arved braucht automatisiertes Auslastungs-Reporting
(Patienten/Arzt/h × Standort × Tag). Manuelles Sheet 1.-14.4. war Proof-of-Concept.

**Befund:** Die Tomedo-UI "Tagesliste" speist sich aus Tabelle `besuch` (nicht `termin`).
Arveds Handzählung matcht DB ±1 pro Zeile über 24 Vergleichspunkte.

**Neue Artefakte:**
- Entity-Doc: [`docs/entities/besuch.md`](../../Documents/web/tomedo-exploration/docs/entities/besuch.md)
- Reusable Queries: `auslastung-taegliche-besuche.sql`, `auslastung-stunden-heatmap.sql`
- Discovery-Sheet für Arved + Sebastian: [Tomedo DB Discovery — Auslastungs-Reporting](https://docs.google.com/spreadsheets/d/1fDMAiVdROwkzW4vzXQXLboFDpp8aAwM_FCVVo3WcE-U/edit)
- Notion-Seite aktualisiert: neue Sektion "Discovery 2026-04-23" und Queries-Liste auf 5 erweitert.

**Offen für nächsten Call:**
- Scope-Entscheidung: DB-only Phase 1 oder Personio-Integration parallel?
- MFA-Metrik-Ersatz (Arveds "Patienten/MFA/h" methodisch kaputt)
- Arzt-Kürzel-Mapping (GorA, CWA, SauB, HajS ...) zentral zu Arved+Michael pflegen

## Location

- **Local:** `~/Documents/web/tomedo-exploration/`
- **Remote:** `https://github.com/GoMedicus/tomedo-database-read` (private, GoMedicus-Org)
- **Notion:** [🗄️ Tomedo Datenbank — Direct Access & Schema Knowledge](https://www.notion.so/34a57538249e81588c40f5662e1755a4) (parent: Plattform & Produkt, sibling zu "Workflows PVS-Integration — Tomedo")
- **Cross-References gesetzt in:**
  - [🔄 Workflows PVS-Integration — Tomedo](https://www.notion.so/34457538249e8130a089ee7bc20c7cac) — "Verwandte Seiten" am Ende
  - [🧮 Reporting & Data Sources](https://www.notion.so/34957538249e81bcbcb2fe1dd0668ccc) — neue Sektion "Tomedo Direct-DB Queries (seit 22.04.2026)"
  - [🏥 Antonia Gebhardt — Clinic Onboarding](https://www.notion.so/33b57538249e81319fb6cadaad9a5eb2) — neue Sektion "Reporting-Tools (seit 22.04.2026)"

## Status

**M0–M5 komplett** (22.04.2026, ~2h Arbeitszeit). Alle 5 Missionen mit Commits:

```
a1cb30e  feat: reusable queries for operations reporting (M4)
3b30cf2  docs: resolve Permalink-Formular hypothesis (M3)
81bb0fc  docs: entity mapping + core patterns (M2)
a466539  docs: schema introspection + conventions (M1)
bf481f3  chore: initial setup (M0)
```
(M5-Commit abgeschlossen 22.04.)

## DB-Zugang

- **Host:** `172.16.1.20:5432`
- **DB:** `tomedo`
- **User:** `gomedicus_readonly` (read-only DB-Rolle, von Lambda provisioniert am 22.04.)
- **Network:** Lambda VPN (`Bockholt-inline.ovpn`)
- **Credentials:** in `~/Documents/web/tomedo-exploration/.env` (gitignored)

## Was drin ist

- **Schema-Metadata:** 2.314 Tabellen, 14.703 Spalten, 3.078 Indizes, 13 Views, 4.140 pseudo-FKs
- **12 Entity-Docs** (patient, termin, **besuch**, leistung, kvschein, medikamentenverordnung, diagnose, labor, karteieintrag, patientenformular, epa, cke)
- **3 Pattern-Docs** (patient-join-kaskade, hibernate-conventions, objectid-timestamp-decode)
- **7 Reusable-Queries**:
  - `adipositaskurs-woche.sql` — Wochenreport AK/eTermin + verlinkte Adipositas-Meds (Antonia)
  - `zanadio-beantwortete-formulare.sql` — Permalink-Formulare mit dekodiertem Timestamp (Antonia)
  - `termine-mit-verordnung.sql` — generisches LEGO-Stück (Antonia)
  - `auslastung-taegliche-besuche.sql` — Patienten/Tag/Standort/Arzt (Arved, seit 23.04.)
  - `auslastung-stunden-heatmap.sql` — Besuche/Stunde/Standort (Arved, seit 23.04.)
  - `telemed-kontakte.sql` — Videosprechstunden via EBM 01450, KW × Standort × Arzt (Sebastian Lüttle, seit 23.04.)
  - `zanadio-datenweitergabe.sql` — Patienten mit Consent-Ja (bezeichner/wert-Pattern), 402 Pat live getestet (Antonia, seit 28.04.)
- **4 Pattern-Docs** (+1 seit 23.04.):
  - `patient-join-kaskade.md`, `hibernate-conventions.md`, `objectid-timestamp-decode.md`
  - `abrechnung-ziffern-join.md` — EBM-Zuschläge → Patient via kvschein (neu)
- **PROJECT_CONTEXT.md** — single-file Bundle für Upload als Claude-Projekt-Kontext

## Wichtigste Befunde

1. **Spec-Hypothese WIDERLEGT (M3):** Permalink-Formulare bypassen die Cascade NICHT. Der Spec-Autor suchte in `patientendetailsrelationen_karteieintraege`, aber der richtige Junction ist `patientendetailsrelationen_formulare` (329k Rows matchen 99.9% der Formular-Einträge). Root cause: Hibernate benennt Junctions nach Java-Klassen, nicht DB-Tabellen — bei STI-Tabellen (karteieintrag) fällt der naive "strip the plural"-Trick auseinander.

2. **PostgreSQL 9.4.12** — uralt (EOL seit 2020). `pg_dump 18.3` scheitert an Sequence-USAGE-Perms. Fallback: `information_schema`-Introspection.

3. **0 FK-Constraints auf DB-Ebene** — Hibernate enforced alles im App-Layer. Relationships via `*_ident`-Naming-Convention.

4. **pg_stat-Estimates komplett unzuverlässig.** karteieintrag als 10k geschätzt, real 12.5M. angefordertesjsonformular als 18 geschätzt, real 852.

5. **`verordnungsauftrag` ist leer** (0 Rows) — geplanter Shortcut für patient→verordnung existiert nur strukturell. Cascade nötig.

## Update 2026-04-28 — Zanadio-Datenweitergabe-Query für Antonia

**Kontext:** VPN up, Direct-DB-Zugriff via psql + run_query.py bestätigt. Neue Ad-hoc-Query für Antonia Gebhardt (Operations Reporting).

**Query:** Patienten mit Zanadio-Datenweitergabe=Ja (Consent-Formular). Field: `bezeichner='weitergabe-informationen'`, `wert='Ja'`.

**Ergebnis live getestet (28.04.):**

| Terminart | Patienten |
|-----------|----------:|
| zanadio | 310 |
| adipositasberatung-zanadio | 92 |
| **Total Zanadio-Datenweitergabe=Ja** | **402** |
| brustkrebs-beratung (selbes Feld) | 10 |

**Artefakt:** SQL an Antonia via Slack (Outbox #10) — Nikolai sendet manuell (Widget-Draft D0APEL56T7S). SQL ggf. als Slack-Snippet posten.

**Neue Erkenntnisse:**
- `weitergabe-informationen` / `Ja` ist ein wiederkehrendes Pattern für Disease-Management-Consents (Zanadio, Brustkrebs-Beratung)
- Formular-Felder via `patientenformular` → `bezeichner`/`wert` direkt abfragbar ohne Join-Kaskade

---

## Use-Cases (Empfänger)

1. **Antonia's Operations Reporting** — 4 Reusable-Queries: AK/eTermin + Zanadio-Flow + Zanadio-Datenweitergabe-Consent (402 Pat, 28.04. live getestet). SQL an Antonia via Slack (Outbox #10).
2. **MKD Integration Phase 3** — Wenn Deep Integration angeht, ist die Knowledge Base die Grundlage für Backend-Migration-Design.
3. **Praxis-KPIs** — Dashboard-Layer könnte auf den Reusable-Queries aufbauen.
4. **Notification-Trigger** — für das Notification Events Epic (GOM-1976 blocked by Cloudnonic).

## Update 2026-04-30 — KW18 GKV-Scheine-Query (Verordnungs-Analyse)

**Kontext:** Ad-hoc-Query für KW18 GKV-Schein-Übersicht.

**Ergebnisse:**

| Metrik | Wert |
|--------|-----:|
| GKV-Scheine gesamt (KW18) | **812** |
| Distinct Patienten | **788** |
| davon HZV | **247** |
| Verordnungen (medikamentenverordnung) | **495** |

**Schema-Klarstellung:**
- `ausstellungsdatum4102` ist **unmaintained** — Feld wird in der Praxis nicht gepflegt.
- **`sortierdatum`** ist das korrekt befüllte Datum-Feld für Scheine — ab sofort als Primärquelle für Zeitraum-Queries nutzen.

**Top-Präparate:** in Session ermittelt (Verordnungs-Analyse KW18).

## Offene TODOs

- [x] ~~M5-Commit abschließen (PROJECT_CONTEXT.md, README, dieses File)~~ ✅ 22.04.
- [x] ~~Entscheidung: GitHub-Remote anlegen ja/nein?~~ → **private Repo in GoMedicus-Org** angelegt am 22.04., alle 6 Commits gepusht.
- [x] ~~Antonia die 3 Queries zeigen im nächsten Call → zu Linear-Epic "Operations Reporting" hinzufügen~~ → Zanadio-Datenweitergabe-SQL direkt via Slack (28.04.) ✅
- [ ] Permission-Rules in `~/marvin/.claude/settings.local.json` eintragen, damit zukünftige DB-Queries ohne Bang-Prefix laufen (siehe `/Users/nikolaibockholt/.claude/plans/schau-dir-mal-folgende-parallel-yeti.md`)
- [ ] Labor-Result-Join (labverspalteentity / labverzeileentity) vollständig verifizieren (TBD-Marker in `docs/entities/labor.md`)
- [ ] CKE-Definition-Tabelle finden (TBD-Marker in `docs/entities/cke.md`)

## Zeit-Tracking

- 14:16 Session-Start / Plan-Mode
- 14:26 Plan genehmigt (Location, Git-Strategie, Tech-Stack abgestimmt)
- 14:30 M0 Setup begonnen (libpq install, uv, scripts)
- ~14:40 Credential-Chaos: erste Creds waren VPN-Firewall, dann tot-Link, dann neu
- 14:55 Sanity-Query durch (PostgreSQL 9.4.12, 114k patients, 2314 tables)
- 14:56 M0 committed
- 15:12 M1 committed (Schema-Introspection, FK-Discovery)
- 15:22 M2 committed (10 Entity-Docs + 3 Pattern-Docs)
- 15:31 M3 committed (Permalink-Hypothese gelöst)
- 15:44 M4 committed (3 Reusable-Queries, alle live getestet)
- 15:55 M5 finalisiert

## Referenzen

- Plan: `~/.claude/plans/schau-dir-mal-folgende-parallel-yeti.md`
- Spec: `~/Downloads/tomedo-exploration-spec.md`
- Repo: `~/Documents/web/tomedo-exploration/`
- Projekt-Verbindungen: [ai-services-rollout.md](ai-services-rollout.md) (Antonia), [mkd-integration.md](mkd-integration.md) (Phase 3), [gomedicus-platform.md](gomedicus-platform.md) (MVP)
