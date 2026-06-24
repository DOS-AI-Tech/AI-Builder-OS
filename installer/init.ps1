#!/usr/bin/env pwsh
$ErrorActionPreference='Stop'
$ScriptDir=Split-Path -Parent $MyInvocation.MyCommand.Path; $Source=Join-Path (Split-Path -Parent $ScriptDir) 'ai-builder-os'
$Target=if($args.Count){(Resolve-Path $args[0]).Path}else{(Get-Location).Path}; $Root=if($env:AIBOS_HOME){$env:AIBOS_HOME}else{Join-Path $HOME '.ai-builder-os'}
if(-not(Test-Path (Join-Path $Root 'VERSION'))){Write-Output 'ERROR: install the free global framework first.'; exit 1}
function Copy-New($src,$dst){$parent=Split-Path -Parent $dst; New-Item -ItemType Directory -Force -Path $parent|Out-Null; if(-not(Test-Path $dst)){Copy-Item $src $dst}}
Copy-New (Join-Path $Source 'memory\frozen\architecture.yaml') (Join-Path $Target '.ai\memory\frozen\architecture.yaml')
Copy-New (Join-Path $Source 'memory\frozen\deployment.yaml') (Join-Path $Target '.ai\memory\frozen\deployment.yaml')
Copy-New (Join-Path $Source 'memory\slow\file-index.yaml') (Join-Path $Target '.ai\memory\slow\file-index.yaml')
Copy-New (Join-Path $Source 'memory\active\current-state.yaml') (Join-Path $Target '.ai\memory\active\current-state.yaml')
Copy-New (Join-Path $Source 'memory\active\work-items\TEMPLATE.md') (Join-Path $Target '.ai\memory\active\work-items\TEMPLATE.md')
Copy-New (Join-Path $Source 'memory\task-log\TEMPLATE.md') (Join-Path $Target '.ai\memory\task-log\TEMPLATE.md')
Copy-New (Join-Path $Source 'domain\README.md') (Join-Path $Target 'domain\README.md'); New-Item -ItemType Directory -Force -Path (Join-Path $Target 'project_docs')|Out-Null
Copy-New (Join-Path $Source 'DASHBOARD.md') (Join-Path $Target 'DASHBOARD.md')
Write-Output "Project initialized at $Target (global skills were not copied)."
