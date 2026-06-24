# AI Builder OS Workflow Layer

These files define the company-level workflow system installed into every governed project.
They are the source of truth for how work moves across:

- Claude Code
- OpenAI Codex
- GitHub Copilot
- Cursor
- Qoder
- Future AI IDEs or agents

Tool rule files are adapters. These workflow files are the runtime model.

## Standard workflow contract

Every workflow file must define:

1. Purpose
2. Trigger
3. Required reads
4. State transitions
5. Human gates
6. Required artifacts
7. Memory writes
8. Done criteria

## Workflow types

### Entry point

- `intake-and-routing.md` — Classifies every request and routes to one of the three main workflows. Includes auto-detection of new project vs running project.

### Main workflows (end-to-end, user-facing)

These are the three flows a user actually experiences. Each covers the full journey from intake to delivery, including testing.

| Workflow | Trigger | Testing depth |
|----------|---------|--------------|
| `new-product.md` | New project, no existing task logs | Full — unit, integration, E2E |
| `change-request.md` | Feature request or change on existing project | Medium — changed behavior + regression |
| `bug-fix.md` | Bug, regression, broken behavior | Focused — reproduce → fix → verify |

### Phase specs (internal, not directly routed)

These are invoked as phases within the main workflows, not as standalone routes.

- `implementation.md` — Execution phase used by new-product and change-request
- `release-review.md` — Delivery phase used by new-product and change-request; also usable standalone for milestone releases

### Utility workflows (system-level, always available)

- `bootstrap.md` — Initialize or repair project memory
- `handoff.md` — Transfer work safely across sessions, tools, or people
- `deployment.md` — Create, update, or execute deployment instructions

## Document output directory structure

Every workflow writes artifacts to a standard directory tree under `.ai/`:

```
.ai/
├── products/          ← new-product: product plan documents
│   └── [name]-product-plan.md
├── features/          ← new-product + change-request: implementation scope docs
│   └── [name]-scope.md
├── changes/           ← change-request: impact analysis documents
│   └── YYYY-MM-DD-[summary]-change-analysis.md
├── bugs/              ← bug-fix: defect reports
│   └── YYYY-MM-DD-[id]-bug-report.md
├── releases/          ← release-review: release review documents
│   └── [version]-release-review.md
├── pitfalls/          ← deployment: failure records
│   └── YYYY-MM-DD-[summary]-pitfall.md
├── templates/         ← source templates (read-only, do not write here)
└── memory/            ← framework memory files (existing)
    ├── frozen/
    ├── slow/
    ├── active/
    │   ├── current-state.yaml
    │   └── work-items/
    │       └── [id]-[name].md
    └── task-log/
        └── YYYY-MM-DD-[slug].md
```

Test files are always written in the project's own test directory structure. They are never placed under `.ai/`.

## Shared state

- `.ai/memory/active/current-state.yaml` stores project-wide live status
- `.ai/memory/active/work-items/` stores one file per workflow item
- `.ai/memory/task-log/` stores append-only session history
- `DASHBOARD.md` stores the human-readable delivery summary

The workflow layer exists so teams do not depend on one IDE, one vendor, or one chat thread.
