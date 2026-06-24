# Release Review: [Version]

<!--
TRIGGER:    release-review workflow
SAVE AS:    .ai/releases/[version]-release-review.md
UPDATED BY: AI fills pre-release sections; human runs acceptance; AI records outcome

FIELD GUIDE
  [AI]       AI generates from available context
  [USER]     AI asks user, waits for answer
  [AI+USER]  AI drafts, user confirms or edits
  [GATE]     Human decision required — AI does not advance until confirmed
-->

---

## 1. Release Scope

<!-- [AI] AI summarizes what is in this release based on task logs, work items, and current-state.yaml. -->

**Version:** 
**Iteration / milestone:** 

### What changed (user-visible)

- 

### What was fixed

- 

### What is NOT in this release

- 

---

## 2. Pre-Release Checklist

<!-- [AI] AI checks each item based on project state. -->

| Item | Status | Notes |
|------|--------|-------|
| All in-scope work completed | ☐ | |
| No open Plan Gates left unresolved | ☐ | |
| Regression checklist reviewed | ☐ | |
| Deployment plan is current | ☐ | |
| Known issues documented | ☐ | |

---

## 3. Known Issues at Release

<!-- [AI] Anything known to be broken or incomplete that is shipping anyway. -->

| Issue | Severity | Decision | Next action |
|-------|----------|----------|-------------|
| | low / medium / high | ship / defer fix | |

None: ☐

---

## 4. Release Notes

<!-- [AI] Two versions: internal (technical detail) and external (user-facing language). -->

### Internal

**What changed:**
- 

**Technical notes:**
- 

### External (customer-facing)

**What's new:**
- 

**What's fixed:**
- 

**Known limitations:**
- 

---

## 5. Acceptance Test Cases

<!-- [AI] Generated from in-scope features and acceptance criteria. Human runs these. -->

| # | Test | Steps | Expected result | Pass / Fail |
|---|------|-------|----------------|-------------|
| 1 | | | | |
| 2 | | | | |

---

<!-- [GATE] Release Decision Gate — human runs acceptance tests, then decides -->

**⬛ GATE — Release Decision**

Acceptance test results: [pass / fail / partial]
Issues found during testing: 

Decision:
- [ ] **Ship** — all tests passed, known issues acceptable
- [ ] **Fix first** — [specify what must be fixed]
- [ ] **Hold** — [reason]
- [ ] **Roll back** — [reason]

**Decision by:** 
**Date:** 

---

## 6. Post-Release Recording

<!-- [AI] Filled after human confirms release outcome. -->

**Release result:** succeeded / failed / rolled back
**Time:** 
**Issues discovered post-release:** 

Memory updates completed:
- [ ] `current-state.yaml` updated
- [ ] `DASHBOARD.md` updated
- [ ] Task log written
