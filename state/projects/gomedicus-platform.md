---
project: gomedicus-platform
status: active
owner: nikolai
updated: 2026-04-21
tags: [work, platform, mvp, priority]
---

# GoMedicus Platform & MVP

## Status

⚠️ **MVP muss live.** Timeline: Kids Juni, Lütjensee+Kronprinzenbau Juli, 2 weitere Okt. PVS: Tomedo bevorzugt.

- Staging → Prod offen: GOM-2335 (Phone Validation), GOM-1977 (Birthday Field)
- Corti Template: ✅ unblocked (GOM-2446). GOM-2689 Transcript: ✅ non-blocking decided. GOM-2736 BDT: ✅ Platzierung decided.
- GOM-2730 Multi-Service Pricing: Feedback Basti+Jens ausstehend

## Notion Plattform & Produkt

Letzte Aktualisierung 17.04. (synced with current.md): April-Snapshot (QA 20.03., MVP-Decisions 14.04., GOM-2638 Spec + PR #855, Cancellation Flow, Service Visibility, Email Templates, PVS Analysis, Evaluations, Alice Offboarding), Sub-Bereiche Owner aktualisiert (Kalender+Video → Interim TBD + Ben; Patientensteuerung → Friederike + Interim TBD), ICD-10-GM Synonym Search Link gefixt. [Notion](https://www.notion.so/31357538249e8137bb21c3cec34cb48b)

## Video-Plattform Branding

Working Doc live: [Slack Canvas](https://gomedicusgroup.slack.com/docs/T04KJACGGBH/F0ATJHGKX5K) in Group DM mit Jens/Sebastian/Antonia. Offene Entscheidungen: Service-Name, URL/Domain, Brand-Architektur (A/B/C/D), Design-Variante (aktuell 2 Stimmen für rechts), Positioning-Frame (B2C/B2B2C/Dual). MARVIN-Input mit Benchmark, Name-Vorschlägen + Risiko-Flags ergänzt. Next Actions bis Mo 20.04. im Canvas.

## QA Bug Review — Video MVP Testing (20.03.)

46 Items, 8 kritisch. ⚠️ Blocker für MKD Integration Roadmap Phase 2.

- [Google Doc DE](https://docs.google.com/document/d/1unofwTdNlppTddQex3PPLOa9n0Y0eaBaNKNOL9_M_2w/edit) · [EN](https://docs.google.com/document/d/1zVaDHpeI7D6hU9-m5SKiNrxbPeA2Fdk2zY5rmXiHBSs/edit)
- [ ] Docs an Alice, Basti, Nicolas teilen
- [ ] Priorisierungs-Meeting + Linear-Tickets
- [ ] Dedizierter Video-Call-Test (Transkription + AI Summary)

## Cancellation Flow — Video Appointments (10.04.)

Nicolas hat 9 offene Business-Fragen + 5 Edge Cases aufbereitet. Proposed Decisions Doc erstellt (MVP-Linie: 24h-Frist, voller Refund innerhalb, keiner danach, Cancel+New pre-filled, keine Limits/Gebühren/Sonderregeln).

- **Nicolas' Doc:** Cancellation Constraints.docx (Drive)
- **Proposed Decisions:** [Google Doc](https://docs.google.com/document/d/1f4fI5sW4qxYCdta8pabQ6noHDIdGP4hjrYgN4e5e4to/edit) — intern geteilt
- [ ] Monday Platform Sync: 9 Punkte durchgehen + Entscheidungen treffen
- [ ] Nach Sync: Dev Ticket finalisieren

## Service Visibility & Categorization (27.03.)

- [Summary-Doc](https://docs.google.com/document/d/1JKTW3Ncd7NQKOIUKUoGzG8h-iYc0QZugPavaCZqT-lo/edit) in Drive 01 Buchungs- und Terminsystem
- 2-Dimensionen-Modell: Listing Visibility (patient/public/hybrid/none) + Routable Flag
- 15 Services gemappt: 5 Public, 10 Routing-only
- [ ] Slack an Nicolas, Juanma, Alice senden (Entwurf steht)
- [ ] Team-Feedback abwarten → Technical Spec

## GOM-2638 — Buchungsflow Rechtsdokumente Platzierung

- [Spec-Doc](https://docs.google.com/document/d/1Xjaks1_9ySgA_G0Q6rdNYR7cegUJugIY7Ttw2wxlXEY/edit) erstellt (02.04.) — beide Flows (Gast + registriert), Terminologie, Checkbox-Logik
- ✅ Sebastian Schulz Review abgeschlossen (02.04.), Feedback eingearbeitet (07.04.): Schritt 3 aufgeteilt (3.1 Name+Email, 3.2 Stammdaten), Datenschutzhinweise prominent auf Landing Page, AGB in Plattform abrufbar
- PR #855 (Auth-Flow) in Review
- ⚠️ Formatierung im Doc noch manuell fixen (Heading-Styles Schritt 3.1/3.2)
- [ ] Alice: Antwort auf Trägergesellschaftswechsel-Frage (Fast-Follow oder Launch-Scope?)
- [ ] Nach Alice-Feedback: Scope-Abgrenzung ggf. anpassen + Link auf GOM-2638 posten

## PVS-Workflow-Analyse (Ben, Feb 2026)

[Google Doc](https://docs.google.com/document/d/1jcDjpRT9Z3j37tabVdR3fLNxw9UpPrcsV6Lgm5slzLc/edit). Tomedo API v4.22.8 + Medatixx FHIR R4 Workflow-Mapping, Multi-TG Patient-Sync Konzept v1.0, Datenmigrations-Plan (DRAFT). Drive: 09 Plattform-Architektur. [Notion: PVS Integration](https://www.notion.so/31357538249e81bea8abde305bc9a8c0). Review Philipp ausstehend.

## Email Templates (SendGrid)

✅ Vollständig versioniert (17.04.). 16 Templates im GitHub Repo, synced via Python-Script mit SendGrid.

- **Repo:** [GoMedicus/email-templates](https://github.com/GoMedicus/email-templates) — 16 Templates, 5 PRs gemerged
- **PRs (alle gemerged):** Content Harmonization, Sync Tooling, Visual Harmonization, Du-form Fix, Preview Gallery
- **Drive:** `/Platform/Email-Templates` — Previews aller 16 Templates, geteilt via Domain-Zugang
- **Notion:** Projektseite unter Plattform & Produkt angelegt
- **Sync:** Python-Script zieht Templates aus SendGrid → Repo (vollständige Versionierung)
- Templates: contact-form, email-confirmation, appointment-scheduled, forgot-password-email, referral-request-succesful-confirmation (Typo: succesful), patient-care-manager-creation + 10 weitere
- **Gaps für MVP/Launch-Check:** kein Reminder-Mail, kein Cancel/Reschedule-Mail, kein Video-Termin-spezifisches Mail
- [ ] Slack-Draft an Jens absenden (Overview + Gap-Observations) — im Outbox

## Offene Issues

- GOM-2689 — ✅ Transcript Failure UX: **Non-blocking MVP entschieden (14.04.)** — Jens + Sebastian approved. Arzt kann Konsultation ohne Transcript abschließen, manuelles Notizfeld als Fallback. Re-Record/Retry als Fast-Follow. Decision auf Linear gepostet.
- GOM-2335 — 🟡 Staging. Phone Validation (Prod-Deployment nötig)
- GOM-1977 — 🟡 Staging. Birthday Field (hängt seit Januar)
- GOM-1976 — 📋 Notification Events — Product Definition mit Alice
- [ ] Call mit Nele — PVS-Feldnutzung
- [ ] Corti/CTI Update ans Team

## Evaluationen

- **Payment: Stripe** — [Spec-Doc](https://docs.google.com/document/d/1w9U6Deno9z7evq0dQDMDmXTIT4swlcpA4hWjflMUCNo/edit) (Payment + GOÄ Invoice, 3 MVZ Connected Accounts). [DPIA-Doc](https://docs.google.com/document/d/1L8dDuk1FE2B51eHBEr3bI0qa139q7hGDqoEoPku2MCA/edit). MVP-Basispreis: Zi. 3+A5+75 = 48,26 €. Offen: Vergütungsmodell — [Decision-Paper](https://docs.google.com/document/d/1SKPVHwf2qUEbqUul5jv5c5vTMVRaSqiON9MPD9IS1m4/edit) an Jens (14.04.).
- **Analytics Tool** — Plausible CE Self-Hosted. Docs fertig ([Notion](https://www.notion.so/31757538-249e-81a8-a2b7-e80ba5cbbd1f)). Nächste: Docs an Ben, GA/PostHog entfernen, VPS aufsetzen.
- **Corti ICD Agent** — Blocker: Nur ICD-10-CM (US), nicht GM (DE). Arnim fragen.
- **ICD-10-GM Synonym Search** — [GOM-2345](https://linear.app/gomedicusgroup/issue/GOM-2345). TODO: Slack an Sebastian Schulz.
