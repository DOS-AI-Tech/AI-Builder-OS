# Customer to Requirements: [Client / Date]

<!--
TRIGGER:    new-product or change-request workflow when input is a customer conversation
SAVE AS:    .ai/customers/YYYY-MM-DD-[client]-requirements.md
UPDATED BY: AI fills; human reviews and signs off before routing to planning

FIELD GUIDE
  [AI]       AI generates from available context
  [USER]     AI asks user, waits for answer
  [AI+USER]  AI drafts, user confirms or edits
  [GATE]     Human decision required — AI does not advance until confirmed
-->

---

## 1. Raw Input

<!-- [USER] Paste the original material: meeting notes, email, call transcript, chat log. No editing needed. -->


**Source:** <!-- meeting / email / call / chat / other -->
**Date:** 
**Participants:** 

---

## 2. What the Client Said They Want

<!-- [AI] Extract the explicit requests, feature ideas, and complaints, word for word or paraphrased. -->

- 
- 

---

## 3. What the Client Actually Needs

<!-- [AI+USER] Behind the stated wants — the underlying problem or goal.
     AI distinguishes "stated want" from "underlying need". User corrects if wrong. -->

| Stated want | Underlying need |
|-------------|----------------|
| | |

---

## 4. Hard Constraints

<!-- [AI+USER] Non-negotiable requirements: deadline, budget, technical limits, compliance. -->

- 

---

## 5. Ambiguities and Open Questions

<!-- [AI] Things that are unclear or missing. User must answer or confirm before routing to planning. -->

| # | Ambiguity / Question | Needs answer from | Status |
|---|---------------------|------------------|--------|
| 1 | | Client / Internal | ☐ |
| 2 | | Client / Internal | ☐ |

---

<!-- [GATE] Clarity Gate — AI routes to planning only after ambiguities are resolved -->

**⬛ GATE — Requirements Confirmed**
- [ ] Wants vs. needs distinction reviewed
- [ ] Hard constraints confirmed
- [ ] Open questions answered or explicitly deferred

---

## 6. Requirement Entries

<!-- [AI] After Gate: AI converts the above into structured requirement entries ready for planning. -->

| # | Requirement | Type | Priority signal | Source |
|---|-------------|------|----------------|--------|
| 1 | | feature / constraint / fix | must / should / could | |
| 2 | | | | |

---

## 7. Routing Decision

<!-- [AI+USER] Where do these requirements go next? -->

- [ ] New product → `new-product` workflow
- [ ] New feature on existing product → `change-request` workflow
- [ ] Bug → `bug-fix` workflow
- [ ] Backlog only — no immediate action

**Notes:** 
