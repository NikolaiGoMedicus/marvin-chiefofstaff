---
name: medkitdoc-brand
description: |
  Provides MedKitDoc brand guidelines — colors, typography, design tokens, logo rules, and brand voice.
  Use when creating MedKitDoc-branded content (websites, emails, presentations, marketing),
  generating UI code with MedKitDoc styling, or reviewing designs for brand compliance.
license: MedKitDoc GmbH
compatibility: marvin
metadata:
  marvin-category: reference
  user-invocable: false
  slash-command: null
  model: default
  proactive: true
---

# MedKitDoc Brand Guidelines

## When to Use

- Creating MedKitDoc-branded web pages, presentations, emails, or documents
- Generating HTML/CSS/React code with MedKitDoc styling
- Reviewing screenshots or designs for brand compliance
- Writing MedKitDoc-facing copy in German (website, flyers, patient communications)

## Strictness

**Exact (no deviation):** Colors, hex values, font family (Inter), border radii, spacing tokens.
**Flexible (adapt to context):** Brand voice tone, layout structure, content length, section ordering.

## Brand Colors

```
Primary CTA button    → bg-medkit-lime (#deff52) + text-medkit-emerald (#064e3b)
Text on light bg      → #404040 (medkit-dark) or #064e3b (medkit-emerald)
Text on dark bg       → #FFFFFF
Hero background       → bg-gradient-to-br from-medkit-emerald via-emerald-800 to-teal-700
Secondary surfaces    → #A8E6CF (primary) or #C8F2E0 (primary-light)
Badges/pills          → #86efac (medkit-mint)
Card green accents    → #82b59a / #699d85 / #508472
Borders/muted         → #d4d4d8 (medkit-gray)
Light backgrounds     → #f4f4f5 (medkit-light)
Error state           → Tailwind red-500
```

All color tokens are defined in the [Tailwind Configuration](#tailwind-configuration) section below — use `medkit-*` classes in code.

## Typography

**Primary font:** Inter ([Google Fonts](https://fonts.google.com/specimen/Inter))
**Fallback:** system-ui, sans-serif

### Weights

| Weight | Value | Usage |
|--------|-------|-------|
| Regular | 400 | Body text |
| SemiBold | 600 | Headings, button labels, emphasis |
| Bold | 700 | Hero headings, strong emphasis |

### Scale

Standard Tailwind type scale (`text-sm` through `text-6xl`). Key sizes:

| Style | Class | Size |
|-------|-------|------|
| Hero heading | `text-3xl md:text-4xl lg:text-5xl xl:text-6xl` | 30px → 60px |
| Section heading | `text-2xl md:text-3xl lg:text-4xl` | 24px → 36px |
| Body | `text-base md:text-lg` | 16px → 18px |
| Small | `text-sm` | 14px |

**Rules:** Always antialiased. Min 16px body on web. Sentence case for buttons.

## Design Tokens

### Border radius

| Element | Radius |
|---------|--------|
| Buttons | 8px (`rounded-lg`) |
| Cards, sections | 12px (`rounded-xl`) |
| Large containers | 16px (`rounded-2xl`) |

### Shadows

| Size | Usage |
|------|-------|
| `shadow-sm` | Subtle card elevation |
| `shadow-lg` | Standard cards, hover states |
| `shadow-xl` | Prominent elements, modals |

### Gradients

**Hero:** `bg-gradient-to-br from-medkit-emerald via-emerald-800 to-teal-700` — hero sections, dark feature areas

## Buttons

### Primary (Lime CTA)

| State | Background | Text | Effect |
|-------|-----------|------|--------|
| Default | `bg-medkit-lime` (`#deff52`) | `text-medkit-emerald` (`#064e3b`) | — |
| Hover | `hover:bg-medkit-dark` (`#404040`) | `hover:text-white` | `scale-105`, `shadow-lg` |
| Active | — | — | `scale-95` |
| Focus | — | — | `ring-2 ring-medkit-lime` |

### Secondary

| State | Background | Text | Effect |
|-------|-----------|------|--------|
| Default | `bg-medkit-blue` (`#86efac`) | `text-medkit-emerald` (`#064e3b`) | — |
| Hover | `hover:bg-medkit-blue/90` | same | `shadow-lg` |

### Outline

| State | Background | Text | Border |
|-------|-----------|------|--------|
| Default | transparent | `text-medkit-dark` (`#404040`) | `border-2 border-medkit-dark` |
| Hover | `hover:bg-white/80` | same | `shadow-lg` |

### Sizing

| Size | Padding | Font size |
|------|---------|-----------|
| `sm` | `px-4 py-2` | `text-sm` |
| `md` | `px-8 py-3` | `text-base` |
| `lg` | `px-10 py-4` | `text-lg` |

Base styles: `inline-flex items-center justify-center font-semibold rounded-lg transition-all duration-300 transform hover:scale-105 active:scale-95`

## Logo

**IMPORTANT: Never generate or approximate the MedKitDoc logo as SVG/CSS/code. Always use `<img>` with the official asset URLs below.**

### Official Logo Assets

All assets are SVGs hosted on GCS (`gomedicus-public` bucket). Use these permanent URLs.

| Variant | URL | Use Case |
|---------|-----|----------|
| **Full logo (dark)** | `https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_full.svg` | Headers, navbar, documents, light backgrounds |
| **Full logo (white)** | `https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_full_white.svg` | Dark/emerald backgrounds, footers on dark bg |
| **Icon (dark)** | `https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_icon.svg` | Favicon, app icon, small contexts, light backgrounds |
| **Icon (white)** | `https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_icon_white.svg` | Icon on dark/emerald backgrounds |

### Usage in Code

**HTML:**
```html
<!-- Header / Navbar -->
<img src="https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_full.svg"
     alt="MedKitDoc" height="32" />

<!-- Icon only (e.g. favicon area, small badge) -->
<img src="https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_icon.svg"
     alt="MedKitDoc" width="32" height="32" />

<!-- On dark background -->
<img src="https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_full_white.svg"
     alt="MedKitDoc" height="32" />
```

**React/JSX:**
```jsx
const LOGO = {
  full: "https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_full.svg",
  fullWhite: "https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_full_white.svg",
  icon: "https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_icon.svg",
  iconWhite: "https://storage.googleapis.com/gomedicus-public/brand/medkitdoc/logo_icon_white.svg",
};

// In navbar (h-8 = 32px, matching existing site)
<img src={LOGO.full} alt="MedKitDoc" className="h-8" />

// On dark section
<img src={LOGO.fullWhite} alt="MedKitDoc" className="h-8" />
```

### Fallback (when external URLs are not possible)

If the output context cannot load external images (e.g. offline PDF, restricted environment), use text as placeholder:

```html
<span style="font-family: 'Inter', sans-serif; font-weight: 700; color: #064e3b; font-size: 24px;">MedKitDoc</span>
```

**Never** generate an SVG, CSS shape, or Unicode approximation of the logo icon.

### Logo Rules

- **Clear space:** min = height of icon mark
- **Min sizes:** Web 120px width, Favicon 32x32 (icon only)
- **Default height:** `h-8` (32px) in header/footer
- Don't stretch, skew, add effects, or place on busy backgrounds
- Always use `object-fit: contain` — never crop or distort

## Layout

| Token | Value | Usage |
|-------|-------|-------|
| Max width | `max-w-7xl` (1280px) | Content container |
| Padding | `px-4 sm:px-6 lg:px-8` | Responsive horizontal padding |

Standard Tailwind breakpoints: `sm` (640px), `md` (768px), `lg` (1024px), `xl` (1280px).

## Photography & Visual Style

- **Hero images:** Doctors/healthcare professionals with tablets/iPads, patient consultations, telemedizin scenes
- **Style:** Professional, warm, modern — real photography, not stock-feeling
- **Partner logos:** AOK, BARMER, TK, DAK, Allianz (insurance partners)
- **Certifications:** TÜV-geprüft, DSGVO-konform, CE-Kennzeichnung — display prominently

## Brand Voice

**Tagline:** "Fernbehandlung, nah am Menschen."

**Professional yet Accessible:** Clear, direct language. Medical competence with human warmth. No jargon without explanation.

**Patient-Centered:** Focus on patient benefits. Use "Sie" (formal). Emphasize safety, convenience, accessibility. Show empathy.

**Trust & Certification:** Lean into certifications (TÜV, DSGVO, CE) and partner networks (Krankenkassen). Trust is a key differentiator.

**Telemedizin Focus:** Highlight convenience of remote treatment — no waiting rooms, accessible from anywhere, qualified doctors.

**Good phrases:** "Fernbehandlung, nah am Menschen" · "Ihre Gesundheit in besten Händen — digital und persönlich" · "TÜV-geprüft und DSGVO-konform" · "Von Krankenkassen anerkannt" · "Medizinische Versorgung, wann und wo Sie sie brauchen"

## Tailwind Configuration

```js
// tailwind.config.js — extend section
{
  colors: {
    primary: {
      DEFAULT: '#A8E6CF',   // Light turquoise/mint surfaces
      light: '#C8F2E0',     // Lighter variant for backgrounds
      50: '#F0FAFB',
      100: '#CCEFF2',
      500: '#A8E6CF',
      600: '#8FD9B8',
      900: '#2A5B63',       // Dark teal variant
    },
    medkit: {
      emerald: '#064e3b',   // Primary brand — headings, hero bg, dark surfaces
      lime: '#deff52',      // Primary CTA — buttons, accent highlights
      limelight: '#d9f99d', // Soft lime for subtle accents
      mint: '#86efac',      // Secondary — badges, pills, soft highlights
      dark: '#404040',      // Body text on light backgrounds
      gray: '#d4d4d8',      // Borders, muted elements
      light: '#f4f4f5',     // Light background surfaces
      blue: '#86efac',      // Legacy alias → same as mint (used in secondary buttons)
    },
  },
  fontFamily: {
    sans: ['Inter', 'system-ui', 'sans-serif'],
    heading: ['Inter', 'system-ui', 'sans-serif'],
  },
}
```

## Examples

### Primary CTA Button (HTML + Tailwind)

Input: "Erstelle einen Primary CTA Button mit Label 'Jetzt Termin buchen'"

Output:
```html
<button class="inline-flex items-center justify-center bg-medkit-lime text-medkit-emerald hover:bg-medkit-dark hover:text-white font-semibold py-3 px-8 rounded-lg text-base transition-all duration-300 transform hover:scale-105 active:scale-95 hover:shadow-lg focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-medkit-lime">
  Jetzt Termin buchen
</button>
```

### Patient Communication (tone example)

Input: "Willkommens-Text für neue Telemedizin-Patienten"

Output:
> Willkommen bei MedKitDoc — Ihrer Plattform für Telemedizin.
>
> Bei uns erhalten Sie medizinische Versorgung auf höchstem Niveau — bequem von zu Hause. Unsere Ärztinnen und Ärzte sind TÜV-geprüft und beraten Sie persönlich per Video. Alle Daten werden DSGVO-konform verarbeitet.
>
> Buchen Sie jetzt Ihren ersten Termin — schnell, sicher und unkompliziert.

Note: formal "Sie", trust signals (TÜV, DSGVO), focus on convenience, no fear rhetoric.

### Brand Review (screenshot analysis)

When reviewing images or screenshots against these guidelines, check each item:

- **Font:** Must be Inter — flag Figtree, Arial, system fonts
- **Text color:** Must be `#404040` (medkit-dark) or `#064e3b` (Emerald) — flag pure black `#000`
- **Button radius:** 8px (`rounded-lg`) — flag `rounded`, `rounded-full`, or other values
- **CTA button color:** Lime `#deff52` bg with Emerald text, hover → dark bg with white text — flag blue buttons
- **Hero background:** Emerald gradient — flag flat colors or blue
- **Logo:** Must use `<img>` with official GCS URL — flag any generated SVG, CSS shape, or placeholder icon. Correct variant for background (dark on light, white on dark). Clear space respected, no effects.
- **Spacing:** `max-w-7xl` container with `px-4 sm:px-6 lg:px-8` padding

Report each issue with the specific value found vs. the correct value.

## Anti-Patterns

- No pure black `#000` for text — use medkit-dark (`#404040`) or Emerald (`#064e3b`).
- No decorative fonts. No ALL CAPS body text.
- Don't stretch/modify the logo. Don't add shadows/glows to it.
- **Never generate a logo SVG, CSS shape, or Unicode approximation.** Always use `<img src="...">` with the official asset URLs from the Logo section above.
- No fear-based messaging ("Ohne uns sind Sie ungeschützt!"). No unrealistic medical claims.
- No blue as primary color — MedKitDoc is green/lime, not blue (that's GoMedicus).
- Don't use Figtree font — that's GoMedicus. MedKitDoc uses Inter.

## Accessibility

- **Emerald on white:** high contrast ratio (passes WCAG AAA)
- **Lime on Emerald:** sufficient contrast for large text/buttons
- Min body text: 16px. Line-height: 1.5 min.
- Min touch target: 44x44px mobile. Keyboard navigable.

---

*Source: medkitdoc.de codebase (tailwind.config.js, Button.tsx, HeroSection.tsx) + logo assets*
*Updated: 2026-03-12*
