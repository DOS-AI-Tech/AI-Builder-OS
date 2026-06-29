# AI Orientation — [PROJECT NAME]

<!-- Replace [PROJECT NAME] with your project name. -->
<!-- Add one sentence describing what this project does. -->

This project uses AI Coding Operating System as a company-level AI delivery layer.
The workflow system is tool-agnostic. Claude Code, Codex, Copilot, Cursor, and
future AI IDEs all share the same memory files, work-item records, and stage gates.

Do not scan the whole repository. Follow the read order and workflow routing below.

---

## Read order — every task, no exceptions

| Step | File | Purpose |
|------|------|---------|
| 1 | `.ai/memory/frozen/architecture.yaml` | Architecture, components, system boundaries, key patterns, ADRs |
| 2 | `.ai/memory/frozen/deployment.yaml` | Deployment config, commit SOP, operations |
| 3 | `.ai/memory/active/current-state.yaml` | Current iteration, in-progress work, work-items, pending confirmations |
| 4 | Most recent file in `.ai/memory/task-log/` | What happened last session |
| 5 | `.ai/memory/slow/file-index.yaml` | Find the entry matching your task area |
| 6 | Files listed under `read_first` for your area | Actual code or product files to read |

Stop at step 6. Do not read beyond the listed files unless the task explicitly crosses system boundaries.

---

## Workflow router

Every task must be classified before implementation. Choose exactly one workflow:

| Workflow | Trigger |
|----------|---------|
| `bootstrap` | Memory is missing or still template state |
| `new_product` | Raw business idea, new initiative, new customer brief |
| `change_request` | Feedback, new requirement, scope question, reprioritization |
| `bug_fix` | Defect, regression, incident, broken behavior |
| `implementation` | Approved task that is ready for code or content changes |
| `release_review` | Preparing to ship a version, iteration, MVP, or hotfix |
| `deployment` | Creating or updating deployment instructions, release execution, pitfall capture |
| `handoff` | Ending a session, switching agents, or transferring work across tools |

If the task is ambiguous, stop in `clarification` state and ask for enough detail to route it.

After routing, read `.ai/workflows/<workflow>.md` and execute that workflow's contract.

---

## Task workflow

```text
1. Orient   — read frozen/ + active/ + last task-log
2. Route    — classify the task into one workflow
3. Scope    — find the matching change area in slow/file-index.yaml
4. Inspect  — read only the listed files
5. Gate     — present plan or analysis required by the workflow
6. Execute  — implement only after the workflow's human gate is cleared
7. Validate — run the validate commands from file-index.yaml plus workflow checks
8. Close    — update current-state.yaml + work-items/ + task-log + DASHBOARD.md
```

---

## Shared state model

| File | Role |
|------|------|
| `.ai/memory/frozen/*.yaml` | Human-owned source of truth for architecture and operations |
| `.ai/memory/slow/file-index.yaml` | Human-reviewed routing map for which files matter per change area |
| `.ai/memory/active/current-state.yaml` | AI-readable live project state across all tools |
| `.ai/memory/active/work-items/` | Cross-tool task records with explicit workflow state |
| `.ai/memory/task-log/` | Append-only handoff history |
| `DASHBOARD.md` | Human-readable delivery control panel |

The goal is not “each IDE has rules.” The goal is “all AI tools operate on one shared execution system.”

---

## Human gates — REQUIRED

Before changing code, content, config, or release scope, present the human gate required by the active workflow.

Every gate must include:
1. Files to change or create
2. Behavior changes or scope impact
3. Open decisions and recommendation
4. Required artifacts
5. Validation plan

Do not proceed until the human confirms or adjusts the gate.

---

## Close-out — REQUIRED after every task

### Update shared memory
Edit `.ai/memory/active/current-state.yaml`:
- Set `updated_at` to today's date
- Update `in_progress`, `work_items`, `pending_confirmations`, and `known_issues`
- Move completed items to `recently_completed`
- Update `last_session.date`, `last_session.task_log`, and `last_session.summary`

### Update or create work-item file
Create or update the relevant file in `.ai/memory/active/work-items/`.
The work item is the cross-tool state record for the task.

### Write task log
Create `.ai/memory/task-log/YYYY-MM-DD-slug.md`.
Use `.ai/memory/task-log/TEMPLATE.md` as the format.

### Update dashboard
Sync `DASHBOARD.md` with the latest stage, pending gates, risks, and next actions.

---

## Memory file update rules

| File | Who updates | When |
|------|-------------|------|
| `frozen/architecture.yaml` | Human (AI may propose) | Architecture or boundary decision changes |
| `frozen/deployment.yaml` | Human (AI may propose) | Deployment or ops procedure changes |
| `slow/file-index.yaml` | Human (AI may propose) | Milestone completion or file ownership shift |
| `active/current-state.yaml` | AI (mandatory) | End of every task |
| `active/work-items/*.md` | AI (mandatory when a workflow item exists) | Each stage transition |
| `task-log/YYYY-MM-DD-slug.md` | AI (mandatory) | End of every task |

AI surfaces observations about frozen/ and slow/ in one sentence. Human decides whether and when to update them.

---

## System boundaries

<!-- List which modules/packages must not import from each other. -->
<!-- Also list secrets, deployment, or repo-boundary constraints the AI must never cross. -->
