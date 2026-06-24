#!/usr/bin/env pwsh
$ErrorActionPreference = 'Stop'
$ScriptDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$Root = if ($env:AIBOS_HOME) { $env:AIBOS_HOME } else { Join-Path $HOME '.ai-builder-os' }
if ($args.Count -lt 1) { Write-Output 'Usage: install-skill.ps1 <skill-name> [pack-dir]'; exit 1 }
$name=$args[0]; $pack=if($args.Count -gt 1){$args[1]}else{Join-Path (Split-Path -Parent $ScriptDir) "skill-packs\$name"}
if (-not (Test-Path (Join-Path $pack 'SKILL.md'))) { Write-Output "ERROR: $pack\SKILL.md not found."; exit 1 }
$stateFile=Join-Path $Root 'install-state.conf'; if(-not(Test-Path $stateFile)){Write-Output 'ERROR: free AI Builder OS framework is required.'; exit 1}
$installed=0
foreach($line in Get-Content $stateFile){$p=$line -split '\|'; $core=Join-Path (Join-Path $HOME $p[1]) 'ai-builder-os\SKILL.md'; if(Test-Path $core){$a=Read-Host "Install '$name' for $($p[0])? [Y/n]"; if(-not $a -or $a -match '^[Yy]$'){$dest=Join-Path (Join-Path $HOME $p[1]) $name; if(Test-Path $dest){Remove-Item $dest -Recurse -Force}; Copy-Item $pack $dest -Recurse; $installed++}}}
if($installed -eq 0){Write-Output 'ERROR: no eligible Agent selected.'; exit 1}
Write-Output "Done. Paid skill '$name' installed; framework unchanged."
