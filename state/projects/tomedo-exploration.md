---
project: tomedo-exploration
status: active
owner: nikolai
updated: 2026-04-22
tags: [work, gomedicus, tomedo, reporting, knowledge-base]
---

# Tomedo Exploration

Knowledge Base + Query-Library für Tomedo-Datenbank. Greenfield-Repo, aufgesetzt am 22.04.2026.

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
- **11 Entity-Docs** (patient, termin, leistung, kvschein, medikamentenverordnung, diagnose, labor, karteieintrag, patientenformular, epa, cke)
- **3 Pattern-Docs** (patient-join-kaskade, hibernate-conventions, objectid-timestamp-decode)
- **3 Reusable-Queries** für Antonias Operations Reporting:
  - `adipositaskurs-woche.sql` — Wochenreport AK/eTermin + verlinkte Adipositas-Meds
  - `zanadio-beantwortete-formulare.sql` — Permalink-Formulare mit dekodiertem Timestamp
  - `termine-mit-verordnung.sql` — generisches LEGO-Stück
- **PROJECT_CONTEXT.md** — single-file Bundle für Upload als Claude-Projekt-Kontext

## Wichtigste Befunde

1. **Spec-Hypothese WIDERLEGT (M3):** Permalink-Formulare bypassen die Cascade NICHT. Der Spec-Autor suchte in `patientendetailsrelationen_karteieintraege`, aber der richtige Junction ist `patientendetailsrelationen_formulare` (329k Rows matchen 99.9% der Formular-Einträge). Root cause: Hibernate benennt Junctions nach Java-Klassen, nicht DB-Tabellen — bei STI-Tabellen (karteieintrag) fällt der naive "strip the plural"-Trick auseinander.

2. **PostgreSQL 9.4.12** — uralt (EOL seit 2020). `pg_dump 18.3` scheitert an Sequence-USAGE-Perms. Fallback: `information_schema`-Introspection.

3. **0 FK-Constraints auf DB-Ebene** — Hibernate enforced alles im App-Layer. Relationships via `*_ident`-Naming-Convention.

4. **pg_stat-Estimates komplett unzuverlässig.** karteieintrag als 10k geschätzt, real 12.5M. angefordertesjsonformular als 18 geschätzt, real 852.

5. **`verordnungsauftrag` ist leer** (0 Rows) — geplanter Shortcut für patient→verordnung existiert nur strukturell. Cascade nötig.

## Use-Cases (Empfänger)

1. **Antonia's Operations Reporting** — 3 Reusable-Queries decken AK/eTermin + Zanadio-Flow ab. Nächster Schritt: Queries an Antonia übergeben + in Claude-Project einbinden.
2. **MKD Integration Phase 3** — Wenn Deep Integration angeht, ist die Knowledge Base die Grundlage für Backend-Migration-Design.
3. **Praxis-KPIs** — Dashboard-Layer könnte auf den Reusable-Queries aufbauen.
4. **Notification-Trigger** — für das Notification Events Epic (GOM-1976 blocked by Cloudnonic).

## Offene TODOs

- [x] ~~M5-Commit abschließen (PROJECT_CONTEXT.md, README, dieses File)~~ ✅ 22.04.
- [x] ~~Entscheidung: GitHub-Remote anlegen ja/nein?~~ → **private Repo in GoMedicus-Org** angelegt am 22.04., alle 6 Commits gepusht.
- [ ] Antonia die 3 Queries zeigen im nächsten Call → zu Linear-Epic "Operations Reporting" hinzufügen
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
