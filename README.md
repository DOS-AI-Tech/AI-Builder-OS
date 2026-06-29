**English** · [简体中文](i18n/README.zh-CN.md) · [User Guide](user-guide/index.html)

![AI Coding OS — reliable AI software delivery](assets/ai-coding-os-banner.png)

# AI Coding Operating System

A zero-dependency operating system that turns capable AI Code Agents into reliable software delivery systems.
Install it once across Claude Code, Codex, GitHub Copilot, Cursor, and Qoder—then give every Agent the same project memory, delivery workflow, human approval gates, and verification discipline.

## Quickstart

### 1. Install AI Coding OS globally for your user

Prerequisites: Git and Bash on macOS/Linux, or Git and PowerShell on Windows. AI Coding OS does not require Node/npm, Python, a server, or a database.

**macOS / Linux (Bash):**

```bash
git clone https://github.com/DOS-AI-Tech/AI-Coding-OS.git ~/ai-coding-os
bash ~/ai-coding-os/installer/install.sh
```

**Windows (PowerShell):**

```powershell
git clone https://github.com/DOS-AI-Tech/AI-Coding-OS.git "$HOME\ai-coding-os"
& "$HOME\ai-coding-os\installer\install.ps1"
```

Choose the Agents you use. The installer adds the core framework and five basic skills to their global skill directories for the current user.

### 2. Initialize an existing project

The target project directory must already exist.

**macOS / Linux (Bash):**

```bash
bash ~/ai-coding-os/installer/init.sh /path/to/project
```

**Windows (PowerShell):**

```powershell
& "$HOME\ai-coding-os\installer\init.ps1" "C:\path\to\project"
```

This creates only project-owned memory, domain scaffolding, output folders, and thin Agent adapters. Global skills are not copied into the project.

### 3. Update an existing installation

If `~/ai-coding-os` (or `$HOME\ai-coding-os` on Windows) already exists, update it instead of cloning it again.

**macOS / Linux (Bash):**

```bash
cd ~/ai-coding-os
git pull
bash installer/update.sh
```

**Windows (PowerShell):**

```powershell
Set-Location "$HOME\ai-coding-os"
git pull
& ".\installer\update.ps1"
```

### 4. Start working

Open the project with any selected Agent and describe a task. AI Coding OS reads the project state, chooses the right workflow, presents the required human gate, and only then proceeds.

## Why It Exists

AI Code Agents can already analyze requirements, design architecture, plan work, write code, run tests, and deploy software. The unresolved problem is not whether an Agent can perform each task—it is whether the Agent can execute the whole lifecycle consistently, in the right order, with enough context and evidence to trust the result.

Without operating discipline, capable Agents still fail in predictable ways:

| Failure | AI Coding OS response |
|---------|------------------------|
| The Agent starts coding before understanding the request | Requirements and plan gates before implementation |
| Decisions and progress disappear between tools or sessions | Project-local architecture, current state, work items, and task logs |
| The Agent produces an answer but skips part of the delivery lifecycle | Workflow routing, phase orchestration, and explicit done criteria |
| A change fixes one path and breaks another | Impact analysis, traceable tests, and regression checks |
| Every Agent follows a different process | One global framework with thin project adapters |

The goal is simple: let Agents do the work while humans retain control—without making the human repeatedly supply memory, enforce the process, and discover omissions at the end.

## What Is Included

AI Coding OS includes shared workflow routing, memory conventions, output templates, project initialization, and five built-in delivery capabilities. They let the same Agent adopt the right mode for each stage instead of improvising the entire project from a single instruction:

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
└── AI Coding OS core + built-in skills
                      │
                      ▼
Initialized once per project
├── .ai/memory/       shared project state
├── domain/           project-specific knowledge
├── project_docs/     requirements, plans, and test evidence
└── thin adapters     ensure each Agent activates the global framework
```

Static framework behavior is global. Business context and work history stay inside the project, where teams can review and version them with Git.

## Advanced Skill Packs

Advanced Skill Packs extend AI Coding OS with specialized capabilities for domain discovery, business modeling, technical analysis, solution design, and expert review workflows.

Download: —

## Documentation

- [English User Guide](user-guide/index.html)
- [中文使用指南](user-guide/index.zh-CN.html)
- [Skill format reference](ai-coding-os/skills/SKILL-FORMAT.md)
- [Workflow reference](ai-coding-os/workflows/README.md)

Updates leave project memory untouched.

## Supported Agents

Claude Code, OpenAI Codex, GitHub Copilot, Cursor, and Qoder are supported through the shared Agent Skills format and native global directories defined in `installer/agents.conf`.

## License and Contributing

AI Coding OS is released under the MIT License. Issues and pull requests are welcome.
