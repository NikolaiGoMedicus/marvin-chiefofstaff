---
name: ibes-tippspiel
description: |
  IBES Dschungelcamp Tippspiel Assistent. Zeigt aktuellen Stand,
  wer noch im Camp ist, und schlägt passende Fragen für den Tages-Bogen vor.
license: MIT
compatibility: marvin
metadata:
  marvin-category: personal
  user-invocable: true
  slash-command: /ibes
  model: default
  proactive: false
---

# IBES Tippspiel Assistent

Hilft beim Erstellen des täglichen Tippspiel-Bogens für "Ich bin ein Star - Holt mich hier raus!"

## When to Use

- Wenn du den aktuellen Stand der Staffel wissen willst
- Wenn du Fragen für den nächsten Tag vorbereiten willst
- Wenn du wissen willst wer noch im Camp ist

## Ressourcen

- **Google Sheet:** `1kwtyrRtMJmL6MAtxLDjaTffICB9aDfeSf3aaq0wm6KI`
- **Regelwerk:** `Privat/Projekte/IBES Tippspiel/ibes_tippspiel_regelwerk.md`

## Process

### Step 1: Aktuellen Stand holen

Lies das Google Sheet (Tab: Kandidaten) um zu sehen:
- Wer ist noch im Camp?
- Wer ist raus?
- Welcher Tag ist es?

### Step 2: Phase bestimmen

Basierend auf dem aktuellen Tag:
- Tag 1-2: EINZUG (Ziel-Quote 50-80%)
- Tag 3-7: ETABLIERUNG (Ziel-Quote 30-50%)
- Tag 8-14: RAUSWAHL (Ziel-Quote 25-45%)
- Tag 15-17: FINALE (Ziel-Quote 35-60%)

### Step 3: Fragen vorschlagen

Je nach Phase passende Fragen empfehlen:

**EINZUG:**
- Wer wird Team-Leader?
- Wie viele Sterne (pro Gruppe)?
- Wer geht in die erste Prüfung?
- Werden wir Tränen sehen?

**ETABLIERUNG:**
- Wie viele Sterne?
- Wer wird in die nächste Prüfung gewählt?
- Stimmungs-Frage (Ja/Nein)

**RAUSWAHL:**
- Wie viele Sterne?
- Wer geht in die Prüfung?
- Wer fliegt?
- Optional: Detail-Frage

**FINALE:**
- Wie viele Sterne?
- Wer fliegt? (evtl. 2)
- Wer wird Dschungelkönig:in?

### Step 4: Checkliste zeigen

Reminder für den Fragenersteller:
- [ ] RTL-Trailer gecheckt?
- [ ] Mind. 1 leichte Frage?
- [ ] Max. 1 Chaos-Frage?
- [ ] Deadline gesetzt?

## Output Format

```
## IBES Tippspiel - Tag X (PHASE)

### Im Camp (X Personen)
- Name 1
- Name 2
- ...

### Raus
- Name (Tag X)
- ...

### Empfohlene Fragen für Tag X+1

1. **Sterne:** Wie viele Sterne werden geholt?
   - Typ: MITTEL | Punkte: 5

2. **Prüfling:** Wer geht in die nächste Prüfung?
   - Typ: SCHWER | Punkte: 5-8

3. ...

### Checkliste
- [ ] RTL-Trailer gecheckt?
- [ ] Balance-Check gemacht?
- [ ] Deadline: mind. 2h vor Sendung

---
Sheet: [Link]
```

---

*Skill created: 2026-02-05*
