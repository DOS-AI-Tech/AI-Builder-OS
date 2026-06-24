#!/usr/bin/env bash
# pre-edit-parity-check.sh — PreToolUse hook (Edit tool)
#
# Fires before any Edit or Write call on a tool-rule file.
# Reminds Claude to maintain five-environment parity across:
#   CLAUDE.md / AGENTS.md / .github/copilot-instructions.md /
#   .cursor/rules/workflow-governance.mdc / .qoder/rules/workflow-governance.md

input="$(cat)"

file_path=$(echo "$input" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    p = d.get('tool_input', {}).get('file_path', '')
    print(p)
except:
    print('')
" 2>/dev/null || true)

if echo "$file_path" | grep -qE '(CLAUDE\.md|AGENTS\.md|copilot-instructions\.md|workflow-governance\.mdc|workflow-governance\.md)$'; then
    echo ""
    echo "FIVE_ENVIRONMENT_PARITY: You are editing a tool-rule file."
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
