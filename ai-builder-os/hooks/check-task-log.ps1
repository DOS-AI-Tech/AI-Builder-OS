#!/usr/bin/env pwsh
# check-task-log.ps1 — Stop hook (Windows)
# Equivalent of check-task-log.sh for Claude Code / Codex CLI on Windows.
# Runs when a session ends. Warns if files were modified but no task log written today.

$taskLogDir = ".ai/memory/task-log"
$today = Get-Date -Format "yyyy-MM-dd"

try {
    $null = git rev-parse --git-dir 2>$null
    if ($LASTEXITCODE -ne 0) { exit 0 }
} catch { exit 0 }

$diff   = git diff HEAD 2>$null
$cached = git diff --cached 2>$null
if (-not $diff -and -not $cached) { exit 0 }

$logs = Get-ChildItem "$taskLogDir/$today-*.md" -ErrorAction SilentlyContinue
if ($logs) { exit 0 }

Write-Output ""
Write-Output "WARNING: Task log missing for today ($today)."
Write-Output ""
Write-Output "Before closing this session:"
Write-Output "  1. Write $taskLogDir/$today-<slug>.md"
Write-Output "     (use TEMPLATE.md as the format reference)"
Write-Output "  2. Update .ai/memory/active/current-state.yaml"
Write-Output "     (in_progress, recently_completed, known_issues, last_session)"
Write-Output ""
Write-Output "The next session depends on this record."
Write-Output ""

exit 0
