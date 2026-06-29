# Workflow: Bootstrap

## Purpose

Initialize or repair project memory so every future AI session starts from a shared, file-based context instead of chat history.

## Trigger

- User says `bootstrap memory`, `初始化项目记忆`, or equivalent
- Any required memory file is missing
- Memory files are still in template or placeholder state

## Required reads

1. `README.md`
2. Package manifest or runtime manifest (`package.json`, `go.mod`, `requirements.txt`, `Cargo.toml`, etc.)
3. Top-level directory structure
4. Main entry points
5. CI/deploy config if present

## State transitions

`intake -> scan -> bootstrap_write -> review_waiting -> closed`

## Human gates

- Human verifies `architecture.yaml`
- Human verifies `deployment.yaml`
- Human confirms any fields the AI could not determine

## Required artifacts

- `.ai/memory/frozen/architecture.yaml`
- `.ai/memory/frozen/deployment.yaml`
- `.ai/memory/slow/file-index.yaml`
- `.ai/memory/active/current-state.yaml`

## Steps

1. Scan: README, package manifest, top-level dirs, entry points, CI config.
2. Fill `frozen/architecture.yaml`: stack, components, boundaries, key patterns, ADRs.
3. Fill `frozen/deployment.yaml`: environments, run/deploy steps, env vars, commit convention.
4. Fill `slow/file-index.yaml`: 4–8 functional areas → `read_first` file lists.
5. Fill `active/current-state.yaml`: today's date, any in-progress work from git status.
6. Leave `active/work-items/README.md` and `TEMPLATE.md` in place.
7. **Write task log**: Create `.ai/memory/task-log/YYYY-MM-DD-bootstrap.md` summarising what was discovered (stack, components, key files, any gaps). **This step is mandatory.** The workflow router uses the presence of a real task-log entry to route an existing project to `change-request` instead of `new-product`. Skipping this step causes misrouting.
8. Report gaps to the human and ask: "Memory bootstrap complete. What's the first task?"

## Memory writes

- Create or refresh the four required memory files
- Write `task-log/YYYY-MM-DD-bootstrap.md` (required — see Step 7)
- Update `DASHBOARD.md`

## Done criteria

- All four memory layers exist and are not in template state
- A real task-log entry exists for this bootstrap session
- Gaps are surfaced for human review
- The session ends by asking for the first real task
