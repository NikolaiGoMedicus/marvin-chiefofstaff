---
project: bdt-export
status: active
owner: nikolai
updated: 2026-04-21
tags: [work, bdt, tomedo, takeda]
---

# BDT Export / Import

## Status

- [GOM-2108](https://linear.app/gomedicusgroup/issue/GOM-2108) · Obsidian: `Projekte/BDT Spec/`
- BDT-Datei von Friedrich: Encoding+Datum gefixt, ⚠️ LF statt CR+LF (Byte-Prefixe falsch). Tomedo-Import-Test steht aus.

## arztkonsultation ak / Takeda

✅ Ausgeliefert. Onboarding-Guide bereinigt ([Google Doc](https://docs.google.com/document/d/159MlPMtVxmGMTddQXpjsxA5PACf6TtaDXbcUmC45rCc/edit)). **Technische Doku:** [📥 BDT Ingestion API (inbound)](https://www.notion.so/34557538249e8134924afbaf3062d78e) in Notion (Plattform & Produkt). Endpoint bereits Medivise-Bestand, AK nutzt denselben. **Beta-URI-Quirk:** API unter `/api/bdt-files` (nicht `/bdt-files`); Prod läuft unter Root. Swagger: [Prod](https://api.gomedicus.de/swagger/docs) · [Beta](https://beta-app.gomedicus.de/api/swagger/docs).

- [x] ~~Gmail-Draft an Steffi abgesendet (Videosprechstunden-Integration Status)~~ ✅
- [x] ~~Re: BDT Endpunkt für Takeda Projekt — Email an Steffi gesendet (17.04., CC: Christian Schneider, Ilya Beliaev, Jens Neubert)~~ ✅

## Open Items

- [ ] Steffi: Antwort auf 16:42-Upload-Frage abwarten (was hat sie nach URI-Fix wirklich gesendet?)
- [ ] Separaten Prod-API-Key für AK generieren (aktuell Beta + Prod = selber Key)
- [ ] Feedback-Loop: Nach jedem AK-Testupload Format-Review + Rückmeldung
- [ ] Endpoint 3.4 (JWT) aus Partner-Doc entfernen
- [ ] Compliance / DPA mit AK wegen Takeda-Studie prüfen
- [ ] Monitoring / Alerting auf Endpoint einrichten
- [ ] Medivise-Integration separat dokumentieren
