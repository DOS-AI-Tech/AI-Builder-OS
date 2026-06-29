# README Framework

<!-- AI instruction: Use this template when writing README.md via the README Protocol.
     Remove all HTML comment blocks before finalizing the file.
     The "Post-Deployment Checklist" section is mandatory — never omit it. -->

---

# [Project Name]

> [One sentence: what this does and for whom.]

## What is this?

[2–3 sentences. What problem it solves. Who should use it. What it replaces or improves.]

## Prerequisites

- [Runtime / tool 1 — version requirement]
- [Runtime / tool 2 — version requirement]

## Setup

```bash
# Install dependencies
[install command]

# Configure environment
cp .env.example .env
# Required variables: [list them]
```

## Usage

```bash
[main command to start or run the project]
```

[1–2 sentence description. Add 2–3 concrete examples if the tool has multiple modes.]

## Deployment

**Platform:** [Vercel / AWS / Docker / bare server / GitHub Actions / etc.]

```bash
[deployment command or sequence]
```

**Required environment variables:**

| Variable | Description | Example |
|----------|-------------|---------|
| `VAR_NAME` | What it controls | `value` |

## Post-Deployment Checklist

<!-- AI instruction: Fill every item from the user's answers to the Post-Deployment questions.
     Never leave placeholders — if the user said "none", write "None required." -->

Run through this after every deployment:

- [ ] **Verify** — [health check URL or smoke test command, e.g. `curl https://app.example.com/health` or "open /dashboard and confirm data loads"]
- [ ] **Monitor** — [what to watch in logs or metrics for the first 10 minutes after deploy]
- [ ] **Notify** — [who to tell and how, e.g. "Post in #releases: deployed v1.2.0"]
- [ ] **Rollback** — [exact steps to revert if something breaks, e.g. `git revert HEAD && git push && fly deploy`]

**Required post-deploy steps (run once after deploy):**
- [ ] [Database migration / cache warm-up / feature flag / user announcement — or "None required."]

## Troubleshooting

**[Error message or symptom]**
→ [Fix or workaround]

## Contributing

[How to submit issues or PRs, or link to CONTRIBUTING.md.]

## License

[License type, e.g. MIT]
