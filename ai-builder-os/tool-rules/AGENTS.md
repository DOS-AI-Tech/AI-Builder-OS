# AI Builder OS Project Adapter

## Global framework
Use the globally installed `ai-builder-os` skill for every task in this project. Stop and ask the user to install the free framework if it is unavailable.

## Project context
Read project-local `.ai/memory/` in the order defined by the global skill. Treat `domain/`, `project_docs/`, `DASHBOARD.md`, and project rules as project-owned data.

## Human gates
Follow the global workflow gate before modifying code, configuration, content, or release scope.

## Close-out
Update current state and write a task log after every completed task.

## Project Rules
<!-- Add project-specific rules below this line. -->
