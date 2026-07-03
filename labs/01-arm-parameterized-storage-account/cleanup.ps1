# Copyright (c) 2026 Azure Operations Lab Contributors
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

<#
.SYNOPSIS
    Deletes the resource group and all resources within it for this lab.
.DESCRIPTION
    This script teardown the deployed laboratory environment. It requires the user
    to be logged in to Azure (Connect-AzAccount). For safety, the script requires
    explicit confirmation via the -ConfirmDeletion switch to execute the deletion.
.PARAMETER ResourceGroupName
    The target Resource Group to delete.
.PARAMETER ConfirmDeletion
    Switch parameter to confirm the deletion.
.EXAMPLE
    .\cleanup.ps1 `
      -ResourceGroupName "rg-arm-template-lab" `
      -ConfirmDeletion
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $false)]
    [switch]$ConfirmDeletion
)

if (-not $ConfirmDeletion) {
    Write-Warning "Deletion was not confirmed. No actions were performed."
    Write-Host "`n[SAFETY WARNING] Deleting Resource Group '$ResourceGroupName' will permanently delete ALL resources contained inside it." -ForegroundColor Red
    Write-Host "To confirm deletion, please run the script with the -ConfirmDeletion switch:" -ForegroundColor Cyan
    Write-Host ".\cleanup.ps1 -ResourceGroupName '$ResourceGroupName' -ConfirmDeletion" -ForegroundColor Cyan
    exit 0
}

Write-Host "[WARNING] You are about to permanently delete Resource Group '$ResourceGroupName' and all resources inside it." -ForegroundColor Red
Write-Host "This operation cannot be undone." -ForegroundColor Red
Write-Host "Starting resource group deletion. This may take a few minutes..." -ForegroundColor Yellow

try {
    # Remove the resource group and all resources within it
    Remove-AzResourceGroup -Name $ResourceGroupName -Force -ErrorAction Stop
    Write-Host "Resource Group '$ResourceGroupName' successfully deleted." -ForegroundColor Green
}
catch {
    Write-Error "Failed to delete Resource Group '$ResourceGroupName': $_"
    exit 1
}
