#!/usr/bin/env pwsh
# Global framework update; paid skills and project state are untouched.
& (Join-Path (Split-Path -Parent $MyInvocation.MyCommand.Path) 'install.ps1')
exit $LASTEXITCODE
