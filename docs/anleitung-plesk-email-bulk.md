# Plesk E-Mail-Adressen per Script anlegen

Anleitung für Sebastian — Windows PC + Claude Desktop

---

## Was du brauchst

- Zugang zum Plesk-Panel (`khpm1039.hpress.de:8443`)
- Dein Plesk-Benutzername + Passwort
- Eine CSV-Datei mit den E-Mail-Adressen und Passwörtern
- Claude Desktop auf deinem PC

## Schritt 1: CSV-Datei vorbereiten

Erstelle eine Datei `emails.csv` auf deinem Desktop mit diesem Format:

```
email,passwort
vorname.nachname@domain.de,SicheresPasswort123!
info@domain.de,AnderesPasswort456!
```

- Erste Zeile ist die Kopfzeile (genau so lassen)
- Pro Zeile eine E-Mail-Adresse + Passwort
- Keine Leerzeichen vor/nach dem Komma
- Speichern als UTF-8

> **Tipp:** Du kannst die Datei auch in Excel erstellen und als CSV (UTF-8) exportieren.

## Schritt 2: Plesk-Zugangsdaten sicher hinterlegen

Damit deine Plesk-Zugangsdaten nicht im Chat mit Claude auftauchen, speicherst du sie als Umgebungsvariablen.

**PowerShell öffnen** (Windows-Taste → "PowerShell" eingeben → öffnen) und diese beiden Befehle ausführen:

```powershell
[System.Environment]::SetEnvironmentVariable("PLESK_USER", "dein-benutzername", "User")
[System.Environment]::SetEnvironmentVariable("PLESK_PASS", "dein-passwort", "User")
```

Ersetze `dein-benutzername` und `dein-passwort` mit deinen echten Plesk-Daten.

> **Wichtig:** PowerShell danach schließen und neu öffnen, damit die Variablen aktiv werden.

## Schritt 3: Claude Desktop Prompt

Öffne Claude Desktop und paste folgenden Prompt. Ersetze `DOMAIN` durch die Ziel-Domain:

---

**Prompt zum Kopieren:**

> Ich muss E-Mail-Adressen in Plesk anlegen. Schreib mir ein PowerShell-Script das folgendes tut:
>
> 1. Liest die CSV-Datei `C:\Users\DEIN_NAME\Desktop\emails.csv` (Spalten: email, passwort)
> 2. Liest Plesk-Credentials aus den Umgebungsvariablen `PLESK_USER` und `PLESK_PASS`
> 3. Für jede Zeile in der CSV: Legt die E-Mail-Adresse auf dem Plesk-Server an via Plesk XML API
> 4. Gibt pro Adresse aus ob es geklappt hat oder nicht
>
> Technische Details:
> - Plesk-Server: `https://khpm1039.hpress.de:8443`
> - API-Endpoint: `https://khpm1039.hpress.de:8443/enterprise/control/agent.php`
> - Auth: HTTP-Header `HTTP_AUTH_LOGIN` und `HTTP_AUTH_PASSWD`
> - XML-Body pro E-Mail:
> ```xml
> <?xml version="1.0" encoding="UTF-8"?>
> <packet version="1.6.9.1">
>   <mail>
>     <create>
>       <filter>
>         <site-name>DOMAIN</site-name>
>         <mailname>
>           <name>LOCALPART</name>
>           <mailbox>
>             <enabled>true</enabled>
>           </mailbox>
>           <password>
>             <value>PASSWORT</value>
>             <type>plain</type>
>           </password>
>         </mailname>
>       </filter>
>     </create>
>   </mail>
> </packet>
> ```
> - LOCALPART = Teil vor dem @, DOMAIN = Teil nach dem @
> - PowerShell `Invoke-WebRequest`, SSL-Zertifikatsfehler ignorieren
> - Bitte am Anfang einen Testlauf-Modus einbauen der nur die erste Adresse anlegt (zum Testen)
>
> Speichere das Script als `C:\Users\DEIN_NAME\Desktop\create-emails.ps1`

---

## Schritt 4: Script prüfen und ausführen

1. **Script lesen** — Claude erstellt dir das Script. Lies es kurz durch, frag Claude wenn was unklar ist.

2. **Testlauf** — Führe das Script zuerst im Testmodus aus (nur 1 Adresse):
   ```powershell
   Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned
   cd Desktop
   .\create-emails.ps1 -TestRun
   ```

3. **In Plesk prüfen** — Schau im Plesk-Panel unter E-Mail nach ob die Testadresse da ist.

4. **Alle anlegen** — Wenn der Test geklappt hat:
   ```powershell
   .\create-emails.ps1
   ```

## Troubleshooting

| Problem | Lösung |
|---------|--------|
| "Script kann nicht ausgeführt werden" | `Set-ExecutionPolicy -Scope CurrentUser -ExecutionPolicy RemoteSigned` ausführen |
| "Zugriff verweigert" / 403 | Plesk-Benutzername oder Passwort falsch → Schritt 2 wiederholen |
| "SSL-Fehler" | Claude sollte das im Script behandelt haben. Falls nicht: Claude fragen. |
| API antwortet mit Fehler-XML | Fehlermeldung an Claude pasten, der hilft dir weiter |
| Einzelne Adresse schlägt fehl | Existiert die Adresse vielleicht schon? In Plesk prüfen |

## Hinweise

- **Passwörter** tauchen nie im Chat mit Claude auf — sie bleiben in der CSV und in den Umgebungsvariablen
- **CSV nach Abschluss löschen** — die Datei enthält Klartext-Passwörter
- **Umgebungsvariablen aufräumen** wenn alles fertig ist:
  ```powershell
  [System.Environment]::SetEnvironmentVariable("PLESK_USER", $null, "User")
  [System.Environment]::SetEnvironmentVariable("PLESK_PASS", $null, "User")
  ```
