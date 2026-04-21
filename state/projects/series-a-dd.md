---
project: series-a-dd
status: active
owner: nikolai
updated: 2026-04-21
tags: [work, due-diligence, compliance]
---

# Series A Tech DD Prep

## Status

**DD läuft.** Owners: Ben (CTO) + Nikolai (CDO). [DD Master](https://www.notion.so/32757538249e8151b9e2d55985c58b96) · [Tech DD](https://www.notion.so/32757538249e8181a8cbd5c317fe7d4d) · [Fragenkatalog](https://www.notion.so/32957538249e81e58f51dfe4ff3ec27f) (24✅/22🟡/7🔴). **Investor-Feedback (16.04.):** Investoren wollen Operational Maturity + Benchmarks. Nikolais Anteil ~20%.

## IT-Integration Deliverables

- [Scorecard](https://docs.google.com/document/d/16CycnHLBl1N1quuo1_t-e6X2iOnot-ofIllwBBfPhjI/edit) (WIP, 31% — 16/51 Meilensteine)
- [Playbook](https://docs.google.com/document/d/1lShnhdqXWIOQvIVjhThVLlkMY80hq7x8W9XYst6Lva8/edit) (WIP, 5 Phasen)
- [Drive](https://drive.google.com/drive/folders/1gnJY9eTsSUAFF80FUvXhgEPzrnVPmkhT)
- [ ] CDIO-Profil + Hiring-Pipeline — noch nicht erstellt

⚠️ **§393 SGB V (Cloud C5):** GoMedicus braucht ggf. eigenes C5-Testat. Prüfauftrag Sebastian Schulz. Wird durch [mkd-integration.md](mkd-integration.md) Phase 3 (Backend-Migration) getriggert.

## Open Items

- [ ] Ben: IP-Transfer Cloudnonic dokumentieren (LOI Precondition! 🔴 Blocker)
- [ ] Ben: Skalierungskonzept (KW13)
- [ ] Ben: PenTest-Status (3,5 Jahre alt, 11 offene Findings)
- [ ] Ben: DSFA aktualisiert seit Jul 2022?
- [ ] Nico: Governance-Doku Grundgerüst (KW13, braucht Ben-Input)
- [ ] Staging→Prod Deployment-Sprint (43 Urgent Bugs auf 0)
- [ ] DSGVO formale Dokumente (VVT, TOM, AVV-Register) mit Legal/DSB
- [ ] Produktroadmap Timelines mit Ben/Alice abstimmen

## Risiken

- 🔴 IP-Transfer Cloudnonic = LOI Precondition (Blocker)
- 🟡 PenTest 3,5 Jahre alt — neuer Test nötig
- 🟡 DSFA 4 Jahre alt — Aktualisierung nötig
- 🟡 Monitoring/Uptime-Daten unklar

## Cleura / EU-Cloud

Post-MVP-Thema. [Market Scan](https://www.notion.so/34157538249e81a4a375f8db5ef51f46) · [Antworten-Draft](https://www.notion.so/34157538249e81e09bdee6305d6bfc37). Ben-DM steht, nicht gesendet.

## MKD DD

[Notion](https://www.notion.so/32757538249e812a9d64db9830f7afb6) — 🟡 Teildaten, 7/9 Deliverables rot.

- Confluence gesichtet (27.03.): Multi-Tenancy, Infrastructure, SW-WI-01, 8 ADRs → Erkenntnisse in Notion
- DSFA (Jul 2022) nur als PDF — manuell zu sichten
- Owner "???" bei 3 Deliverables → Sebastian klären
- [ ] Sebastian: MKD DD TODO-Liste mit 7 roten Deliverables + Owner-Klärung
- Komplementär zur [mkd-integration.md](mkd-integration.md)
