**English** · [简体中文](i18n/README.zh-CN.md) · [User Guide](user-guide/index.html)

# AI Builder Operating System

A free, zero-dependency operating system for reliable AI-assisted software delivery.
Install it once across Claude Code, Codex, GitHub Copilot, Cursor, and Qoder—then let every Agent work from the same project memory, workflow, and human approval gates.

## Quickstart

### 1. Install the free framework globally

```bash
git clone https://github.com/DOS-AI-Tech/AI-Builder-OS.git ~/ai-builder-os
bash ~/ai-builder-os/installer/install.sh
```

```powershell
git clone https://github.com/DOS-AI-Tech/AI-Builder-OS.git "$HOME\ai-builder-os"
& "$HOME\ai-builder-os\installer\install.ps1"
```

Choose the Agents you use. The installer adds the core framework and five basic skills to their global skill directories. No Node/npm, Python, server, or database is required.

### 2. Initialize a project

```bash
bash ~/ai-builder-os/installer/init.sh /path/to/project
```

```powershell
& "$HOME\ai-builder-os\installer\init.ps1" "C:\path\to\project"
```

This creates only project-owned memory, domain scaffolding, output folders, and thin Agent adapters. Global skills are not copied into the project.

### 3. Start working

Open the project with any selected Agent and describe a task. AI Builder OS reads the project state, chooses the right workflow, presents the required human gate, and only then proceeds.

## Why It Exists

Coding Agents are fast, but speed without operating discipline creates predictable failures:

| Failure | AI Builder OS response |
|---------|------------------------|
| The Agent starts coding before understanding the request | Requirements and plan gates before implementation |
| Context is lost between tools or sessions | Project-local architecture, current state, work items, and task logs |
| A change fixes one path and breaks another | Impact analysis, traceable tests, and regression checks |
| Every Agent follows a different process | One global framework with thin project adapters |

The goal is simple: keep humans in control without having to re-explain the project every session.

## What Is Included

The free framework contains shared workflow routing, memory conventions, output templates, project initialization, and five basic skills:

| Skill | Responsibility |
|-------|----------------|
| `requirements-analyst` | Product definition, MVP scope, acceptance criteria, change impact |
| `architect` | Technical decisions, boundaries, ADRs, delivery-appropriate stacks |
| `project-manager` | Phase orchestration, plans, gates, work items, handoffs |
| `test-engineer` | Test planning, traceability, execution, regression verification |
| `deployment-engineer` | Approved deployment commands, verification, rollback |

## How It Works

```text
Installed once for each selected Agent
└── AI Builder OS core + free basic skills
                      │
                      ▼
Initialized once per project
├── .ai/memory/       shared project state
├── domain/           project-specific knowledge
├── project_docs/     requirements, plans, and test evidence
└── thin adapters     ensure each Agent activates the global framework
```

Static framework behavior is global. Business context and work history stay inside the project, where teams can review and version them with Git.

## Paid Skill Packs

Advanced skill packs are sold and delivered separately from the free framework. They add specialized domain expertise while using the same host workflows and project memory.

```bash
bash ~/ai-builder-os/installer/install-skill.sh <skill-name> /path/to/purchased-pack
```

```powershell
& "$HOME\ai-builder-os\installer\install-skill.ps1" <skill-name> "C:\path\to\purchased-pack"
```

The free framework is mandatory. If it is not installed for any Agent, paid-skill installation stops. Paid skills do not contain or modify the free framework.

## Documentation

- [English User Guide](user-guide/index.html)
- [中文使用指南](user-guide/index.zh-CN.html)
- [Skill format reference](ai-builder-os/skills/SKILL-FORMAT.md)
- [Workflow reference](ai-builder-os/workflows/README.md)

Upgrade the free framework by pulling the repository and running `installer/update.sh` or `installer/update.ps1`. Project memory and paid skills remain untouched.

## Supported Agents

Claude Code, OpenAI Codex, GitHub Copilot, Cursor, and Qoder are supported through the shared Agent Skills format and native global directories defined in `installer/agents.conf`.

## License and Contributing

The framework is free and open source. Issues and pull requests are welcome. Keep paid skill-pack content outside the public framework repository.
