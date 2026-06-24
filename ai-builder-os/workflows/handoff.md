# Workflow: Handoff

## Purpose

Transfer work safely across sessions, people, IDEs, or AI agents without losing state.

## Trigger

- End of any meaningful task
- Switching from one AI tool to another
- Handing off from product analysis to code execution
- Pausing work with unresolved blockers

## Required reads

1. Active work-item file
2. `.ai/memory/active/current-state.yaml`
3. Latest task log
4. `DASHBOARD.md`

## State transitions

`active -> summary -> write_back -> next_step_ready`

## Human gates

- Human confirms next owner when the handoff changes responsibility

## Required artifacts

- Updated work-item file
- New task log
- Updated dashboard

## Memory writes

- `current-state.yaml`
- `work-items/*.md`
- `task-log/*.md`
- `DASHBOARD.md`

## Done criteria

- Another agent can resume without re-explaining the work
- Current status, blockers, next step, and required human decisions are explicit
