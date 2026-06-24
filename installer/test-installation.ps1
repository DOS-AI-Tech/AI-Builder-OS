#!/usr/bin/env pwsh
$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir = Split-Path -Parent $ScriptDir
$agents = Get-Content (Join-Path $ScriptDir 'agents.conf') | Where-Object { $_ -and -not $_.StartsWith('#') }
if ($agents.Count -ne 5) { throw "Expected 5 Agents, found $($agents.Count)" }
foreach ($line in $agents) {
  $parts = $line -split '\|'
  if ($parts.Count -ne 4) { throw "Invalid agents.conf line: $line" }
}
$skills = @('ai-builder-os','requirements-analyst','architect','project-manager','test-engineer','deployment-engineer')
foreach ($name in $skills) {
  $file = Join-Path $RepoDir "ai-builder-os\skills\$name\SKILL.md"
  if (-not (Test-Path $file)) { throw "Missing $file" }
  $text = Get-Content $file -Raw
  if ($text -notmatch '(?m)^name:' -or $text -notmatch '(?m)^description:') { throw "Invalid skill: $file" }
}
Write-Output 'installation structure tests passed'
