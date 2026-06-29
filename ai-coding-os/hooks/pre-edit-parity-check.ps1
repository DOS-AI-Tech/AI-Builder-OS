#!/usr/bin/env pwsh
# pre-edit-parity-check.ps1 — PreToolUse hook (Windows)
# Equivalent of pre-edit-parity-check.sh for Claude Code on Windows.
# Fires before any Edit or Write call on a tool-rule file.

$payload = [Console]::In.ReadToEnd()

try {
    $json     = $payload | ConvertFrom-Json
    $filePath = $json.tool_input.file_path
} catch { exit 0 }

$toolRulePattern = 'CLAUDE\.md|AGENTS\.md|copilot-instructions\.md|workflow-governance\.mdc|workflow-governance\.md'

if ($filePath -match $toolRulePattern) {
    Write-Output ""
    Write-Output "FIVE_ENVIRONMENT_PARITY: You are editing a tool-rule file."
    Write-Output "The same change must appear in ALL FIVE files before this task is done:"
    Write-Output "  * CLAUDE.md                                -- Claude Code"
    Write-Output "  * AGENTS.md                                -- GPT Codex CLI"
    Write-Output "  * .github/copilot-instructions.md          -- GitHub Copilot"
    Write-Output "  * .cursor/rules/workflow-governance.mdc    -- Cursor IDE"
    Write-Output "  * .qoder/rules/workflow-governance.md      -- Qoder"
    Write-Output ""
    Write-Output "Do not commit until all five are updated."
    Write-Output ""
}

exit 0
