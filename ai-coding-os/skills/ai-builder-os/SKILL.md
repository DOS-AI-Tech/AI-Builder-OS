---
name: ai-coding-os
description: Apply AI Coding Operating System governance to product work, change requests, bug fixes, releases, deployment, and project initialization.
tier: basic
version: "3.0"
---

# AI Coding Operating System

Use this skill as the host framework for all AI Coding OS basic and paid skills.

## Activation

- Activate for every task in a project whose root contains `.ai/memory/`.
- Activate when the user asks to initialize, bootstrap, upgrade, or use AI Coding OS.
- Paid skills must stop if this host skill is unavailable.

## Task protocol

1. Read project-local `.ai/memory/frozen/architecture.yaml`.
2. Read `.ai/memory/frozen/deployment.yaml`.
3. Read `.ai/memory/active/current-state.yaml`.
4. Read the newest project-local `.ai/memory/task-log/*` entry.
5. Read `.ai/memory/slow/file-index.yaml` and only its matching `read_first` files.
6. Route the task using `references/workflows/intake-and-routing.md`.
7. Obey the selected workflow's human gates before implementation.
8. Keep domain knowledge and all generated outputs inside the current project.

## Project initialization

Initialization is an explicit per-project action. It creates project memory, `domain/`,
`project_docs/`, the dashboard, and thin Agent adapters. It must not install global
framework skills or paid content into the project.

## References

- Workflow contracts: `references/workflows/`
- Output templates: `references/templates/`
- Project memory templates: `assets/memory/`
- Project initialization: `scripts/init-project.sh` or `scripts/init-project.ps1`
