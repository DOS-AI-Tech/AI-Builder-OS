---
name: skill-name               # kebab-case; becomes /skill-name slash command
tier: advanced
version: "1.0"
invocation: user                # user | model | both
description: ""                 # required if invocation is model or both
                                # example: "When an unfamiliar domain term appears,
                                # activate to update CONTEXT.md."
pack: pack-name                 # e.g. architect-pack, pm-pack
role: role-name                 # role this extends, or "shared" for cross-role
requires: []                    # e.g. [domain-discovery]
---

# [Skill Display Name]

<!--
  Pick the pattern that matches your invocation type and delete the others.
  See ai-coding-os/skills/SKILL-FORMAT.md for full field reference.
-->

<!-- ═══════════════════════════════════════════════
     PATTERN A — invocation: user
     ═══════════════════════════════════════════════ -->

## When to use

<!-- Leading word first. One sentence. State the trigger condition plainly.
     Example: "Domain Discovery — run when entering an unfamiliar business
     domain before requirements work begins." -->

## Steps

1. **[Step name]** — imperative action.
   Done when: [specific completion criterion].

2. **[用户配合] [Step name]** — what to ask or request from the user.
   <!-- Use [用户配合] for any step that cannot proceed without user input. -->
   Done when: user provides the required input or confirms they have none.

3. **[Step name]** — imperative action.
   Done when: [file saved / output confirmed / criterion met].

## Output

Save to `[file path]` before reporting this skill complete.

<!-- ─── Optional sections — delete if not needed ─── -->

## Anti-patterns

- Do not [specific wrong behavior]. Reason: [why it fails].

## Reference

<!-- Definitions, rules, or lookup tables consulted on demand — not sequential steps. -->


<!-- ═══════════════════════════════════════════════
     PATTERN B — invocation: model
     ═══════════════════════════════════════════════ -->

## Activation

<!-- Precise conditions. One bullet per condition. -->
- When [specific pattern] appears in context.
- When [term / action / state] matches [criterion].

## Rules

<!-- Imperative. Every line must change default behavior — delete no-ops. -->
- Always [do X].
- Never [do Y].
- When [condition]: [action].

## Reference

<!-- Optional. -->


<!-- ═══════════════════════════════════════════════
     PATTERN C — invocation: both
     Use Activation + Rules (model path) AND
     When to use + Steps + Output (user path).
     Keep sections in this order, do not merge.
     ═══════════════════════════════════════════════ -->
