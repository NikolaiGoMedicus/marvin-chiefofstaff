---
project: pipedrive-mcp
status: active
owner: nikolai
updated: 2026-04-28
tags: [work, mcp, sales, infrastructure]
---

# Pipedrive MCP Infrastruktur

## Status

- **Nikolai Claude Desktop:** Pipedrive MCP (@iamsamuelfraga/mcp-pipedrive@2.0.0) eingebaut (20.04.), Token aus marvin/.mcp.json wiederverwendet, JSON validiert.
- **Thomas:** Node LTS installiert, PATH /usr/local/bin zu .zshrc hinzugefügt, Shell-Wrapper-Config für Claude Desktop bereitgestellt. Verifikation nach Neustart ausstehend.
- **Janina (28.04.):** Setup live. Problem war fehlender Node — Homebrew + Node installiert, `npx` unter `/opt/homebrew/bin/npx`. `claude_desktop_config.json` mit absolutem Pfad gepatcht. Eigener Pipedrive API-Token: `278535b4fb5a12e7865c78d1e7a91ef826a2ae2b`. (Audit-Trail bei ihren Updates läuft korrekt unter ihrem User.)
- 3 Use Cases ausgearbeitet + 242-Tool-Katalog strukturiert.

## Stage 1 Begrüßung-Backfill (28.04.2026) ✅

**Aufgabe:** Custom-Field "Begrüßung" auf Person backfillen, deterministisch aus existierendem "Anrede"-Feld.

**Resultat:** **1.373/1.373 Updates erfolgreich, 0 Errors, 100% verified.**

- Targets aus 7.693 Personen in 7.926 offenen Deals
- 637 → "Sehr geehrter Herr" (225) · 736 → "Sehr geehrte Frau" (224)
- Mapping: Herr/Herr Dipl.-Med./Herr Dr. Med. → 225 · Frau/Frau Dipl.-Med./Frau Dr. Med. → 224
- Phasen: Recon (read-only) → Targeting → Mini-Batch (10) → Frau-Test (3) → Full-Run (1.360, 28×50er-Batches)
- Datenqualitäts-Finding: ~67% der "Personen" in offenen Deals sind in Wirklichkeit Einrichtungen/GmbHs — Vornamen-Heuristik wäre hier gefährlich
- Skip-If-Set hardcoded, jeder Update mit GET-Verify
- **Rollback-Daten** in `/tmp/pipedrive_recon/stage1_full_rollback.jsonl` + `stage1_minibatch_rollback.json` + `stage1_frau_test_rollback.json`
- **Field-Format:** Pipedrive `set` Custom-Field erwartet Single-Option als String (`"225"`, nicht `[225]`)
- Debrief-Email an Janina + Thomas (CC Basti) als Gmail-Draft `r1975070607433085642` — wartet auf Nikolai-Freigabe

## Open Items

- [ ] Thomas: Setup nach Neustart verifizieren
- [ ] Janina: Verify dass Pipedrive-Tools in Claude Desktop sichtbar sind + ersten Test-Prompt laufen lassen
- [ ] Debrief-Email senden (Draft `r1975070607433085642`)
- [ ] Entscheidung: Shared Claude Project "GoMedicus Sales" mit Thomas auf denselben MCP-Workflows statt individuellem Setup?
- [ ] Playbook (Use Cases + Tool-Katalog) ins Vault schreiben + qmd embed
- [ ] Optional: Stufe 2 Begrüßung-Backfill (Vornamen-basiert mit Org-Marker-Filter) — erst nach Person↔Org-Bereinigung sinnvoll
- [ ] Strategisch: Person↔Organisation-Datenbereinigung im CRM (~4.000 Einrichtungs-Records im Personen-Feld) — größerer Hebel als Stufe 2
