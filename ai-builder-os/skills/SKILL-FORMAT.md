# Skill Format Reference

Every skill entry file is named `SKILL.md` (uppercase) to follow the Agent Skills standard.
Paid skills must declare `requires: [ai-builder-os]` and cannot run without the free host framework.

A skill is a named, reusable practice — not a role description. Each skill solves one specific problem with a deterministic process. The core virtue is **predictability**: the model follows the same steps every run.

---

## Frontmatter

```yaml
---
skill: kebab-case-name      # required — also the slash command /name
tier: basic | advanced      # required
version: "1.0"              # required — semver string
invocation: user | model | both  # required — see Invocation Model below
description: "..."          # required when invocation is model or both
                            # front-load the trigger condition; this is what
                            # the model reads to decide whether to self-activate
pack: pack-name             # advanced only — which paid pack this belongs to
role: role-name | shared    # advanced only — role this extends, or "shared"
                            # for cross-role skills (e.g. domain-discovery)
requires:                   # optional — other skills that must be installed first
  - other-skill-name        # installer auto-resolves; skill reads them at runtime
---
```

### Field rules

| Field | Required | Notes |
|---|---|---|
| `skill` | always | kebab-case; becomes the slash command name |
| `tier` | always | `basic` files ship with installer; `advanced` never overwritten by update.sh |
| `version` | always | bump on every content change |
| `invocation` | always | determines which body sections are required |
| `description` | model or both | one sentence, trigger condition first |
| `pack` | advanced only | omit for basic-tier skills |
| `role` | advanced only | use `shared` for cross-role skills |
| `requires` | optional | installer cascades; listed skills load before this one |

---

## Invocation Model

**`user`** — triggered when the user consciously starts the skill. Zero context load when idle. Use for workflows the user must explicitly initiate.

**`model`** — triggered automatically when `description` matches the current context. Always loaded. Use for persistent rules that should activate without the user asking.

**`both`** — supports both paths. `description` drives auto-activation; `## Steps` drives the user-invoked workflow. Keep the two sections separate.

> **Choosing between user and model:** If the skill could fire in the middle of another task without the user noticing, use `model`. If the user needs to consciously decide to start it, use `user`.

### Multi-tool invocation

This framework runs across multiple agent environments (Claude Code, Cursor, Copilot, Codex, Qoder). Invocation differs by tool:

| Tool | user-invoked | model-invoked |
|------|-------------|---------------|
| Claude Code | `/skill-name` slash command | auto-activates via `description` |
| Cursor / Copilot / Codex / Qoder | Natural language: "run requirements analysis" / "act as test engineer" | auto-activates via `description` (if tool loads INSTALLED.md) |

**Skill body must not contain `/slash-command` syntax.** Slash commands are a Claude Code implementation detail — they belong in tool-specific documentation, not in skill content. The `## When to use` section describes the trigger condition in plain language so it works across all tools.

---

## Body Structure

### `invocation: user`

```markdown
## When to use
One sentence. Leading word first — the core concept that anchors this skill.
State the trigger condition plainly: when X happens, run this skill.

## Steps
1. **Step name** — imperative action.
   Done when: [specific completion criterion — not "review" or "consider"].

2. **[用户配合] Step name** — what to ask or request from the user.
   Done when: user provides the required input or explicitly says they have none.

3. **Step name** — imperative action.
   Done when: [file saved / output confirmed / criterion met].

## Output
File(s) produced and where to save them. State the path and format.
The skill is not complete until output is saved — report completion only after the write.

## Anti-patterns  ← optional
- Do not [specific wrong behavior]. Reason: [why it fails].

## Reference  ← optional, consulted on demand
Definitions, rules, or lookup tables. Not sequential. The model reads these
when a step requires background knowledge, not as part of the flow.
```

### `invocation: model`

```markdown
## Activation
Precise condition(s) that trigger this skill. One condition per bullet.
- When [specific pattern] appears in context
- When [term / action / file] is encountered that matches [criterion]

## Rules
Imperative behaviors that apply whenever this skill is active.
- Always [do X]
- Never [do Y]
- When [condition]: [action]

## Reference  ← optional
```

### `invocation: both`

Include all sections from both patterns above. Order: `## Activation`, `## Rules`, `## When to use`, `## Steps`, `## Output`. Do not merge the two execution paths.

---

## Step Conventions

### Completion criterion
Every step must state when it is done. Vague verbs (`review`, `consider`, `look at`) are not completion criteria.

```
✗  3. Review the domain entities.
✓  3. **Map core entities** — list every entity and its definition.
      Done when: entities are written to CONTEXT.md under ## Entities.
```

### `[用户配合]` marker
Steps that cannot execute without user input, files, or decisions must be marked. The framework cannot force users to provide resources — skill authors must not write these as unconditional automatic steps.

```
2. **[用户配合] Gather existing documents** — ask:
   "是否有现有业务文档可以参考？（需求文档、行业规范、产品说明书等）
   如有，请提供文件路径或直接粘贴内容。"
   Done when: user provides documents or confirms none exist.
```

If the user has no documents, the step still completes — the skill branches to the next path.

---

## CONTEXT.md Convention

`CONTEXT.md` lives at the **target project root** alongside `CLAUDE.md`. It is the project's domain vocabulary — created by `domain-discovery`, maintained by `domain-modeling`.

Skills that depend on domain context declare `requires: [domain-discovery]` and open their steps with:
```
1. **Read domain context** — read `CONTEXT.md` for vocabulary before proceeding.
   Done when: key terms for this task are identified.
```

Skills that update domain context write to `CONTEXT.md` directly and report which terms were added or changed.

### CONTEXT.md sections
```markdown
# Domain Context — [Project Name]

## Glossary
**[Term]**: precise meaning in this domain. Note if it differs from everyday usage.

## Entities
[Entity]: what it is, who owns it, its lifecycle.

## Processes
[Process]: trigger → steps → end state.

## Rules
- Business rule (source: regulation / contract / operating convention)

## Disambiguation
- "[Term]" in this domain ≠ its everyday meaning. Here it means: [precise def].
```

---

## Quality Checklist

Run before publishing any skill:

- [ ] **No premature completion** — every step has a specific done criterion; none end on a verb alone
- [ ] **No duplication** — same rule appears once; cross-reference via `requires` instead of repeating content
- [ ] **No no-ops** — every rule changes default model behavior; delete lines that restate what the model does anyway
- [ ] **No sprawl** — if skill body exceeds ~60 lines, split by invocation type or by sequence into two skills
- [ ] **No sediment** — when updating, delete old rules rather than appending new ones below them
- [ ] **`[用户配合]` marked** — every step requiring external input is explicitly marked
- [ ] **Output is mandatory** — skill declares what file(s) it produces and does not report complete until they are saved
