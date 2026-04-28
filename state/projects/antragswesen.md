---
project: antragswesen
status: active
owner: nikolai
updated: 2026-04-28 13:18
tags: [work, ai, systems, gomedicus]
---

# Antragswesen

## Status

Tool nicht mehr One-Shot, sondern wiederverwendbares Antragssystem. Phase 1 (Bundle-aware Architektur) am 28.04. abgeschlossen. Aktueller Antrag (gemeinschaftliche Weiterbildungsbefugnis Allgemeinmedizin Kampmeyer/Gorski/Wacker-Rohrbach) hat noch 13 offene Gaps + 1 strukturelle Entscheidung.

## Architektur (Stand 28.04.)

Repo: `~/Documents/web/antragswesen` · GitHub: `GoMedicus/antragswesen` (privat)

- **`locations.yaml`** = SSoT für alle 9 GoMedicus-Standorte (3× Reutlingen, Bisingen, Rangendingen, Hechingen-HNO, Schömberg, Gosheim, Telemed). Pro Standort `fachgebiete`-Tag + `traeger_mvz`-Zuordnung.
- **`data/people/*.yaml`** = ein File pro Arzt mit `dienstlich.taetigkeitsorte: [keys]` und `fachgebiet`. Aktuell 5 Files (Antragsteller + Mitträger).
- **`data/bundles/*.yaml`** = Antrag-Konfiguration (Anlass + Antragsteller + Programm). Renderer schneidet Standorte = Vereinigung der `taetigkeitsorte` aller Antragsteller.
- **Templates** in `templates/*.md.j2` rendern: Mantelbogen pro Person + Aufstellung + Zustimmung Mitträger + Anlage 3 Räume/Geräte + Anlage 4 Curriculum.
- **`render.py`** liest Bundle-Config, filtert Standorte, gibt DOCX-Bundle + `gaps.md` + `README.md` aus.

Solo-Antrag (z.B. HNO Hechingen Einzelbefugnis) braucht künftig nur ein neues Bundle-File, kein Code-Change.

## ⚠️ Konzern-Struktur (Stand 28.04., Quelle: Notion "GoMedicus Network" — abgeglichen mit Phil)

**Drei Trägergesellschaften** unter der GoMedicus Group GmbH (Holding Hamburg), alle im persönlichen Besitz Phil Gonser:
1. **Go-medicus Zollernalb MVZ GmbH** (HRB 779474 Stuttgart) ← unser Antrag
2. GoMedicus Rhein-Neckar MVZ GmbH (HRB 794149) — Lütjensee
3. paeDOC MVZ GmbH (HRB 768454) — Altensteig, Bisingen Kids, Fellbach

**Drei MVZs unter Zollernalb GmbH** (Notion-Quelle, präziser als Impressum):
- **MVZ ZAK** → Bisingen HA, Rangendingen, Schömberg, Gosheim
- **MVZ Reutlingen** → RT Kaiserstr, RT Tübinger Str, RT Degerschlacht
- **MVZ HNO Hechingen** → HNO Hechingen

**Phil-Statement (28.04.):** "Wir stellen aktuell nur MVZ Bisingen und Zweigpraxen den Antrag." → Antrag läuft über **MVZ ZAK** (Bisingen HA = Hauptsitz, Rangendingen/Schömberg/Gosheim = Zweigpraxen).

**Konflikt offen:** Kampmeyer sitzt in Reutlingen-Kaiserstr (= MVZ Reutlingen, nicht ZAK). Wie wird er im Antrag behandelt? → Folge-Mail an Phil raus (Draft `r-457120822385611219`).

## Personen / Rollen (laut Onboarding-Manual)

- **Tine Füllemann** — Ärztliche Leitung Allgemeinmedizin (potentieller Anlage-4-Reviewer, ggf. zusätzlich zu Kampmeyer)
- **Phillipp Gonser** — Ärztliche Leitung HNO / Gesamtverantwortung (für HNO-Anträge zuständig)
- **Ulrich Kuhn** — Ärztliche Leitung Pädiatrie (für paeDOC-Anträge)
- **Sandra Heidmann** — Lead Abrechnungsmanagement (KV-Abrechnung als Anlage 2)
- **Florian Kleinau** — Network Development / Praxis-Integration

## Daten-Stand für aktuellen Antrag (Bundle `kammer-weiterbildung-2026-04`)

Standortliste hängt an Phils Kampmeyer-Antwort:
- Wenn Kampmeyer-Standort raus: 4 Standorte (bisingen-hauptsitz · rangendingen · schoemberg · gosheim) — alle MVZ ZAK.
- Wenn Kampmeyer-Standort drin: 5 Standorte (+ reutlingen-kaiserstr).
- Telemedizin: laut Notion kein eigener Standort — vermutlich nicht antragsrelevant.

Adressen + Telefon für 8 Standorte aus gomedicus.com gezogen (28.04.). Verdächtig: Rangendingen + Hechingen-HNO haben identische Web-Telefon (07471 2431) — bei Phil verifizieren.

13 verbleibende Gaps:
- 5× Fax pro Standort (Reutlingen-Kaiserstr, Rangendingen, Schömberg, Gosheim, Telemed)
- MVZ-Zentral Tel + Fax
- Telemed PLZ (n/a — sollte als "" markiert werden)
- Telemed-Tel
- 5× Gorski (Approbations-Jahr/Stelle, FA-Datum/Kammer, Lebenslauf)

Plus Phase-2-Themen: Räume + Geräte pro Standort (Anlage 3) und Kampmeyer-Review für Anlage 4.

## Open Items

- [ ] Phil-Antwort abwarten: Kampmeyer-Behandlung (MVZ Reutlingen vs. ZAK)
- [ ] Sobald Kampmeyer-Frage geklärt: locations.yaml auf MVZ-ZAK-only refactoren (4 Standorte) + Bundle-Config aktualisieren
- [ ] Anlage 3 (Räume + Geräte) aus 2022er Anträgen Phil's Drive übernehmen statt neu zu erheben (per Phil 28.04.)
- [ ] Faxe + MVZ-Zentrale Tel/Fax + Tel-Konflikt Rangendingen/Hechingen-HNO als eigene kurze Folge-Mail an Phil (nachrangig)
- [ ] Gorski Approbations-/FA-Urkunden aus Personio per OCR ziehen (sobald Phil grünes Licht gibt)
- [ ] Gorski-Lebenslauf bei ihm direkt anfordern (Phil)
- [ ] Anlage 4 Curriculum-Review: Kampmeyer + ggf. Tine Füllemann (Ärztl. Leitung Allgemeinmed)

## Waiting On

- **Phil Gonser** — Kampmeyer-Behandlung im Antrag (Reutlingen-Sitz vs. MVZ ZAK Antrag) → Gmail Draft `r-457120822385611219` im Thread `19db5d9a635fe787`. Vorgänger-Drafts `r-887994339486291649` + `r-235284118004984304` sind beantwortet/obsolet.

## Links

- Repo: `github.com/GoMedicus/antragswesen` (privat)
- Local: `/Users/nikolaibockholt/Documents/web/antragswesen`
- Aktuelles Bundle: `data/output/2026-04-28-kammer-weiterbildung/`
- Notion: AI & Systems Office
- Drive (Phil's historische Anträge): `https://drive.google.com/drive/folders/136M_FpCahohIdQzJlqlKIYslYASmaTkS`
- **Onboarding-Manual** (SSoT für Konzern-Struktur): `https://docs.google.com/document/d/18trqIHwbk87drbRCHTDzgZHNlNOzYvHJPSq3JNMCtD4/edit`
- Impressum gomedicus.com: `https://www.gomedicus.com/impressum/`

## Context / Notes

- Ausgegründet 22.04.2026 als eigenständiges Projekt im Kontext AI & Systems Office.
- 28.04.: Refactor von One-Shot-Tool zu Bundle-aware-Architektur. 9 Standorte modelliert, 5 Person-YAMLs erweitert, Bundle-Config-Mechanismus eingeführt.
- 28.04.: Konzern-Struktur via Notion ("GoMedicus Network") final geklärt — Quelle ist präziser als Impressum/Onboarding-Manual. Drei MVZs unter Zollernalb GmbH: **MVZ ZAK** (Bisingen HA + Rangendingen + Schömberg + Gosheim), MVZ Reutlingen, MVZ HNO Hechingen.
- 28.04.: Phil-Antwort (11:46) auf Lücken-Mail: Antrag läuft nur über "MVZ Bisingen und Zweigpraxen" (= MVZ ZAK). Anlage 3 aus alten Anträgen übernehmen. Strukturelles Restthema: Kampmeyer's Reutlingen-Sitz vs. ZAK-Antrag → Folge-Mail (Draft `r-457120822385611219`) raus.
- 2022er-Mantelbögen aus Phil's Drive (ZAK Bisingen / Degerschlacht) sind historisch — heutige Standorte überschneiden sich nur teilweise (Rangendingen + Bisingen). Daten-Beitrag aus Drive: 2 Adressen + Tel-Vorwahlen für Cross-Check.
- 28.04. (Nachmittag): Weitere Arbeit an render.py + locations.yaml + mantelbogen-Template (noch nicht committet). Source-PDFs (Personalfragebögen + Lebensläufe) aus Personio extrahiert via `_decode.py`.
