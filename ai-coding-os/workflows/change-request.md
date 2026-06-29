# Workflow: Change Request

## Purpose

Analyze an incoming change, get human approval, implement it, test it, and deliver it — in one end-to-end governed flow.

## Trigger

- Feature request on an existing project
- User feedback or client request
- Internal idea or scope change
- Auto-detected by Intake & Routing: `.ai/memory/task-log/` contains existing log files

## Required reads

1. `.ai/memory/frozen/architecture.yaml`
2. `.ai/memory/active/current-state.yaml`
3. Latest `.ai/memory/task-log/`
4. Relevant `read_first` files from `file-index.yaml`

## State transitions

```
analysis
  → impact_assessment
  → recommendation           [Gate 1: approve / backlog / reject / need more data]
  → implementation_plan      [Gate 2: confirm dev_plan before any code]
  → implementation
  → test_design              ← derived from impact_assessment
  → test_write
  → test_execute
  → test_fix                 [loop until tests pass]
  → delivery                 [Gate 3: human confirms delivery]
```

If the request is clearly a bug: route to `bug-fix` instead.
If the input is a customer conversation: pre-process with `customer-to-requirements.md` first.

## File write rule

**Displaying content in conversation is NOT saving it to disk.**
Before presenting any Gate checklist:
1. Invoke your file-write tool for each required document.
2. Wait for the tool to return success.
3. Report the exact path(s) saved: "I have saved `[path]`."
4. Only then display the Gate checklist.

If a file-write tool is unavailable or fails: stop, report the failure, and do not present the Gate.

## Human gates

- **Gate 1 — Decision**: AI saves `requirements.md` (classification, requirements, impact assessment, recommendation). Human decides: do now / backlog / reject / need more data. If not "do now", workflow ends here.
- **Gate 2 — Implementation plan**: AI saves `dev_plan.md` listing every file to modify, every behavior change, every uncertainty. If the change touches architecture, also saves `architecture.md`. Human confirms both before any code is written.
- **Gate 3 — Delivery**: AI saves `test_plan.md`, confirms all tests pass, and presents delivery summary. Human approves before closing.

## Phases

### Phase 1: Analysis → Impact Assessment → Recommendation

AI fills `.ai/templates/requirements.md` (all sections — change-request mode):

- **Section 1 — Context**: paste original input, classify it
- **Section 2 — Functional Requirements**: what the change must do
- **Section 3 — Acceptance Criteria**: specific, testable conditions
- **Section 4 — Impact Assessment**:
  - Affected user flows: which journeys change or break
  - Affected modules and files: what needs to touch
  - Data and API impact: schema changes, contract changes, permission changes
  - Regression risk: adjacent modules most likely to break — list each one explicitly
  - Architecture check: does this affect boundaries or ADRs in `frozen/architecture.yaml`?
- **Section 5 — Out of Scope**
- **Section 6 — AI Recommendation** with rationale

The impact assessment output (affected flows, regression risk areas) is the direct input to test design in Phase 4. AI must produce it in enough detail to drive test file generation.

**Required before Gate 1:**
Use your file-write tool to save `project_docs/YYYY-MM-DD-[slug]/requirements.md` (all sections filled).
After writing, confirm: "I have saved `project_docs/YYYY-MM-DD-[slug]/requirements.md`."
Do not display the Gate 1 checklist until the file-write tool has returned success.
Output → Gate 1. No implementation starts inside this phase.

### Phase 2: Implementation Plan

Only entered if Gate 1 decision is "do now".

AI fills `.ai/templates/dev_plan.md`:
- Every file to create or modify
- Every behavior change
- Every design decision that is uncertain (with a recommendation)

If the change affects architecture boundaries or ADRs: also fill `.ai/templates/architecture.md` to document what changes and why.

**Required before Gate 2:**
Use your file-write tool to save `project_docs/YYYY-MM-DD-[slug]/dev_plan.md`.
If architecture changes: also save `project_docs/YYYY-MM-DD-[slug]/architecture.md`.
After writing, confirm the exact path(s) saved.
Do not display the Gate 2 checklist until all file-write operations have returned success.
No code is written until Gate 2 is confirmed on the saved document(s).
If scope changes mid-implementation: stop, update `dev_plan.md`, request re-approval.

### Phase 3: Implementation

AI implements only what was approved in Gate 2.

### Phase 4: Testing

**Test design — derived from impact assessment**

AI fills `.ai/templates/test_plan.md` before writing any test code:
- Test strategy (which layers, which tools)
- Every test file path to be created or modified, mapped to acceptance criteria
- Coverage map tracing each acceptance criterion to a test file
- Regression scope: one test file per risk area identified in Phase 1
- Manual checklist for items that cannot be automated

**Required before writing test code:**
Use your file-write tool to save `project_docs/YYYY-MM-DD-[slug]/test_plan.md`.
After writing, confirm: "I have saved `project_docs/YYYY-MM-DD-[slug]/test_plan.md`."
Do not begin writing test code until the test plan file is saved.

No test case should exist that doesn't trace to at least one item in the impact assessment.
If a risk area was identified but cannot be tested automatically, it must appear in the manual checklist with a reason.

**Test write**

AI writes test code at the paths listed in `test_plan.md`:
- New or changed behavior tests
- Regression tests for each identified risk area
- Contract tests for any API or data schema change

**Test execute**

AI runs all tests and reports results against the coverage map.

**Test fix loop**

For each failing test:
1. Diagnose: implementation bug or test bug?
2. Fix the correct layer and state which, and why
3. Re-run
4. Repeat until all pass

Gate 3 requires all automated tests passing. Non-automatable items must appear in the manual checklist with a reason.

### Phase 5: Delivery

AI presents:
- Summary of what changed (matches Gate 2 scope)
- Test results mapped to acceptance criteria
- Manual test checklist for human
- Memory and dashboard updates

Human confirms delivery → closed.

## Document outputs

| Artifact | Template | Output path | Required before |
|----------|----------|-------------|-----------------|
| Requirements | `.ai/templates/requirements.md` | `project_docs/YYYY-MM-DD-[slug]/requirements.md` | Gate 1 |
| Development plan | `.ai/templates/dev_plan.md` | `project_docs/YYYY-MM-DD-[slug]/dev_plan.md` | Gate 2 |
| Architecture (conditional) | `.ai/templates/architecture.md` | `project_docs/YYYY-MM-DD-[slug]/architecture.md` | Gate 2 |
| Test plan | `.ai/templates/test_plan.md` | `project_docs/YYYY-MM-DD-[slug]/test_plan.md` | Gate 3 |
| Work-item | `.ai/memory/active/work-items/TEMPLATE.md` | `.ai/memory/active/work-items/[id]-[name].md` | — |
| Task log | `.ai/memory/task-log/TEMPLATE.md` | `.ai/memory/task-log/YYYY-MM-DD-[slug].md` | — |

`[slug]` = short description of the change, e.g. `add-auth`, `payment-refactor`.
Test files are written in the project's existing test directory structure as listed in `test_plan.md`.

## Memory writes

- Add or update work-item in `current-state.yaml`
- Update `pending_confirmations` if Gate 1 decision is deferred
- Update work-item stage at each gate
- Write task log at Gate 1 and delivery
- Update `DASHBOARD.md` at delivery

## Done criteria

- Classification and impact assessment are explicit
- Gate 1 decision is recorded
- If approved: all three gates were passed in order, each confirmed on a saved file
- No code was written before Gate 2
- No test code was written before `test_plan.md` was saved
- Every test case traces to an item in the impact assessment
- All automated tests pass
- Manual test checklist exists for non-automatable items
- Memory and dashboard are current
