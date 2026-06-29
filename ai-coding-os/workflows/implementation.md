# Phase Spec: Implementation

> **This is a phase spec, not a standalone workflow.**
> It is used internally by `new-product` and `change-request` as their implementation phase.
> Do not route here directly from Intake & Routing.

## Purpose

Execute an approved task within explicit scope, validation, and write-back boundaries.

## Entered from

- `new-product` at Gate 3 (implementation plan approved)
- `change-request` at Gate 2 (implementation plan approved)

## Required inputs (must exist before entering)

- Approved plan in the session (list of files, behavior changes, uncertainties resolved)
- Active work-item file

## Execution rules

- Implement only what was listed in the approved plan
- If a new file or behavior change appears mid-implementation: stop, update the plan, request re-approval
- No test code is written in this phase — testing follows in the next phase

## State

`implementation` is a single state. On completion, the parent workflow advances to `test_design`.

## Memory writes

- Update work-item stage to `implementation`
- No task log write here — the parent workflow owns the log

## Done criteria

- Only planned files were changed, or the plan was re-approved for any additions
- Parent workflow advances to test phase
