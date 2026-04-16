---
name: gomedicus-brand
description: |
  Provides GoMedicus brand guidelines — colors, typography, design tokens, logo rules, and brand voice.
  Use when creating GoMedicus-branded content (websites, emails, presentations, social media, flyers),
  generating UI code with GoMedicus styling, or reviewing designs and screenshots for brand compliance.
license: GoMedicus Group
compatibility: marvin
metadata:
  marvin-category: reference
  user-invocable: false
  slash-command: null
  model: default
  proactive: true
---

# GoMedicus Brand Guidelines

## When to Use

- Creating GoMedicus-branded web pages, presentations, emails, social media posts, or documents
- Generating HTML/CSS/React code with GoMedicus styling
- Reviewing screenshots or designs for brand compliance
- Writing GoMedicus-facing copy in German (website, flyers, decks, patient communications)

## Strictness

**Exact (no deviation):** Colors, hex values, font sizes, border radii, spacing tokens, font family (Figtree).
**Flexible (adapt to context):** Brand voice tone, layout structure, content length, section ordering.

## Brand Colors

### GoMedicus Custom Colors

| Name | Hex | Usage |
|------|-----|-------|
| **Main** | `#1C3660` | Primary brand color. Headings, body text, dark backgrounds |
| **Interaction** | `#4285F4` | Links, CTAs, interactive elements, blue full-bleed slides |
| **White** | `#FFFFFF` | Text on dark bg, clean surfaces |
| **Prime** | `#42F4AD` | GoMedicus Prime branding, success/growth accents |
| **Attention** | `#FFFEC3` | Callout backgrounds, important notes, warnings |

### UI Colors (shadcn/Tailwind)

| Token | Hex | Usage |
|-------|-----|-------|
| slate/200 | `#E2E8F0` | Light borders |
| slate/300 | `#CBD5E1` | Input borders, inactive buttons |
| slate/400 | `#94A3B8` | Placeholder text, muted labels |
| blue/50 | `#EFF6FF` | Lightest blue background |
| blue/100 | `#DBEAFE` | Secondary button bg |
| blue/200 | `#BFDBFE` | Secondary button hover, light link hover |
| blue/300 | `#93C5FD` | Light accents |
| blue/400 | `#60A5FA` | Primary CTA, outline accents, links on dark bg |
| gray/200 | `#E5E7EB` | Dividers |
| red/50 | `#FEF2F2` | Error background |
| red/400 | `#F87171` | Error borders, error text |
| stone/300 | `#D6D3D1` | Inactive/disabled button bg |

### Quick color guide

```
Primary CTA button → #60A5FA (blue/400)
Text on light bg → #1C3660 (Main)
Text on dark bg → #FFFFFF
Links / interactive → #4285F4 (Interaction)
Secondary button bg → #DBEAFE (blue/100)
Input border → #CBD5E1 (slate/300)
Placeholder text → #94A3B8 (slate/400)
Full-bleed blue slide → #4285F4 (Interaction)
Prime/success accent → #42F4AD (Prime)
Error state → #F87171 border + #FEF2F2 bg
```

## Typography

**Primary font:** Figtree ([Google Fonts](https://fonts.google.com/specimen/Figtree))
**Fallback:** system-ui, -apple-system, sans-serif

**Accent font:** Handwritten/script font for section labels in pitch decks (e.g. "Vision", "GoMedicus Heute"). Exact typeface TBD.

### Weights

| Weight | Value | Usage |
|--------|-------|-------|
| Regular | 400 | Body text |
| Medium | 500 | Links, Heading XS, labels |
| SemiBold | 600 | Heading M/S, Copy XS |
| Bold | 700 | Heading L, Big Numbers, CTAs, Copy labels |

### Headings (desktop → mobile)

| Style | Desktop | Mobile |
|-------|---------|--------|
| **Heading L** | 100px, Bold, LH 95% | 32px, Bold, LH 130% |
| **Heading M** | 48px, SemiBold, LH 130% | 24px, SemiBold, LH 130% |
| **Heading S** | 32px, SemiBold, LH 130% | 18px, SemiBold, LH 130% |
| **Heading XS** | 24px, Medium, LH 130% | 16px, SemiBold, LH 130% |
| **Big Numbers** | 80px, Bold, LH 100% | 40px, Bold, LH 100% |

### Copy (desktop → mobile)

| Style | Desktop | Mobile |
|-------|---------|--------|
| **Copy L** | 32px, Regular/Bold, LH 150% | 16px, Bold, LH 130% |
| **Copy M** | 24px, Regular/Bold, LH 150% | 14px, SemiBold, LH 130% |
| **Copy S** | 18px, Regular/Bold, LH 150% | 12px, Regular/Bold, LH 150% |
| **Copy XS** | 14px, SemiBold, LH 120% | 10px, SemiBold, LH 120% |

**Rules:** Always antialiased. Min 16px body on web. Sentence case for buttons.

## Design Tokens

### Border radius

| Element | Radius |
|---------|--------|
| Buttons | 4px (`rounded`) |
| Inputs | 6px (`rounded-md`) |
| Cards, images, sections | 12px (`rounded-xl`) |

### Shadows

| Size | Usage |
|------|-------|
| `shadow-sm` | Subtle card elevation |
| `shadow-md` | Standard cards, buttons |
| `shadow-lg` | Modals, prominent elements |

### Gradients

**Primary:** `linear-gradient(109deg, #4285F4 0%, #D5E1F6 182.47%)` — hero sections, CTA bg
**Secondary:** `linear-gradient(235deg, #C2E5FF -59.26%, #FEF2F2 100%)` — careers/growth

## Buttons

### Primary

| State | Background | Text | Border |
|-------|-----------|------|--------|
| Default | `#60A5FA` | white | — |
| Hover | (darken) | white | — |
| Inactive | `#D6D3D1` | white | — |
| Outline | transparent | `#60A5FA` | 1px `#60A5FA` |

Padding: `12px 32px`, radius: 4px, font: Bold, font-size: Copy S (18px desktop / 14px mobile).

### Secondary

| State | Background | Text | Border |
|-------|-----------|------|--------|
| Default | `#DBEAFE` | `#1C3660` | — |
| Hover | `#BFDBFE` | `#1C3660` | — |
| Inactive | `#CBD5E1` | `#94A3B8` | — |
| Outline | transparent | `#60A5FA` | 1px `#60A5FA` |

Padding: `12px 18px`, radius: 4px, font: Bold. Has back/forward variants with arrow icons.

### Links

| Context | Default | Hover | Underline |
|---------|---------|-------|-----------|
| Dark bg text | `#60A5FA` | `#BFDBFE` | `#60A5FA` underline |
| Light bg text | `#1C3660` | `#94A3B8` | `#1C3660` underline |

Font weight: Medium (500).

### Inputs

- Border: `#CBD5E1` (slate/300), radius: 6px, padding: 12px
- Label: `#94A3B8` (slate/400), SemiBold, Copy XS size
- Value: `#1C3660` (Main), Regular, Copy S size
- Error: bg `#FEF2F2`, border `#F87171`

## Logo

**IMPORTANT: Never generate or approximate the GoMedicus logo as SVG/CSS/code. Always use `<img>` with the official asset URLs below.**

### Official Logo Assets

All assets are SVGs hosted on GCS (`gomedicus-public` bucket). Use these permanent URLs.

| Variant | URL | Use Case |
|---------|-----|----------|
| **Icon (blau)** | `https://storage.googleapis.com/gomedicus-public/brand/logo_icon.svg` | Favicon, app icon, small contexts, light backgrounds |
| **Icon (weiß)** | `https://storage.googleapis.com/gomedicus-public/brand/logo_icon_white.svg` | Icon on dark/blue backgrounds |
| **Full logo + text (blau)** | `https://storage.googleapis.com/gomedicus-public/brand/logo_full.svg` | Headers, navbar, documents, light backgrounds |
| **Full logo + text (weiß)** | `https://storage.googleapis.com/gomedicus-public/brand/logo_full_white.svg` | Dark/blue backgrounds, footers on dark bg |

### Usage in Code

**HTML:**
```html
<!-- Header / Navbar -->
<img src="https://storage.googleapis.com/gomedicus-public/brand/logo_full.svg"
     alt="GoMedicus" height="40" />

<!-- Icon only (e.g. favicon area, small badge) -->
<img src="https://storage.googleapis.com/gomedicus-public/brand/logo_icon.svg"
     alt="GoMedicus" width="32" height="32" />

<!-- On dark background -->
<img src="https://storage.googleapis.com/gomedicus-public/brand/logo_full_white.svg"
     alt="GoMedicus" height="40" />
```

**React/JSX:**
```jsx
const LOGO = {
  full: "https://storage.googleapis.com/gomedicus-public/brand/logo_full.svg",
  fullWhite: "https://storage.googleapis.com/gomedicus-public/brand/logo_full_white.svg",
  icon: "https://storage.googleapis.com/gomedicus-public/brand/logo_icon.svg",
  iconWhite: "https://storage.googleapis.com/gomedicus-public/brand/logo_icon_white.svg",
};

// In navbar
<img src={LOGO.full} alt="GoMedicus" className="h-10" />

// On dark section
<img src={LOGO.fullWhite} alt="GoMedicus" className="h-10" />
```

### Fallback (when external URLs are not possible)

If the output context cannot load external images (e.g. offline PDF, restricted environment), use text as placeholder:

```html
<span style="font-family: 'Figtree', sans-serif; font-weight: 700; color: #1C3660; font-size: 24px;">GoMedicus</span>
```

**Never** generate an SVG, CSS shape, or Unicode approximation of the logo icon.

### Logo Rules

- **Clear space:** min = height of icon mark
- **Min sizes:** Web 120px, Print 30mm, Favicon 32x32 (icon only)
- **Variations:** Full color (default), mono dark (`#1C3660`), mono light (`#FFFFFF`)
- Don't stretch, skew, add effects, or place on busy backgrounds
- Always use `object-fit: contain` — never crop or distort

### Sub-brands

- **Go PRIME** — HzV program badge (Go icon + "PRIME" label, uses Prime color `#42F4AD`)
- **Let's Go** — Tagline used on vision/closing slides (script font + Go icon)

## Layout

| Breakpoint | Max width | Padding |
|------------|-----------|---------|
| Mobile (< 768px) | 100% | 20px |
| Tablet (768–1110px) | 100% | 40px |
| Desktop (> 1110px) | 1440px | 64px |

| Spacing | Mobile | Desktop |
|---------|--------|---------|
| Section padding (vertical) | 32px | 56px |
| Card grid gap | 16px | 24px |
| Content block spacing | 24px | 32px |

## Photography & Icons

- **Photos:** Real photography of doctors and patients. Professional, warm, modern.
- **Team photos:** Circular crop with light blue border.
- **Icons:** Line-art/outline style in blue tones.
- **Checkmark bullets:** Blue checkmarks for feature/benefit lists.

## Brand Voice

**Professional yet Approachable:** Clear, direct language. Avoid jargon. Explain complex topics simply. Conversational but not casual.

**Patient-Centered:** Focus on patient benefits. Use "Sie" (formal). Emphasize care, safety, comfort. Show empathy.

**Innovation & Efficiency:** Highlight modern technology, convenience, speed. Forward-thinking approach.

**Inclusive & Modern:** Gender-neutral language when possible. Diverse patient representation. Contemporary language.

**Good phrases:** "Ihre Gesundheit liegt uns am Herzen" · "Moderne Medizin, persönliche Betreuung" · "Wir sind für Sie da — deutschlandweit" · "Schnell, sicher, kompetent"

## Tailwind Configuration

```js
// tailwind.config.js — extend section
{
  colors: {
    main: '#1C3660',
    interaction: '#4285F4',
    prime: '#42F4AD',
    attention: '#FFFEC3',
  },
  fontFamily: {
    sans: ['Figtree', 'system-ui', '-apple-system', 'sans-serif'],
  },
  borderRadius: {
    DEFAULT: '4px',  // buttons
    md: '6px',       // inputs
    xl: '12px',      // cards, sections
  },
}
```

## Examples

### Primary CTA Button (HTML + Tailwind)

Input: "Erstelle einen Primary CTA Button mit Label 'Termin buchen'"

Output:
```html
<button class="bg-blue-400 hover:bg-blue-500 text-white font-bold py-3 px-8 rounded font-['Figtree'] text-lg transition-colors">
  Termin buchen
</button>
```

### Patient Email (tone example)

Input: "Willkommens-Mail für neue Patienten"

Output opening:
> Sehr geehrte Frau Müller,
>
> herzlich willkommen bei GoMedicus. Wir freuen uns, Sie in unserer Praxis begrüßen zu dürfen. Unser Team steht Ihnen jederzeit zur Verfügung — ob bei Fragen zu Ihrem Termin, Ihren Unterlagen oder Ihrem Anliegen.

Note: formal "Sie", empathetic, clear, no jargon, no fear rhetoric.

### Brand Review (screenshot analysis)

When reviewing images or screenshots against these guidelines, check each item:

- **Font:** Must be Figtree — flag Inter, Arial, system fonts
- **Text color:** Must be Main `#1C3660` — flag pure black `#000`
- **Button radius:** 4px — flag rounded-full, 8px, or other values
- **CTA button color:** `#60A5FA` — flag if Interaction `#4285F4` is used for buttons (that's for links)
- **Input borders:** `#CBD5E1` with 6px radius — flag deviations
- **Spacing:** Section padding 56px desktop / 32px mobile — flag crowded layouts
- **Logo:** Must use `<img>` with official gomedicus.com URL — flag any generated SVG, CSS shape, or placeholder icon. Correct variant for background (blau on light, weiß on dark). Clear space respected, no effects.

Report each issue with the specific value found vs. the correct value.

## Anti-Patterns

- No pure black `#000` for text — use Main (`#1C3660`).
- No decorative fonts. No ALL CAPS body text.
- Don't stretch/modify the logo. Don't add shadows/glows to it.
- **Never generate a logo SVG, CSS shape, or Unicode approximation.** Always use `<img src="...">` with the official asset URLs from the Logo section above.
- No fear-based messaging. No unrealistic medical claims. No patronizing language.
- Don't crowd elements. Don't ignore responsive breakpoints. Don't skip mobile optimization.

## Accessibility

- **Main on white:** 9.4:1 contrast ratio (passes WCAG AA)
- **Interaction on white:** ~4.5:1 (passes AA for normal text)
- Min body text: 16px. Line-height: 1.5 min. Left-aligned (no justified).
- Min touch target: 44x44px mobile. Keyboard navigable.

---

*Source: Figma styleguide (GoMedicus-Group, node 233:588) + Intro Wrist 03032026 presentation*
*Updated: 2026-03-09*
