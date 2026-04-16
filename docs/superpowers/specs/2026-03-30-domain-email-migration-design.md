# Domain & Email Migration Playbook — Post-Acquisition IT-Integration

## Context

When GoMedicus acquires a practice group, their domains and email infrastructure need to be integrated into GoMedicus-controlled systems. This playbook covers the staged migration of domain registration, DNS, and email hosting from an external provider to GoMedicus infrastructure (Plesk mail server on gomedicus.com).

### Design Decisions

- **Full migration to Plesk** — no hybrid setups where mail stays at the old provider. Clean cut, everything under one roof.
- **Staged rollout** — not a big-bang weekend migration. Phases allow learning from early steps and reduce risk for critical addresses.
- **Discovery-first** — we don't assume we know which addresses are active. The process includes figuring that out.
- **Client-side support only for critical addresses** — unkritische/Funktionsadressen get server-side setup only. Critical addresses get full end-to-end support (new credentials, client reconfiguration, personal contact).
- **Delegation-friendly** — designed so that an IT person (e.g. Sebastian Luitle) can execute most steps independently, with the project lead (Nikolai) steering and reviewing.

### First Application

- **Domains:** paedoc.de + paedoc-mvz.de
- **Source:** IONOS (Registrar + DNS + Mail)
- **Target:** GoMedicus Registrar + DNS + Plesk Mail
- **Scope:** 27 email addresses across 2 domains
- **Operators:** Nikolai (steering) + Sebastian Luitle (execution)

---

## Phase 1: Discovery

**Goal:** Understand what exists and what's actively used.

**Steps:**

1. Compile full list of email addresses on the domain(s) — source: registrar control panel, DNS MX records, team knowledge
2. Categorize each address:
   - **Critical** — daily use, patient communication, prescriptions, labs, external partners
   - **Active** — used but not time-critical (internal, newsletters)
   - **Inactive** — no longer used, catch-all, aliases
3. For critical addresses: document who uses it, which mail client, which device
4. Contact relevant people at the practices for categorization input

**Output:** Table with all addresses + category + contact person + client info (for critical ones)

**Roles:**
- IT operator: compiles list, contacts practices, fills in table
- Project lead: provides template, reviews and prioritizes result

---

## Phase 2: Preparation (parallel to old provider)

**Goal:** Set everything up on Plesk without anyone noticing. Old mail keeps running.

**Steps:**

1. Create all mailboxes on Plesk (use bulk script if available)
2. Generate temporary passwords, store in secure shared document
3. Prepare DNS zone for the domain(s) on GoMedicus DNS provider — copy ALL records from old provider (A, AAAA, CNAME, MX, TXT, SRV), but **do not activate yet**
4. Send test emails directly to Plesk mailboxes (via hostname, bypassing DNS) — verify delivery
5. Prepare SPF, DKIM, DMARC records — critical to avoid spam classification after switchover
6. Document old provider's current DNS records as snapshot (rollback reference)

**Roles:**
- IT operator: mailbox creation, DNS zone prep, record documentation
- Project lead: DKIM/DMARC review, sign-off

---

## Phase 3: Pilot (infrastructure validation)

**Goal:** Validate that Plesk mail works correctly before touching DNS.

**Steps:**

1. Select 2-3 inactive/non-critical addresses from the discovery list
2. Test against Plesk directly (not via domain MX — that's still pointing to old provider):
   - IMAP login
   - SMTP send (verify DKIM signature)
   - Receive test mail (send directly to Plesk hostname)
3. Validate SPF/DKIM/DMARC with external tools (e.g. mail-tester.com)
4. Document results + any issues found
5. Fix issues before proceeding

**Note:** MX records are per-domain, not per-address. You cannot migrate individual addresses via DNS. The pilot tests infrastructure readiness, not the DNS cutover itself.

**Duration:** 2-3 days

---

## Phase 4: Cutover (the actual switch)

**Goal:** Switch MX records so all mail flows through Plesk.

**Timing:** Friday evening or Saturday morning — minimal mail traffic, maximum recovery time before Monday.

**Steps:**

1. **T-3 days:** Lower MX record TTL to 300 seconds (ensures fast propagation on switch day)
2. **T-1 day:** Notify critical users ("Email wird am Wochenende umgestellt, Montag bekommt ihr neue Zugangsdaten")
3. **T-0 (cutover):**
   - Switch MX records to Plesk mail server
   - Activate SPF/DKIM/DMARC records
   - Initiate registrar transfer (auth code)
4. **T+1h:** Send test emails from external accounts, verify delivery in Plesk
5. **T+2h:** Check Plesk logs for incoming mail flow
6. **T+24h:** Verify DNS propagation is complete globally

**Roles:**
- IT operator: TTL change, MX switch, registrar transfer, log monitoring
- Project lead: user communication, escalation point

**Rollback:** If critical issues arise, revert MX records to old provider (fast propagation due to low TTL). Old mailboxes still exist there.

---

## Phase 5: Client Setup (critical users)

**Goal:** Get critical users onto the new mail server.

**Steps:**

1. For each critical address: prepare personalized instructions with:
   - New IMAP/SMTP server (Plesk hostname)
   - New credentials
   - Port + encryption settings
   - Screenshots if needed
2. IT operator configures remotely or sends instructions (depending on user competence)
3. Verify each critical user can send + receive after reconfiguration
4. Non-critical/function addresses: server-side only, no client changes needed

**Duration:** 1-3 days depending on number of critical users

---

## Phase 6: Monitoring & Cleanup

**Goal:** Confirm everything works, then decommission old provider.

**Steps:**

1. Monitor for 1 week: bounce logs, spam reports, user feedback
2. Keep old provider mailboxes active for 2-4 weeks (safety net — catch any straggler mail that arrives there due to cached DNS)
3. After 2-4 weeks with no issues:
   - Cancel old provider mail/hosting package
   - Document completion
4. Archive this migration as reference for next acquisition

---

## Timeline Estimate

| Phase | Duration | Bottleneck |
|-------|----------|------------|
| 1 — Discovery | 1-2 weeks | Reaching people at practices |
| 2 — Preparation | 1-2 days work | - |
| 3 — Pilot | 2-3 days | - |
| 4 — Cutover | 1 weekend | Scheduling |
| 5 — Client Setup | 1-3 days | Number of critical users |
| 6 — Monitoring | 2-4 weeks | Observation period |

**Total: ~3-4 weeks from kickoff to old-provider cancellation.**

Phase 1 can run in parallel with other work (e.g. DD) since it's primarily IT operator work.

---

## Reuse for Future Acquisitions

This playbook is designed to be reusable. For the next acquisition:

1. Copy the Phase 1 template
2. Fill in: domain(s), source provider, number of addresses, operators
3. Execute phases in order
4. Update this playbook with lessons learned
