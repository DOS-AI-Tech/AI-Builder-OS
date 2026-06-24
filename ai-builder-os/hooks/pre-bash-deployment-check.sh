#!/usr/bin/env bash
# pre-bash-deployment-check.sh — PreToolUse hook
#
# Fires before every Bash tool call.
# If the command looks deployment-related, reminds Claude to read
# deployment.yaml before proceeding — prevents path/command guessing.
#
# Installation: registered in .claude/settings.json by init.sh.

input="$(cat)"

# Extract the bash command from the JSON input
command=$(echo "$input" | python3 -c "
import sys, json
try:
    d = json.load(sys.stdin)
    print(d.get('tool_input', {}).get('command', ''))
except:
    print('')
" 2>/dev/null || true)

# Patterns that indicate a deployment or infrastructure command
if echo "$command" | grep -qE \
    '(docker|kubectl|python.*-m\s+deploy|systemctl|supervisorctl|staff_manager|bot_instances|/opt/|\.venv/bin/python|gunicorn|uvicorn|celery|migrate|makemigrations)'; then

    if [ ! -f ".ai/memory/frozen/deployment.yaml" ]; then
        echo "DEPLOYMENT_GATE: deployment.yaml not found. Run bootstrap before executing deployment commands."
        exit 0
    fi

    echo "DEPLOYMENT_GATE: This looks like a deployment or infrastructure command."
    echo "Have you read .ai/memory/frozen/deployment.yaml this session?"
    echo "Use only paths, commands, and env vars listed there. Never guess."
fi

exit 0
