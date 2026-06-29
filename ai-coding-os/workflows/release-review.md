# Phase Spec: Release Review

> **This is a phase spec, not a standalone workflow.**
> It is used internally by `new-product` and `change-request` as part of their delivery phase.
> It can also be triggered independently for hotfixes or milestone releases.

## Purpose

Prepare a version, iteration, or hotfix for human release decision with explicit scope, risks, manual checks, and notes.

## Entered from

- `new-product` delivery phase (Gate 4)
- `change-request` delivery phase (Gate 3)
- Directly, for a hotfix or milestone release that spans multiple work items

## Required reads

1. `.ai/memory/frozen/deployment.yaml`
2. `.ai/memory/active/current-state.yaml`
3. Recent task logs and relevant work items

## State transitions

`readiness_check -> scope_summary -> acceptance_preparation -> release_decision_waiting -> post_release_recording`

## Human gates

- Human confirms release scope
- Human runs manual acceptance tasks
- Human makes the release decision

## Required artifacts

- Release review document: `.ai/templates/release-review.md` → `.ai/releases/[version]-release-review.md`
- Release notes draft
- Manual test checklist
- Updated dashboard summary

AI fills Sections 1–5 before presenting the release decision gate.
Human runs acceptance tests (Section 5) and records results.
After human decision: AI completes Section 6 (post-release recording).

## Release checklist

AI runs through this checklist before presenting the release decision gate. All items must pass.

### Pre-release

**Code quality**
- [ ] All planned bug fixes / features are complete
- [ ] Regression check passed (see `bug-fix.md` Phase 7 memory update checklist)
- [ ] Full test suite passes
- [ ] No outstanding TODOs that affect this version's functionality

**Documentation**
- [ ] `.ai/memory/active/current-state.yaml` updated (new issues added, resolved issues removed)
- [ ] Release notes draft complete

**Context layer**
- [ ] `.ai/memory/frozen/architecture.yaml` updated if architecture changed
- [ ] `.ai/memory/frozen/deployment.yaml` updated if deployment SOP changed
- [ ] `.ai/memory/slow/file-index.yaml` updated if file paths changed
- [ ] All relevant `.ai/memory/active/work-items/` are in a releasable state

### Release operations

- [ ] `git status` — working tree is clean, no uncommitted changes
- [ ] `git log --oneline -5` — commit content matches expectations
- [ ] Execute release per `commit_and_push_sop` in `.ai/memory/frozen/deployment.yaml`

### Post-release

- [ ] Production version is accessible
- [ ] Core flows verified manually in production
- [ ] Monitoring / logs show no anomalies (if monitoring exists)
- [ ] Relevant stakeholders notified
- [ ] `.ai/releases/[version]-release-review.md` Section 6 completed (post-release recording)

## Memory writes

- Update work-item or release status
- Update `current-state.yaml`
- Add release summary to `DASHBOARD.md`
- Write task log

## Done criteria

- Release review template is filled through Section 6
- Human release decision is explicit and recorded
- Post-release memory updates are complete
