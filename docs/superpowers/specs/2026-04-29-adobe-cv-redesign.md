# Adobe Bewerbung — CV/CL Redesign (Forest Green, Tech-Editorial Mono)

**Date:** 2026-04-29
**Status:** Design approved, ready to build
**Scope:** Visual redesign of CV + Cover Letter for Adobe (R167792) and parallel Serviceplan application. HTML+PDF deliverables. Optional Figma asset later.

---

## Why

Aktuelle Unterlagen (Charter Serif, Editorial Modernist) sind tasteful, aber fühlen sich austauschbar an. Für eine Solutions-Consulting-Rolle in **Creative Innovation & AI** wird ein deutlicheres CI-Signal erwartet — der Kandidat soll spürbar einen "design-aware tech-editorial" Geschmack mitbringen. Gleichzeitig: ATS-Parsing-Fähigkeit erhalten (Adobe Workday).

Parallel-Use für Serviceplan-Bewerbung (München, Kennenlerntermin in 1-2 Wochen). Ein konsistentes CI dient beiden Bewerbungen + LinkedIn-Refresh.

## Approved Design Direction

**Style:** Tech-Editorial Mono (gewählt aus 3 Optionen: Editorial Modernist, Swiss Geometric, Tech-Editorial Mono)
**Color:** Forest Green + Cream (gewählt aus 4 Optionen: Terracotta, Mustard, Forest Green, Plum)
**Reference world:** Stripe Press, Wired, Vercel design system + a Penguin-Classics-style restraint

## Visual System

### Typography

| Role | Font | Notes |
|------|------|-------|
| Display (name) | Tiempos Headline / Source Serif Pro fallback | 30pt, weight 500, tight letterspacing -0.018em |
| Body | Tiempos Text / Source Serif Pro fallback | 10pt regular, line-height 1.55 |
| Mono accents | JetBrains Mono / IBM Plex Mono | 8.5pt, used for metadata, dates, section labels, taglines, contact |
| Section headers | JetBrains Mono | 8.5pt uppercase, letter-spacing 0.16em, prefix `// ` |

Tiempos is licensed; HTML render uses Source Serif Pro as system fallback. PDF embeds whichever resolves on render machine. Acceptable — Adobe likely won't complain.

### Color

```
Background    #FBF9F4   warm cream paper
Body text     #1A1A1A   near-black, soft on cream
Secondary     #555555   org names, captions
Tertiary      #5E5E5E   contact line, mono body
Muted         #888888   sub-meta (locations under dates)
Accent        #355E3B   forest green — top bar, monogram, section headers, dates, bullet markers
```

Accent usage: top-bar 6px, monogram block, section header text + underline, date metadata column, bullet markers.

### Layout

- **Page:** A4, margins 18mm top/bottom, 22mm left/right
- **Header:** flex row — left = name + tagline + contact, right = monogram block ("N · B")
- **Body grid for entries:** `30mm | 1fr` left-meta column (date + location, both mono) and content column
- **Top bar:** 6px solid forest green at very top of every page (CI anchor)
- **Section break:** `// section-name` mono uppercase + 1.5px green underline, padding-right 12mm so underline ends in middle of column
- **Bullets:** `·` markers in green, 14pt weight 700
- **Hairlines:** 0.4–0.5px subtle grey for section dividers

### Sections (CV)

1. Header (name, tagline, contact, monogram, top-bar)
2. Profile (2 paragraphs, no header)
3. `// experience` — 6 entries reverse-chronological:
   - GoMedicus (2025–now)
   - Brand University (2021–now)
   - Google (2015–2025) with sub-projects table + internal track
   - Miami Ad School (2017–2019)
   - Agency Leadership block (2006–2015) with sub-roles
   - advanced users (2001–2013, parallel)
4. `// core strengths` — 2×2 grid
5. `// selected speaking & public appearances` — table (Cannes, I/O Recap, dmexco, Brand U, Miami)
6. `// education & languages` — definition list
7. `// selected references` — 3 blockquotes (4th to be added when Swatch CMO confirms)

### Cover Letter Mirror

CL inherits the same CI: top-bar, monogram, mono accents, cream paper, forest green section markers. Body remains body-serif. No structural deviation from existing CL — just visual re-skin.

## Build Plan

1. **CV HTML rebuild** — replace current `_render/cv.html` styles + structure with new visual system. Keep markdown source `cv.md` as single source of truth (untouched).
2. **CL HTML rebuild** — replace current `_render/anschreiben.html` with same CI re-skin.
3. **PDF render** — Chrome headless (existing pattern) for both, save as `Nikolai-Bockholt_CV_Adobe.pdf` and `Nikolai-Bockholt_CoverLetter_Adobe.pdf`.
4. **Visual sanity check** — open both PDFs, confirm layout, page breaks, no orphan widow issues.
5. **Adobe project state update** — log changes in `state/projects/adobe.md`.

## Content De-AI-fication (added per user request)

User caught that current `cv.md` reads AI-generated. Cleanup needed before render:

- Remove all em-dashes (—) used as sentence connectors. Replace with periods, commas, or colons. Keep en-dashes (–) in date ranges (`2016–2023`) — those are typographically correct.
- Rewrite the worst offending phrases (chosen surgically or voice-rewrite, see Build Plan):
  - "from boardroom interest into shipped products"
  - "the rare combination of senior X, Y, and Z"
  - "the deep customer empathy that classical SC career paths can take years to build"
  - "I land in player-coach roles without ramp-up"
  - "Comfortable from practitioner to C-level"
  - "production campaigns, not POCs"
  - "first-hand view of how enterprise buyers actually evaluate solutions"
- Break long compound-clause sentences into shorter ones.
- Drop generic adjectives where they appear: "rare", "comprehensive", "deep", "robust" if hollow.

User chooses cleanup mode: **Surgical** (em-dashes + ~5 worst phrases, ~15 min) or **Voice rewrite** (profile + bullets fully recalibrated, requires user samples, ~30–40 min).

## Out of Scope (this session)

- Figma file build — separate session if user wants a Figma-native version. Current HTML→PDF is ATS-safe and Submission-ready.
- LinkedIn banner asset — same.
- Custom CL content rewrite — only re-skin, content stays.
- Swatch CMO 4th reference — pending user outreach to Michelle.
- Apply same CI to Serviceplan-specific CL — done after Adobe stack stable.

## Risks

- **Font fallback:** Tiempos isn't free-licensed; render uses Source Serif Pro. Acceptable, but user should confirm rendered PDF looks right before submit.
- **ATS parsing:** Two-column layout (date column + content column) can confuse some ATS parsers. Mitigation: use real HTML table-less grid with logical reading order — Workday usually parses fine. If concern: keep a fallback ATS-friendly single-column version.
- **Color reproduction:** Forest green on cream prints fine in CMYK; no concerns.

## Acceptance Criteria

- [ ] CV PDF renders 4 pages, all sections present
- [ ] CL PDF renders 1 page, content fits without truncation
- [ ] Top-bar present on every page
- [ ] No text overflow / orphan widow on page 4 references
- [ ] User visually approves before submission
