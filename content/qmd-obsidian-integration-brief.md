# MARVIN Brief: QMD + Obsidian Vault Integration

## Was ist das?

Nikolai will, dass du (MARVIN) semantisch über seinen gesamten Obsidian Vault suchen kannst UND aktiv Wissen dorthin zurückschreibst. Dafür wird **QMD** installiert — eine lokale Hybrid-Suchmaschine (BM25 + Vector + LLM Re-Ranking) für Markdown-Dateien.

**Ziel:** MARVIN wird nicht nur ein Session-basierter Assistent, sondern ein aktiver Knowledge Worker, der Nikolais Obsidian Vault als persistenten Wissensspeicher nutzt — lesen UND schreiben.

---

## Deine Aufgaben

### 1. QMD installieren

```bash
# Prüfe ob bun installiert ist
bun --version

# Falls nicht:
curl -fsSL https://bun.sh/install | bash

# QMD global installieren
bun install -g github:tobi/qmd
```

### 2. Collections einrichten

Zwei Collections — dein Obsidian Vault und dein eigener MARVIN-State:

```bash
# Obsidian Vault (Nikolais gesamte Knowledge Base)
qmd collection add /Users/nikolaibockholt/Documents/obsidian/nikolai --name vault --mask "**/*.md"

# MARVIN selbst (Sessions, State, Content)
qmd collection add /Users/nikolaibockholt/marvin --name marvin --mask "**/*.md"
```

### 3. Kontext hinzufügen

Kontext hilft QMD, Suchergebnisse besser einzuordnen:

```bash
# Vault-Kontexte
qmd context add qmd://vault "Nikolais persönlicher Obsidian Vault — Arbeit, Privat, Knowledge Base"
qmd context add qmd://vault/Arbeit/GoMedicus "GoMedicus Group: Projekte, Meetings, Plattform-Entwicklung, Praxis-Management"
qmd context add qmd://vault/Arbeit/GoMedicus/Projekte "Aktive Projekte: AI Services Rollout, Plattform, Corti, Lütjensee, BDT, MKD"
qmd context add qmd://vault/Arbeit/GoMedicus/Meetings "Meeting Notes und Protokolle"
qmd context add qmd://vault/Arbeit/Brand\ University "Lehrtätigkeit: AI for Marketing, Design Innovation"
qmd context add qmd://vault/Arbeit/HENQ "HENQ Technologies Projekte"
qmd context add qmd://vault/Privat "Persönliche Projekte, Karriere, Wissen"

# MARVIN-Kontexte
qmd context add qmd://marvin "MARVIN AI Chief of Staff — Session Logs, State, Goals, Reports"
qmd context add qmd://marvin/sessions "Tägliche Session-Protokolle seit Januar 2026"
qmd context add qmd://marvin/state "Aktuelle Prioritäten, Goals, offene Threads"
```

### 4. Embeddings generieren

```bash
qmd embed
```

Das dauert beim ersten Mal etwas (Modelle werden heruntergeladen: ~2GB). Danach ist es inkrementell.

### 5. Testen

```bash
# Keyword-Suche
qmd search "Corti Template API"

# Semantische Suche
qmd vsearch "wie überführen wir Daten ins PVS"

# Hybrid (beste Qualität)
qmd query "Datenschutz-Compliance für AI Services"
```

### 6. QMD als MCP-Server für MARVIN registrieren

Füge QMD zur `.mcp.json` hinzu:

```bash
# Aktuelle .mcp.json lesen und QMD hinzufügen
```

Die `.mcp.json` in `/Users/nikolaibockholt/marvin/` sollte danach so aussehen:

```json
{
  "mcpServers": {
    "slack": {
      "command": "npx",
      "args": ["-y", "@zencoderai/slack-mcp-server"],
      "env": {
        "SLACK_BOT_TOKEN": "...",
        "SLACK_TEAM_ID": "..."
      }
    },
    "qmd": {
      "command": "qmd",
      "args": ["mcp"]
    }
  }
}
```

### 7. CLAUDE.md aktualisieren

Füge unter **## Integrations (MCP)** → **### Active Integrations** hinzu:

```markdown
- **QMD** — Local semantic search over Obsidian Vault and MARVIN sessions/state. Collections: `vault` (Obsidian), `marvin` (own state). Use `qmd_deep_search` for knowledge questions, `qmd_search` for quick lookups. After writing new content to the Vault, run `qmd embed` to re-index.
```

### 8. Vault-Schreib-Konventionen zur CLAUDE.md hinzufügen

Füge einen neuen Abschnitt nach **## Integrations (MCP)** ein:

```markdown
## Obsidian Vault Integration

MARVIN has read AND write access to Nikolai's Obsidian Vault at:
`/Users/nikolaibockholt/Documents/obsidian/nikolai/`

### When to Write to the Vault

Write to the Vault when the outcome has **lasting value beyond the current session**:
- Research results, evaluations, comparisons
- Meeting summaries (after /end or when asked)
- Project documentation and specs
- Decision logs with rationale
- Knowledge articles from deep-dives

Do NOT write to the Vault for:
- Throwaway drafts or quick answers
- Content that already exists (check QMD first!)
- Session-internal working notes (those go in sessions/)

### File Naming & Location

Follow the existing Vault structure:

| Content Type | Path | Naming |
|-------------|------|--------|
| Meeting Notes | `Arbeit/GoMedicus/Meetings/` | `YYYY-MM-DD Thema.md` |
| Project Docs | `Arbeit/GoMedicus/Projekte/{Projekt}/` | Descriptive name |
| Evaluations | `Arbeit/GoMedicus/Projekte/{Projekt}/` | `Evaluation-{Thema}.md` |
| Knowledge | `Arbeit/GoMedicus/Wissen/` | Descriptive name |
| Brand Uni | `Arbeit/Brand University/{Bereich}/` | Context-dependent |
| HENQ | `Arbeit/HENQ/Projekte/` | Descriptive name |
| Private | `Privat/{Bereich}/` | Context-dependent |

### Frontmatter Convention

Every Vault file MARVIN creates should start with:

```yaml
---
created: YYYY-MM-DD
source: marvin-session
tags: [relevant, tags]
---
```

### After Writing

After creating or updating Vault files, remind Nikolai (or run if in a /end flow):
```bash
qmd embed
```
This re-indexes so the new content is immediately searchable.

### Search Before You Write

Always `qmd_deep_search` before creating a new file to check:
- Does similar content already exist?
- Should you update an existing file instead?
- What's the right location based on existing structure?
```

---

## Erweiterte /start Logik (optional)

Wenn du den `/start` Skill aufwerten willst, kannst du vor dem Briefing eine QMD-Suche einbauen:

```
# Im /start Flow, nach Step 2 (Load Context):
# → qmd_search für aktuelle Prioritäten aus current.md
# → Ergebnisse als zusätzlichen Kontext für das Briefing nutzen
```

Das gibt dir Vault-Kontext zu den Themen, die gerade aktiv sind, ohne dass Nikolai explizit danach fragen muss.

---

## QMD Maintenance

### Regelmäßiges Re-Indexing

Nach jeder Session, in der Vault-Files erstellt/geändert wurden:

```bash
qmd embed        # Nur neue/geänderte Dateien
```

### Status prüfen

```bash
qmd status       # Zeigt Collections, Dokumente, Embedding-Status
```

### Vollständiges Re-Index (selten nötig)

```bash
qmd update       # Re-scannt alle Collections
qmd embed -f     # Force re-embed (alles neu)
```

---

## Zusammenfassung: Was ändert sich für MARVIN?

| Vorher | Nachher |
|--------|---------|
| Liest nur `state/` und `sessions/` | Durchsucht gesamten Vault + eigene History semantisch |
| Weiß nur was in current.md steht | Findet relevante Notizen, Specs, Meeting Notes automatisch |
| Schreibt nur in `sessions/` und `state/` | Schreibt Knowledge-Artikel, Evaluations, Specs in den Vault |
| Jede Session fängt mit begrenztem Kontext an | Kann über Monate an Wissen semantisch suchen |

---

*Brief erstellt: 2026-02-21*
*Für: MARVIN (Claude Code Session)*
*Von: Nikolai via Claude.ai*
