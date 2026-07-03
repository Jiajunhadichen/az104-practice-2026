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
    Deletes the resources created by this lab.
.DESCRIPTION
    This script deletes the resource group or individual resources
    created by this lab. Confirmation is required to prevent accidental deletion.
.PARAMETER ResourceGroupName
    The target Resource Group to delete.
.PARAMETER ConfirmDeletion
    Switch parameter to confirm the deletion.
.EXAMPLE
    .\cleanup.ps1 -ResourceGroupName "rg-example" -ConfirmDeletion
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $false)]
    [switch]$ConfirmDeletion
)

if (-not $ConfirmDeletion) {
    Write-Warning "Deletion was not confirmed. To delete the resource group '$ResourceGroupName' and all its resources, please run the script with the -ConfirmDeletion switch."
    Write-Host "Example: .\cleanup.ps1 -ResourceGroupName '$ResourceGroupName' -ConfirmDeletion" -ForegroundColor Cyan
    exit 0
}

Write-Host "Confirmed. Initializing cleanup of Resource Group '$ResourceGroupName'..." -ForegroundColor Yellow
# Implement actual resource teardown here, e.g.:
# Remove-AzResourceGroup -Name $ResourceGroupName -Force
