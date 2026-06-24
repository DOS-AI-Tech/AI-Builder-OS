#!/usr/bin/env pwsh
# Zero-dependency global installer for Windows.
$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$RepoDir = Split-Path -Parent $ScriptDir
$Source = Join-Path $RepoDir 'ai-builder-os'
$Root = if ($env:AIBOS_HOME) { $env:AIBOS_HOME } else { Join-Path $HOME '.ai-builder-os' }
$Version = (Get-Content (Join-Path $Source 'VERSION') -Raw).Trim()
$selected = @()
Get-Content (Join-Path $ScriptDir 'agents.conf') | Where-Object { $_ -and -not $_.StartsWith('#') } | ForEach-Object {
  $p = $_ -split '\|'; $answer = Read-Host "  $($p[1])? [Y/n]"
  if (-not $answer -or $answer -match '^[Yy]$') { $selected += ,@($p[0],$p[1],$p[3]) }
}
if ($selected.Count -eq 0) { Write-Output 'No Agent selected. Aborted.'; exit 1 }
New-Item -ItemType Directory -Force -Path $Root,(Join-Path $Root 'skills') | Out-Null
$frameworkDest=Join-Path $Root 'framework'; if(Test-Path $frameworkDest){Remove-Item $frameworkDest -Recurse -Force}; Copy-Item $Source $frameworkDest -Recurse
$names = @('ai-builder-os','requirements-analyst','architect','project-manager','test-engineer','deployment-engineer')
foreach ($name in $names) { $d=Join-Path $Root "skills\$name"; if(Test-Path $d){Remove-Item $d -Recurse -Force}; Copy-Item (Join-Path $Source "skills\$name") $d -Recurse }
$core = Join-Path $Root 'skills\ai-builder-os'
New-Item -ItemType Directory -Force -Path (Join-Path $core 'references'),(Join-Path $core 'assets'),(Join-Path $core 'scripts') | Out-Null
Copy-Item (Join-Path $Source 'workflows') (Join-Path $core 'references\workflows') -Recurse -Force
Copy-Item (Join-Path $Source 'templates') (Join-Path $core 'references\templates') -Recurse -Force
Copy-Item (Join-Path $Source 'memory') (Join-Path $core 'assets\memory') -Recurse -Force
Copy-Item (Join-Path $Source 'domain') (Join-Path $core 'assets\domain') -Recurse -Force
Copy-Item (Join-Path $ScriptDir 'init.sh') (Join-Path $core 'scripts\init-project.sh') -Force
Copy-Item (Join-Path $ScriptDir 'init.ps1') (Join-Path $core 'scripts\init-project.ps1') -Force
$state = @()
foreach ($item in $selected) {
  $dest = Join-Path $HOME $item[2]; New-Item -ItemType Directory -Force -Path $dest | Out-Null
  foreach ($name in $names) { $d=Join-Path $dest $name; if(Test-Path $d){Remove-Item $d -Recurse -Force}; Copy-Item (Join-Path $Root "skills\$name") $d -Recurse }
  $state += "$($item[0])|$($item[2])|$Version"; Write-Output "  OK $($item[1])"
}
Set-Content (Join-Path $Root 'install-state.conf') $state
Set-Content (Join-Path $Root 'VERSION') $Version
Write-Output "Done. Run installer\init.ps1 once per project."
