#!/usr/bin/env pwsh
# pre-patch-parity-check.ps1 — PreToolUse hook (Windows)
# Equivalent of pre-patch-parity-check.sh for Codex CLI on Windows.
# Fires before any apply_patch call. Reads patch text from tool_input.command
# and warns when a tool-rule file is being modified.

$payload = [Console]::In.ReadToEnd()

try {
    $json      = $payload | ConvertFrom-Json
    $patchText = $json.tool_input.command
} catch { exit 0 }

$toolRulePattern = 'CLAUDE\.md|AGENTS\.md|copilot-instructions\.md|workflow-governance\.mdc|workflow-governance\.md'

if ($patchText -match $toolRulePattern) {
    Write-Output ""
    Write-Output "FIVE_ENVIRONMENT_PARITY: You are patching a tool-rule file."
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
