#!/usr/bin/env bash
# pre-patch-parity-check.sh — PreToolUse hook (apply_patch tool)
#
# Fires before any apply_patch call that touches a tool-rule file.
# Reminds Codex CLI to maintain five-environment parity across:
#   CLAUDE.md / AGENTS.md / .github/copilot-instructions.md /
#   .cursor/rules/workflow-governance.mdc / .qoder/rules/workflow-governance.md

payload="$(cat)"

patch_text="$(printf '%s' "$payload" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('tool_input', {}).get('command', ''))
except:
    print('')
" 2>/dev/null || true)"

if echo "$patch_text" | grep -qE '(CLAUDE\.md|AGENTS\.md|copilot-instructions\.md|workflow-governance\.mdc|workflow-governance\.md)'; then
    echo ""
    echo "FIVE_ENVIRONMENT_PARITY: You are patching a tool-rule file."
    echo "The same change must appear in ALL FIVE files before this task is done:"
    echo "  • CLAUDE.md                                — Claude Code"
    echo "  • AGENTS.md                                — GPT Codex CLI"
    echo "  • .github/copilot-instructions.md          — GitHub Copilot"
    echo "  • .cursor/rules/workflow-governance.mdc    — Cursor IDE"
    echo "  • .qoder/rules/workflow-governance.md      — Qoder"
    echo ""
    echo "Do not commit until all five are updated."
    echo ""
fi

exit 0
