#!/usr/bin/env pwsh
# pre-bash-deployment-check.ps1 — PreToolUse hook (Windows)
# Equivalent of pre-bash-deployment-check.sh for Claude Code / Codex CLI on Windows.
# Fires before every Bash tool call. Warns when command looks deployment-related.

$payload = [Console]::In.ReadToEnd()

try {
    $json    = $payload | ConvertFrom-Json
    $command = $json.tool_input.command
} catch { exit 0 }

$patterns = 'docker|kubectl|python.*-m\s+deploy|systemctl|supervisorctl|staff_manager|bot_instances|/opt/|\.venv[/\\]bin[/\\]python|gunicorn|uvicorn|celery|migrate|makemigrations'

if ($command -match $patterns) {
    if (-not (Test-Path ".ai/memory/frozen/deployment.yaml")) {
        Write-Output "DEPLOYMENT_GATE: deployment.yaml not found. Run bootstrap before executing deployment commands."
        exit 0
    }
    Write-Output "DEPLOYMENT_GATE: This looks like a deployment or infrastructure command."
    Write-Output "Have you read .ai/memory/frozen/deployment.yaml this session?"
    Write-Output "Use only paths, commands, and env vars listed there. Never guess."
}

exit 0
