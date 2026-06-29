# Technical Architecture: [Product Name]

<!--
TRIGGER:    new-product workflow (Phase 2.5) / change-request (Phase 2, when architecture is affected)
SAVE AS:    project_docs/YYYY-MM-DD-[slug]/architecture.md
UPDATED BY: AI drafts after Gate 2; human confirms before implementation plan begins

FIELD GUIDE
  [AI]       AI generates from available context — no user input needed
  [USER]     AI asks user, waits for answer before continuing
  [AI+USER]  AI drafts, user confirms or edits
  [GATE]     Human decision required — AI does not advance until confirmed
-->

---

## 1. Tech Stack Decision

<!-- [AI+USER] AI proposes stack based on MVP scope and constraints. User confirms or redirects. -->

| Layer | Choice | Rationale |
|-------|--------|-----------|
| Frontend | | |
| Backend | | |
| Database | | |
| Hosting / Infra | | |
| Key libraries | | |

**Alternatives considered:**

| Option | Rejected because |
|--------|-----------------|
| | |

---

## 2. System Components

<!-- [AI] High-level breakdown of what gets built and how pieces connect. -->

| Component | Responsibility | Depends on |
|-----------|---------------|------------|
| | | |

**Component diagram (text):**

```
[Component A] → [Component B]
                ↓
            [Component C]
```

---

## 3. Data Model

<!-- [AI+USER] Key entities and their relationships. Not full schema — just enough to expose design choices. -->

| Entity | Key fields | Notes |
|--------|-----------|-------|
| | | |

**Relationships:**

---

## 4. API Contracts

<!-- [AI] Only fill if there are external or inter-component API boundaries. Mark "N/A" if pure frontend. -->

| Endpoint / Interface | Method | Input | Output | Notes |
|---------------------|--------|-------|--------|-------|
| | | | | |

N/A: ☐

---

## 5. System Boundaries

<!-- [AI] What must not import what. What this system must never do directly. -->

| Rule | Reason |
|------|--------|
| | |

---

## 6. Architecture Decision Records (ADRs)

<!-- [AI] One row per non-obvious decision. Captures why, not what. -->

| # | Decision | Why this, not alternatives | Consequences |
|---|----------|--------------------------|--------------|
| 1 | | | |
| 2 | | | |

---

## 7. Risks and Assumptions

<!-- [AI] What must be true for this architecture to hold. What could cause rework. -->

| Risk / Assumption | Impact if wrong | Mitigation |
|------------------|-----------------|------------|
| | | |

---

<!-- [GATE] Technical Architecture Gate — AI does not begin implementation plan until user confirms -->

**⬛ GATE 2.5 — Technical Architecture**
- [ ] Tech stack confirmed
- [ ] System components agreed
- [ ] Data model agreed
- [ ] API boundaries confirmed (or marked N/A)
- [ ] System boundaries agreed
- [ ] ADRs reviewed
- [ ] No blocking risks
