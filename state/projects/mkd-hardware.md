---
project: mkd-hardware
status: active
owner: nikolai
updated: 2026-04-21
tags: [work, mkd, hardware, mdm]
---

# MedKitDoc Hardware-Verwaltung

## Status

**Hexnode MDM** — `medkitdoc.hexnodemdm.com`. 5 iPads konfiguriert. **SSoT:** [📱 iPad & Hardware Deployment (Notion)](https://www.notion.so/34157538249e81278deadf1846e2e9c8). Laufendes Google Doc: [Deployment Guide](https://docs.google.com/document/d/1IO6FOzfvm1eigfuuFLh9N837mgL4vtgt1nWSzc7WVMc/edit). Alter Google Doc (`18ILfetn…`) = deprecated.

## Open Items

- [ ] Web Clips aus Kiosk-Profil entfernen (Quelle unklar)
- [x] ~~ADE-Token ABM ↔ Hexnode erneuern~~ ✅ **20.04.2026** — neuer Token erfolgreich gesynct nach 2,5 Jahren tot. Nächste Erneuerung: ~20.04.2027 (Kalender-Reminder 2 Wochen vorher setzen)
- [x] ~~5. MedKitDoc-iPad enrollen~~ ✅ **20.04.2026** — via ADE + Apple Configurator "Wiederherstellen", Profil "GoMedico Services" (ohne Enforce Auth). Anleitung aktualisiert: `Wissen/Hexnode-iPad-Enrollment-Anleitung.md` (Vanilla Way)
- [ ] iPadOS-26 System-Apps (Apple Games, Anruf) in MKD-Standardpolicy via Restrictions → Blocked Apps ausblenden (`com.apple.games`, `com.apple.mobilephone`) — betrifft auch die anderen 4 iPads sobald updated
- [ ] Kiosk Policy MKD auf Device Group umbauen (aktuell 6 iPads via Direct-Assignments statt Device Group)
- [ ] ADE-Token-Renewal: Kalender-Reminder für ~06.04.2027 (2 Wochen vor 20.04.2027) setzen
- [ ] Screenshots in Notion einfügen (4 Platzhalter markiert — Nikolai manuell)
- [ ] Alter Google Doc (`18ILfetn…`) archivieren oder auf Notion-Pointer umschreiben
- [ ] Automation-Refactor: Policy auf Device Group mappen
- [ ] Configurator Blueprint "MedKitDoc iPad" anlegen
- [ ] Klären: Wer hat Hexnode-Account aufgesetzt? 2 ADE-Accounts
