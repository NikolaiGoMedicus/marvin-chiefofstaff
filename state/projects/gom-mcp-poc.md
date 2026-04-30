---
project: gom-mcp-poc
status: waiting
owner: nikolai
updated: 2026-04-30
tags: [work, platform, mcp, ai, backend]
---

# GoMedicus MCP Server PoC (GOM-2530)

## Status

PoC tested successfully (27.04.). Smoke test passed — all 4 tools work, no PII leaks, edge cases handled. Nikolai chose not to send feedback to Adriano for now.

Jens-Handoff-Doc erstellt (30.04.) — strukturierte Übergabe der PoC-Ergebnisse und Bugs für Jens. Wartet auf Nikolais Entscheidung, ob/wann das Doc mit Jens geteilt wird.

## Open Items

- [ ] Decide whether to send Adriano feedback (see bugs below)
- [ ] Decide whether to share Jens-Handoff-Doc with Jens (30.04.)

## Waiting On

- Nikolai — decision on whether to send Adriano feedback (27.04.)
- Nikolai — decision on sharing Jens-Handoff-Doc (30.04.)

## Links

- [PR #819 — GOM-2530 PoC GoMedicus MCP Server for Chat-Based Analytics](https://github.com/GoMedicus/GoM-Backend/pull/819)
- [Jens-Handoff-Doc (Google Doc, 30.04.)](https://docs.google.com/document/d/1Yhl_ajnE6TfqV5J14xiIMMhfKLgOBRKw9gUOik6rJIM/edit)
- Branch: `adriano/gom-2530-poc-gomedicus-mcp-server-for-chat-based-analytics`
- Local patches (uncommitted): `src/mcp-server/seed-test-data.ts` (UUID fix), `smoke-test.ts`

## Context / Notes

### Local Environment (GoM-Backend, 27.04.)

- Docker: postgres + redis containers running
- npm deps installed, prisma migrated
- `admin-seed` + `mcp-seed` both seeded successfully
- All 4 MCP tools verified via smoke test

### Potential Feedback Bugs (if Nikolai decides to send)

1. **Hardcoded UUIDs** in `src/mcp-server/seed-test-data.ts` — Network, Location, and Service IDs are hardcoded instead of being generated dynamically. Breaks on fresh DBs.
2. **README misleading** — Claims "no manual setup needed" but `npm run prisma:seed` is required first (not documented).
3. **Missing npm scripts** — PR body references `mcp:start` and `mcp:inspect` scripts that don't exist in `package.json`.
