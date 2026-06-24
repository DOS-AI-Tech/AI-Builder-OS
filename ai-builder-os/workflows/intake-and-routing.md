# Workflow: Intake and Routing

## Purpose

Classify every incoming request into exactly one of the three main workflows before any implementation or analysis proceeds.

## Trigger

- Any new task request
- Any resumed session where the next action is unclear
- Any ambiguous prompt that could map to more than one workflow

## Required reads

1. `.ai/memory/frozen/architecture.yaml`
2. `.ai/memory/frozen/deployment.yaml`
3. `.ai/memory/active/current-state.yaml`
4. Latest `.ai/memory/task-log/`
5. `.ai/memory/slow/file-index.yaml`

## State transitions

`intake -> auto_detect -> classification -> scoped -> handed_off`

If classification is ambiguous:

`intake -> auto_detect -> clarification -> classification`

## Auto-detection: New Product vs Change Request

Before asking the user, AI scans the filesystem to infer project phase:

**Step 1 — Scan `.ai/memory/task-log/`**
- Directory is empty or contains only `TEMPLATE.md` → **new project** → route to `new-product`
- Directory contains at least one real log file → **running project** → route to `change-request`

**Step 2 — User input overrides auto-detection**
- User says "new product" / "新产品" / "start from scratch" → force `new-product`
- User says "change" / "变更" / "add feature" / "modify" → force `change-request`
- User says "bug" / "broken" / "not working" / "regression" → force `bug-fix`

**Step 3 — Conflict handling**
- Task-log has entries but user says "new product":
  AI confirms: "Existing project logs detected. Treat this as a new product anyway?"
- Task-log is empty but user says "add a feature":
  Route to `change-request`, and note: "No project log found — run Bootstrap first if memory is not initialized."

**Step 4 — Bootstrap check**
If `.ai/memory/active/current-state.yaml` is missing or in template state, trigger `bootstrap` before any other routing.

## Human gates

- Confirm classification when the task could be interpreted as both change request and implementation
- Confirm priority when the task conflicts with current iteration scope

## Required artifacts

- New or updated work-item file if the task will continue beyond one message
- Explicit workflow label in the response

## Memory writes

- Add or update `work_items` entry in `current-state.yaml` when the item is non-trivial
- Update `pending_confirmations` when classification or priority needs human input

## Routing table

| Input type | Route to |
|-----------|----------|
| New project (no task logs) | `new-product` |
| New idea / product brief | `new-product` |
| Feature request / scope change on existing project | `change-request` |
| Bug / regression / broken behavior | `bug-fix` |
| Memory not initialized | `bootstrap` |
| Session handoff / resume | `handoff` |

## Done criteria

- Exactly one workflow is selected
- Auto-detection result is stated or overridden by user
- Bootstrap is confirmed complete before routing to a main workflow
- Next required human gate is stated clearly
