#!/usr/bin/env pwsh
# check-readme-after-push.ps1 — PostToolUse hook (Windows)
# Equivalent of check-readme-after-push.sh for Claude Code / Codex CLI on Windows.
# Fires after every Bash tool call. Detects git push and prompts README review.

$payload = [Console]::In.ReadToEnd()

try {
    $json    = $payload | ConvertFrom-Json
    $command = $json.tool_input.command
} catch { exit 0 }

if ($command -notmatch "git push") { exit 0 }

if (-not (Test-Path "README.md")) {
    Write-Output ""
    Write-Output "README_MISSING: git push completed but README.md does not exist."
    Write-Output "Follow the README Protocol: guide the user to create README.md now."
    Write-Output ""
} else {
    Write-Output ""
    Write-Output "README_REVIEW: git push completed."
    Write-Output "Follow the README Protocol: check if README.md needs updating based on the changes just pushed."
    Write-Output "If any section is outdated or missing, update README.md, commit, and push the change."
    Write-Output ""
}

exit 0
