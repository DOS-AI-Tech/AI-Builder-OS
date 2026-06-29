# Workflow: Bug Fix

## Purpose

Diagnose a defect, fix it, and verify the fix with a targeted test — in one end-to-end governed flow.

## Trigger

- Reported bug
- Regression
- Broken production or local behavior

## Required reads

1. `.ai/memory/frozen/architecture.yaml`
2. `.ai/memory/active/current-state.yaml`
3. Latest `.ai/memory/task-log/`
4. Relevant `read_first` files from `file-index.yaml`

## State transitions

```
intake
  → reproduction
  → reproduce_confirmed      [Gate 1: confirm bug is reproducible]
  → root_cause
  → fix_plan                 [Gate 2: confirm dev_plan before any code]
  → test_write               ← derived from root cause + reproduction analysis
  → implementation
  → fix_verified             [test now passes]
  → regression_check         [Gate 3: confirm no regressions]
  → closed
```

If the bug cannot be reproduced at Gate 1: enter `clarification`, do not proceed.

## File write rule

**Displaying content in conversation is NOT saving it to disk.**
Before presenting any Gate checklist:
1. Invoke your file-write tool for each required document.
2. Wait for the tool to return success.
3. Report the exact path(s) saved: "I have saved `[path]`."
4. Only then display the Gate checklist.

If a file-write tool is unavailable or fails: stop, report the failure, and do not present the Gate.

## Human gates

- **Gate 1 — Reproduce confirmed**: AI presents exact reproduction steps and confirms the bug is stable. Human verifies or corrects the steps before root cause analysis begins.
- **Gate 2 — Fix plan**: AI saves `dev_plan.md` (root cause + minimal fix — exact file, line, function). Human confirms before any code is written.
- **Gate 3 — Regression check**: AI saves `test_plan.md` (regression test file paths + manual items). AI presents regression scope and results. Human confirms before closing.

## Phases

### Phase 1: Reproduction

AI works to reproduce the bug using the user's description:
- Write down exact reproduction steps (numbered, repeatable)
- Confirm the bug appears consistently
- If not reproducible: state clearly and request more information → Gate 1 blocks

Output → Gate 1: reproduction steps + confirmation the bug is stable.

### Phase 2: Root Cause

After Gate 1 confirmed:
- Identify the exact module, file, and code path responsible
- State the root cause in one sentence
- Identify the regression risk areas: adjacent code that shares the same path or depends on the affected component
- Note if the cause is shallow (isolated) or systemic (risk of recurrence)

The root cause statement and regression risk areas are the direct input to test design in Phase 3.

### Phase 3: Fix Plan → Test Write

AI fills `.ai/templates/dev_plan.md` (bug-fix mode — minimal):
- Root cause (one sentence)
- Exact file(s), line range(s), and function(s) to change
- Behavior change: current vs corrected behavior
- Nothing beyond the minimal fix

**Required before Gate 2:**
Use your file-write tool to save `project_docs/YYYY-MM-DD-[slug]/dev_plan.md`.
After writing, confirm: "I have saved `project_docs/YYYY-MM-DD-[slug]/dev_plan.md`."
Do not display the Gate 2 checklist until the file-write tool has returned success.
No code is written until Gate 2 is confirmed on the saved document.

**Before writing the fix**, AI designs and writes the test using two inputs:

1. **From reproduction analysis (Gate 1)**: the test must exercise the exact steps that trigger the bug — same inputs, same sequence, same entry point
2. **From root cause (Phase 2)**: the test must assert at the layer where the root cause lives — not just the surface symptom, but the specific behavior of the identified code path

A test that only checks the symptom without targeting the root cause is insufficient.

**The test must fail before the fix is applied.** This confirms the test correctly catches the defect.

For each regression risk area identified in Phase 2: write one additional test or verify an existing test covers it.

### Phase 4: Implementation

AI applies the minimal fix approved in Gate 2.
Only the files listed in Gate 2 are changed.

### Phase 5: Fix Verified

AI runs the test written in Phase 3:
- Test passes → fix is confirmed at the root cause level
- Test still fails → root cause diagnosis was wrong, return to Phase 2

### Phase 6: Regression Check

AI checks each regression risk area identified in Phase 2:
- Run tests written for risk areas (Phase 3)
- Run any existing tests covering adjacent modules
- Manually inspect if no test exists for a risk area
- Any new issues found become separate work items — not part of this fix

AI fills `.ai/templates/test_plan.md` (bug-fix mode — minimal):
- Section 1: brief strategy (targeted regression only)
- Section 2: the regression test file path(s) created in Phase 3
- Section 4: manual items for risk areas that could not be tested automatically
- Section 5: regression scope and result per risk area

**Required before Gate 3:**
Use your file-write tool to save `project_docs/YYYY-MM-DD-[slug]/test_plan.md`.
After writing, confirm: "I have saved `project_docs/YYYY-MM-DD-[slug]/test_plan.md`."
Do not display the Gate 3 checklist until the file-write tool has returned success.

Output → Gate 3: regression scope + results per risk area.

### Phase 7: Close

AI presents:
- Fix summary (root cause → file changed → behavior corrected)
- Test that was failing before fix, now passing
- Regression check results per risk area
- Memory updates

**Memory update checklist (AI completes before closing):**
- [ ] `.ai/memory/active/current-state.yaml` — remove or update the resolved `known_issues` entry
- [ ] `.ai/memory/frozen/architecture.yaml` — does the fix change any key pattern or boundary? Update if yes
- [ ] `.ai/memory/frozen/deployment.yaml` — does the fix change any deployment step or SOP? Update if yes
- [ ] `.ai/memory/slow/file-index.yaml` — did any file paths or change areas shift? Update if yes
- [ ] Relevant work-item in `.ai/memory/active/work-items/` closed or updated
- [ ] Task log written to `.ai/memory/task-log/YYYY-MM-DD-[slug].md`

## Document outputs

| Artifact | Template | Output path | Required before |
|----------|----------|-------------|-----------------|
| Development plan | `.ai/templates/dev_plan.md` | `project_docs/YYYY-MM-DD-[slug]/dev_plan.md` | Gate 2 |
| Test plan | `.ai/templates/test_plan.md` | `project_docs/YYYY-MM-DD-[slug]/test_plan.md` | Gate 3 |
| Work-item | `.ai/memory/active/work-items/TEMPLATE.md` | `.ai/memory/active/work-items/[id]-[name].md` | — |
| Task log | `.ai/memory/task-log/TEMPLATE.md` | `.ai/memory/task-log/YYYY-MM-DD-[slug].md` | — |

`[slug]` = short description of the bug, e.g. `fix-login`, `fix-null-pointer`.
Test files are written in the project's existing test directory structure as listed in `test_plan.md`.

## Memory writes

- Track bug as work-item in `current-state.yaml`
- Update `known_issues` if root cause is systemic or likely to recur
- Write task log at Gate 2 and close
- Update `DASHBOARD.md`

## Done criteria

- Gate 1 confirmed reproduction before root cause analysis
- Gate 2 confirmed fix plan (saved `dev_plan.md`) before any code was written
- Test was written before the fix, targets the root cause code path, and failed before the fix
- Test passes after the fix
- `test_plan.md` saved before Gate 3
- Regression check covers all risk areas identified in Phase 2
- Any new issues found during regression are logged as separate work items
