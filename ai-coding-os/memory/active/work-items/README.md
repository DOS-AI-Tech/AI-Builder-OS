# Work Items

This directory stores cross-tool workflow records.

Use one file per meaningful unit of work:

- one change request
- one bug
- one release review
- one deployment track
- one handoff-worthy implementation item

These files are the shared execution state across Claude, Codex, Copilot, Cursor, Qoder,
and future tools. They are not personal notes.

## Naming

Use:

`WI-YYYY-NNNN-short-slug.md`

Example:

`WI-2026-0001-export-change-request.md`

## Status model

- `intake`
- `analysis`
- `approval_waiting`
- `implementation`
- `verification`
- `blocked`
- `closed`

## Relationship to other memory

- `current-state.yaml` points to active work items
- `task-log/` records what happened in one session
- `DASHBOARD.md` summarizes the human-facing progress

Use `TEMPLATE.md` as the starting point.
