---
description: IBES Tippspiel - Recherche, Update und Fragen-Vorschläge
---

# /ibes - Dschungelcamp Tippspiel Assistent

Recherchiert den aktuellen Stand, aktualisiert das Sheet, und schlägt passende Fragen vor.

## Instructions

### Step 1: Aktuellen Stand recherchieren

Führe eine Web-Suche durch:
```
"Dschungelcamp 2026 wer ist raus aktuell"
```

Finde heraus:
- Wer ist gestern rausgeflogen?
- Gab es besondere Vorkommnisse? (Verletzungen, Abbrüche, Specials)
- Wer wurde in die nächste Prüfung gewählt?

### Step 2: Sheet lesen

Lies das Kandidaten-Tab aus dem IBES Sheet:
- Spreadsheet ID: `1kwtyrRtMJmL6MAtxLDjaTffICB9aDfeSf3aaq0wm6KI`
- Tab: `Kandidaten`
- User: `nikolai@gomedicusgroup.com`

Vergleiche mit den recherchierten Daten.

### Step 3: Sheet aktualisieren (wenn nötig)

Falls es Änderungen gibt:
- Status von "Im Camp" auf "Raus" setzen
- Tag und Datum des Ausscheidens eintragen
- Aktuellen Tag aktualisieren

Zeige dem User was aktualisiert wurde:
```
### Updates
- [Name] ist raus (Tag X, Datum)
- Aktueller Tag: X → Y
```

### Step 4: Phase bestimmen

| Tag | Phase | Ziel-Quote |
|-----|-------|------------|
| 1-2 | EINZUG | 50-80% |
| 3-7 | ETABLIERUNG | 30-50% |
| 8-14 | RAUSWAHL | 25-45% |
| 15-17 | FINALE | 35-60% |

### Step 5: Output generieren

```
## IBES Tippspiel - Tag [X] ([PHASE])

**Heute:** [Datum] | **Finale:** 8. Februar

---

### Aktueller Stand

**Im Camp ([Anzahl]):**
[Liste der Namen]

**Raus:**
[Liste mit Tag und Datum]

---

### Was gestern passiert ist
[Kurze Zusammenfassung der letzten Folge aus der Recherche]
- Wer ist rausgeflogen?
- Wer wurde für heute in die Prüfung gewählt?
- Besonderheiten?

---

### Fragen für Tag [X+1]

**Kern-Fragen:**
1. Wie viele Sterne werden geholt?
   → MITTEL | 5 Punkte

2. Wer geht in die nächste Prüfung?
   → SCHWER | 5-8 Punkte
   → Kandidaten: [Liste wer noch da ist]

[3. Wer fliegt? (nur ab Tag 8)]
   → SCHWER | 5-8 Punkte
   → Kandidaten: [Liste]

**Optional (1-2 wählen):**
- Wird die Prüfung abgebrochen? → LEICHT | 2-3 Pkt
- Werden wir Tränen sehen? → LEICHT | 2-3 Pkt
- Erstes Wort der Rausgewählten? → CHAOS | 3-5 Pkt

---

### Checkliste vor Veröffentlichung
- [ ] RTL-Trailer gecheckt? (rtl.de oder Social Media)
- [ ] Mind. 1 leichte Frage dabei?
- [ ] Max. 1 Chaos-Frage?
- [ ] Punkte-Budget: [X] Punkte (Empfehlung: 15-25)
- [ ] Deadline: 18:15 Uhr (2h vor Sendung)

---

**Sheet:** [Öffnen](https://docs.google.com/spreadsheets/d/1kwtyrRtMJmL6MAtxLDjaTffICB9aDfeSf3aaq0wm6KI/edit)
**Regelwerk:** Obsidian → Privat/Projekte/IBES Tippspiel/
```

### Step 6: Auf Fragen reagieren

Der User könnte fragen:
- "Wer geht heute in die Prüfung?" → Recherchieren falls nicht bekannt
- "Update das Sheet" → Step 3 nochmal ausführen
- "Mehr Fragen-Ideen" → Weitere Vorschläge aus dem Regelwerk
