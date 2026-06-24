# Deployment Plan: [Project Name]

<!--
TRIGGER:    deployment workflow (first setup or when plan does not yet exist)
SAVE AS:    .ai/deployment-plan.md   ← single file, updated in place
UPDATED BY: AI proposes changes; human must confirm before any section is modified

This is the authoritative source for all deployment instructions.
AI reads this file before every deployment. AI does not guess — if instructions
are missing or unclear, AI asks before proceeding.

FIELD GUIDE
  [AI]       AI generates from available context
  [USER]     AI asks user, waits for answer
  [AI+USER]  AI drafts, user confirms or edits
  [GATE]     Human decision required — AI does not advance until confirmed
-->

---

## 1. Deployment Target

<!-- [AI+USER] -->

**Environment:** local demo / staging / production
**Hosting:** 
**Access:** <!-- who can deploy, how they authenticate -->

---

## 2. Service Composition

<!-- [AI+USER] List every service this project runs. -->

| Service | Technology | Port | Required |
|---------|-----------|------|----------|
| | | | yes / no |

---

## 3. Environment Variables

<!-- [USER] List every required env var. Do NOT write actual values here. -->

| Variable | Purpose | Example format | Required |
|----------|---------|---------------|----------|
| | | | yes / no |

**Where to get values:** 

---

## 4. Prerequisites

<!-- [AI+USER] What must be true before deployment can start? -->

- [ ] 
- [ ] 

---

<!-- [GATE] Plan Confirmation Gate — human confirms this plan before any deployment proceeds -->

**⬛ GATE — Deployment Plan Confirmed**
- [ ] Service composition is correct
- [ ] All env vars listed
- [ ] Prerequisites are clear
- [ ] Plan is the authoritative source — AI will not deviate from it

---

## 5. Deployment Steps

<!-- [AI+USER] Exact commands in exact order. AI copies from here — does not improvise. -->

```bash
# Step 1 — [description]


# Step 2 — [description]


# Step 3 — [description]

```

---

## 6. Post-Deployment Verification

<!-- [AI+USER] How do we confirm the deployment succeeded? -->

- [ ] 
- [ ] 

---

## 7. Rollback Procedure

<!-- [AI+USER] Exact steps to undo this deployment if something goes wrong. -->

```bash

```

---

## 8. Known Deployment Pitfalls

<!-- [AI] Updated in place when deployment-pitfall.md files are created. -->

| Date | Issue | Fix |
|------|-------|-----|
| | | See: .ai/pitfalls/[filename] |

---

## Revision History

| Date | Changed by | What changed |
|------|-----------|-------------|
| | AI / Human | |
