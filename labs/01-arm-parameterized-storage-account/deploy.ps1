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
    Deploys a parameterized Storage Account using an ARM template.
.DESCRIPTION
    This script provisions an Azure Storage Account. It requires the user
    to be logged in to Azure (Connect-AzAccount) before running.
    It automatically targets the local azuredeploy.json file and passes
    the parameters provided.
.PARAMETER ResourceGroupName
    The name of the target Resource Group. Must already exist.
.PARAMETER StorageAccountName
    A globally unique name for the storage account (3-24 alphanumeric characters, lowercase).
.PARAMETER StorageAccountType
    The redundancy SKU of the Storage Account.
.EXAMPLE
    .\deploy.ps1 `
      -ResourceGroupName "rg-arm-template-lab" `
      -StorageAccountName "yourgloballyuniquename123" `
      -StorageAccountType "Standard_LRS"
#>

[CmdletBinding()]
param (
    [Parameter(Mandatory = $true)]
    [string]$ResourceGroupName,

    [Parameter(Mandatory = $true)]
    [string]$StorageAccountName,

    [Parameter(Mandatory = $false)]
    [ValidateSet("Standard_LRS", "Standard_GRS", "Standard_ZRS", "Premium_LRS")]
    [string]$StorageAccountType = "Standard_LRS"
)

# Prerequisites Reminder
# NOTE: Ensure you are logged in using Connect-AzAccount and have selected the correct subscription before running this script.

Write-Host "Checking local ARM template..." -ForegroundColor Cyan
$PSScriptRootPath = Split-Path -Parent -Path $MyInvocation.MyCommand.Definition
$TemplateFile = Join-Path -Path $PSScriptRootPath -ChildPath "azuredeploy.json"

if (-not (Test-Path -Path $TemplateFile)) {
    Write-Error "ARM template file 'azuredeploy.json' was not found in the script directory."
    exit 1
}

# Generate unique deployment name with timestamp
$Timestamp = Get-Date -Format "yyyyMMdd-HHmmss"
$DeploymentName = "StorageDeploy-$Timestamp"

Write-Host "Target Resource Group: $ResourceGroupName" -ForegroundColor Cyan
Write-Host "Storage Account Name : $StorageAccountName" -ForegroundColor Cyan
Write-Host "Storage Redundancy   : $StorageAccountType" -ForegroundColor Cyan
Write-Host "Deployment Name      : $DeploymentName" -ForegroundColor Cyan
Write-Host "Starting Azure Resource Group Deployment..." -ForegroundColor Green

try {
    $Params = @{
        storageAccountName = $StorageAccountName
        storageAccountType = $StorageAccountType
    }

    $Deployment = New-AzResourceGroupDeployment `
        -Name $DeploymentName `
        -ResourceGroupName $ResourceGroupName `
        -TemplateFile $TemplateFile `
        -TemplateParameterObject $Params `
        -ErrorAction Stop

    Write-Host "Deployment Completed Successfully!" -ForegroundColor Green
    Write-Host "Provisioning State: $($Deployment.ProvisioningState)" -ForegroundColor Green
    
    Write-Host "`nOutputs:" -ForegroundColor Cyan
    $Deployment.Outputs.Keys | ForEach-Object {
        Write-Host "  $_ : $($Deployment.Outputs[$_].Value | ConvertTo-Json -Compress)" -ForegroundColor Yellow
    }
}
catch {
    Write-Error "Deployment failed with error: $_"
    exit 1
}
