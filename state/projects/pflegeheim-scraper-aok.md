---
project: Pflegeheim-Scraper für AOK-Webinar
status: waiting
owner: nikolai
updated: 2026-05-04
tags: [aok, webinar, scraper, pflegeheim, sebastian]
---

# Pflegeheim-Scraper für AOK-Webinar

## Status

Liste an Sebastian raus (04.05. 13:46). Warte auf Versand durch Frau Oldenburg (AOK) morgen 05.05. und Webinar-Anmeldungen 19.05.

## Open Items

- [ ] Frau Oldenburg Versand bestätigen (05.05.)
- [ ] Webinar-Anmeldungen tracken nach 19.05. (Vergleich: Bayern 43 Anmeldungen nach AOK-Blast)
- [x] Excel-File an Sebastian Schulz gesendet ✅ (04.05.)
- [ ] Sebastian muss Excel-File manuell in Slack-DM an Frau Oldenburg droppen

## Waiting On

- Sebastian Schulz — Excel-File in Slack-DM an Frau Oldenburg droppen (seit 04.05.)
- Frau Oldenburg (AOK) — Versand an BB+MV Pflegeheime, geplant 05.05.

## Links

- Excel-Output: `~/Downloads/Pflegeheime_BB_MV_2026-05-04.xlsx`
- Code: `/Users/nikolaibockholt/Documents/web/scraper-henry/biva_scraper/`
  - `biva_scrape.py` — Scraper (BIVA Adressdatenbank, parametrisierbar per `--state`)
  - `merge.py` — Merge BIVA-Daten mit Sebastian's bestehender Liste
  - `finalize.py` — Dedup + Finale Excel-Ausgabe

## Context / Notes

**Auftrag:** Sebastian Schulz brauchte kurzfristig eine Pflegeheim-Email-Liste für BB+MV, damit Frau Oldenburg (AOK) Einladungen für das Webinar 19.05. versenden kann. Referenz: Bayern-Blast hatte 43 Anmeldungen — BB+MV vorher nur 2 (ohne Blast).

**Datenquelle:** BIVA (biva.de/pflege-adressen/stationaer/) — Bundesinteressenvertretung für alte und pflegebetroffene Menschen. Listet stationäre Pflegeeinrichtungen mit Adresse + Email. Scraped: 200 BB + 408 MV Heime, ~98% Email-Coverage.

**Resultate:**
- 597 versandbereite Heim-Einträge gesamt (BB 197 + MV 400)
- 544 unique Email-Empfänger nach Dedup
- 256 Einträge aus Sebastian's ursprünglicher Liste ohne BIVA-Match → in separaten "ohne Email"-Sheets für ggf. Nachrecherche

**Code Reuse:** Scraper ist parametrisierbar (`--state` Parameter). Kann für weitere Bundesländer benutzt werden, z.B. wenn AOK das auch in HH, SH oder NDS machen will.
