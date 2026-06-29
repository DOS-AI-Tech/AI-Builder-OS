# Workflow: Deployment

## Purpose

Create, update, or execute deployment instructions with auditable steps and pitfall capture.

## Trigger

- First deployment planning
- Deployment documentation update
- Human-approved release execution
- Deployment failure or recovery work

## Required reads

1. `.ai/memory/frozen/deployment.yaml`
2. Project deployment plan artifact if it exists
3. Relevant work-item file
4. Latest task logs involving deploy or release

## State transitions

`intake -> plan_review -> execution_ready -> pitfall_capture -> closed`

## Human gates

- Human confirms the exact command set before execution
- Human confirms rollback or recovery actions

## Required artifacts

- Deployment plan
- Deployment pitfall record when something goes wrong
- Updated release or work-item record

## Memory writes

- Update work-item or release status
- Add known issue if deployment uncertainty remains
- Record pitfall and task-log outcome

## Output templates

**Deployment plan** (first setup or if plan does not exist):
`.ai/templates/deployment-plan.md` → save as `.ai/deployment-plan.md` (single file, updated in place)
AI reads this file before every deployment. If it does not exist, AI creates it with the user before any commands are run.

**Deployment pitfall** (when something fails):
`.ai/templates/deployment-pitfall.md` → save as `.ai/pitfalls/YYYY-MM-DD-[summary]-pitfall.md`
AI fills this immediately when a failure occurs — not after recovery.
After filling: update the Known Pitfalls section of `.ai/deployment-plan.md`.

## Done criteria

- No deployment command is guessed
- Deployment instructions are documented in `.ai/deployment-plan.md`
- Any failure is recorded in `.ai/pitfalls/` so the next session does not rediscover it
