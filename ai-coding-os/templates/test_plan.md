# Test Plan: [Feature / Product Name]

<!--
TRIGGER:    new-product (Phase 5) / change-request (Phase 4) / bug-fix (Phase 3)
SAVE AS:    project_docs/YYYY-MM-DD-[slug]/test_plan.md
UPDATED BY: AI drafts before writing test code; updated as tests are written

WORKFLOW GUIDE
  new-product:     Full plan — strategy + all test file paths + manual checklist
  change-request:  Focused on changed behavior + regression areas from impact assessment
  bug-fix:         Section 1 (brief) + Section 2 (regression test file only) + Section 4 (manual items if any)

FIELD GUIDE
  [AI]      AI generates
  [AI+USER] AI drafts, user confirms
-->

---

## 1. Test Strategy

<!-- [AI] Which layers are covered automatically and which require manual testing. State reasons. -->

| Layer | Approach | Tooling | Reason |
|-------|----------|---------|--------|
| Unit | | | |
| Integration | | | |
| End-to-end | | | |
| Manual | | | |

---

## 2. Automated Test Files

<!-- [AI] List every test file to be created or modified.
          Path must be the actual path in the project's test directory structure.
          Each row maps to one or more acceptance criteria from requirements.md. -->

| Test file path | What it covers | Acceptance criteria # |
|----------------|----------------|----------------------|
| | | |

---

## 3. Coverage Map

<!-- [AI] Every acceptance criterion from requirements.md must trace to at least one test file.
          Any gap must appear in "Untested" below with a stated reason. -->

| Criterion # | Test file | Notes |
|-------------|-----------|-------|
| | | |

**Untested criteria (manual only):**

| Criterion # | Reason not automated | Manual steps |
|-------------|---------------------|--------------|
| | | |

---

## 4. Manual Test Checklist

<!-- [AI+USER] Steps the human must execute after automated tests pass.
              Each item: exact action → expected result. -->

- [ ] 
- [ ] 

---

## 5. Regression Scope

<!-- [AI] change-request / bug-fix: list adjacent areas verified not broken.
          new-product: mark N/A. -->

| Area at risk | Test file or manual check | Result |
|--------------|--------------------------|--------|
| | | |

N/A (new-product, no regression scope): ☐
