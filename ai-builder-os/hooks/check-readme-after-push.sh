#!/usr/bin/env bash
# check-readme-after-push.sh — PostToolUse hook
#
# Fires after every Bash tool call.
# Detects git push and instructs the AI to check/update README.md.
#
# Installation: registered in .claude/settings.json by init.sh.

input="$(cat)"

# Only act when a git push was executed
if ! echo "$input" | grep -q 'git push'; then
    exit 0
fi

if [ ! -f "README.md" ]; then
    echo ""
    echo "README_MISSING: git push completed but README.md does not exist."
    echo "Follow the README Protocol: guide the user to create README.md now."
    echo ""
else
    echo ""
    echo "README_REVIEW: git push completed."
    echo "Follow the README Protocol: check if README.md needs updating based on the changes just pushed."
    echo "If any section is outdated or missing, update README.md, commit, and push the change."
    echo ""
fi

exit 0
