# Development Plan: [Feature / Product Name]

<!--
TRIGGER:    new-product (Phase 3) / change-request (Phase 2) / bug-fix (Gate 2)
SAVE AS:    project_docs/YYYY-MM-DD-[slug]/dev_plan.md
UPDATED BY: AI drafts at intake; human confirms before implementation begins

WORKFLOW GUIDE
  new-product:     Full plan — all files to create, all behavior changes, all uncertainties
  change-request:  Files to modify + behavior changes + uncertainties
  bug-fix:         Minimal — exact file(s), line(s), and function(s) to change; nothing more

FIELD GUIDE
  [AI]       AI generates from available context — no user input needed
  [USER]     AI asks user, waits for answer
  [AI+USER]  AI drafts, user confirms or edits
  [GATE]     Human decision required — AI does not advance until confirmed
-->

---

## 1. Request

<!-- [USER] Paste the original request exactly as received. -->


---

## 2. Feature / Fix Definition

<!-- [AI+USER] What this delivers in one sentence. -->


---

## 3. User Flow

<!-- [AI+USER] Step-by-step: who does what, and what happens. Omit for bug-fix. -->

1. 
2. 
3. 

---

## 4. Files to Change

<!-- [AI] AI lists every file it expects to create or modify. User confirms before any edits.
          bug-fix: include the exact line range and function name. -->

| File | Change type | Reason |
|------|-------------|--------|
| | create / modify / delete | |

---

## 5. Behavior Changes

<!-- [AI] Any change to API response, database schema, permissions, config defaults, or user-visible behavior. -->

| Area | Current behavior | New behavior |
|------|-----------------|--------------|
| | | |

None: ☐

---

## 6. Uncertain Design Decisions

<!-- [AI] List anything where AI is not certain — options and recommendation. Omit for bug-fix. -->

| Decision | Options | AI recommends |
|----------|---------|---------------|
| | | |

None: ☐

---

<!-- [GATE] Plan Gate — AI does not write any code until user confirms this section -->

**⬛ GATE — Development Plan Confirmed**

*new-product (Gate 3) / change-request (Gate 2):*
- [ ] File list confirmed
- [ ] Behavior changes confirmed
- [ ] Design decisions resolved
- [ ] Ready to implement

*bug-fix (Gate 2):*
- [ ] Root cause confirmed
- [ ] Exact file / line / function confirmed
- [ ] Minimal fix agreed — no extra changes
- [ ] Ready to implement
