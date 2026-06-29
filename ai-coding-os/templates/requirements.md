# Requirements: [Feature / Product Name]

<!--
TRIGGER:    new-product (Phase 2) / change-request (Phase 1)
SAVE AS:    project_docs/YYYY-MM-DD-[slug]/requirements.md
UPDATED BY: AI drafts; human confirms at Gate

WORKFLOW GUIDE
  new-product:     Fill Sections 1, 2, 3, 5. Skip Sections 4 and 6.
  change-request:  Fill all six sections.

FIELD GUIDE
  [AI]       AI generates from available context
  [USER]     AI asks user, waits for answer
  [AI+USER]  AI drafts, user confirms or edits
  [GATE]     Human decision required — AI does not advance until confirmed
-->

---

## 1. Context

<!-- [USER/AI]
     new-product:     what problem this solves and who it's for (1–3 sentences).
     change-request:  paste the original request exactly; state source and date. -->

**Input:**

**Source:** <!-- new-product: N/A | change-request: client / internal / user report / market observation -->

**Classification:** <!-- new-product: N/A | change-request: bug / UX issue / feature / performance / business requirement / edge case -->

---

## 2. Functional Requirements

<!-- [AI+USER] Every capability the product or change must provide.
              Each item must map to at least one acceptance criterion in Section 3. -->

| # | Requirement | Priority |
|---|-------------|----------|
| 1 | | must / should / nice-to-have |

---

## 3. Acceptance Criteria

<!-- [AI+USER] Specific, testable conditions. Done when ALL are checked.
              Reference requirement numbers from Section 2. -->

| # | Criterion | Req # |
|---|-----------|-------|
| 1 | | |

---

## 4. Impact Assessment  <!-- change-request only — omit for new-product -->

<!-- [AI] -->

**Affected user flows:**
-

**Affected modules / files:**
-

**Data / API impact:** <!-- schema change? breaking change? migration needed? -->

**Regression risk:** low / medium / high — [reason]

**Architecture impact:** <!-- does this touch system boundaries or ADRs in frozen/architecture.yaml? -->

---

## 5. Out of Scope

<!-- [AI+USER] Explicitly name what is NOT included. Prevents scope creep. -->

-

---

## 6. AI Recommendation  <!-- change-request only — omit for new-product -->

<!-- [AI] -->

- [ ] **Do now** — [reason]
- [ ] **Backlog** — [reason]
- [ ] **Reject** — [reason]
- [ ] **Need more data** — [what is missing]

---

<!-- [GATE] -->

**⬛ GATE — Requirements Confirmed**

*new-product (Gate 2):*
- [ ] Functional requirements confirmed
- [ ] Acceptance criteria agreed
- [ ] Out of scope agreed

*change-request (Gate 1):*
- [ ] Classification confirmed
- [ ] Impact assessment reviewed
- [ ] Out of scope agreed
- [ ] Decision recorded: Do now / Backlog / Reject / Need more data
