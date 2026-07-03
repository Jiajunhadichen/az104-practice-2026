# Lab 01 Evidence

This document collects validation evidence and reproducibility parameters for **Lab 01 — Parameterized Azure Storage Account with ARM Templates**.

---

## 1. Source Artifacts

All operational files for this lab are located in the parent directory:
- [ARM Template](../azuredeploy.json)
- [PowerShell Deployment Script](../deploy.ps1)
- [PowerShell Cleanup Script](../cleanup.ps1)
- [Example Parameter File](../parameters.example.json)

---

## 2. Deployment Validation

### Sanitized Terminal Logs

The deployment was executed successfully from a local PowerShell session, returning the following sanitized output parameters:

```powershell
ResourceGroupName : rg-arm-template-lab
DeploymentName    : StorageDeploy-20260703-115000
ProvisioningState : Succeeded
Outputs           :
  Name            : storageEndpoint
  Type            : Object
  Value           : {
                      "blob": "https://[storageAccountName].blob.core.windows.net/",
                      "file": "https://[storageAccountName].file.core.windows.net/",
                      "queue": "https://[storageAccountName].queue.core.windows.net/",
                      "table": "https://[storageAccountName].table.core.windows.net/"
                    }
```

### Azure Portal Verification Points

Verified in the Azure Portal at the following interfaces:
1. **Resource Group Resource List**: Shows the Storage Account deployed with type `StorageV2 (general purpose v2)` under the location `France Central`.
2. **Deployment Input History**: Displays the customized parameter values submitted:
   - `storageAccountName` = `[globally-unique-name]`
   - `storageAccountType` = `Standard_LRS`
3. **Deployment Output History**: Displays the returned `storageEndpoint` object with correct HTTPS endpoint structure matching the primary blob storage URLs.

---

## 3. Troubleshooting Evidence

### Sweden Central Regional Restrictive Log

```text
ErrorCode: RequestDisallowedByAzure
ErrorMessage: The subscription 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' has a regional policy restriction that does not allow creating resources of type 'Microsoft.Storage/storageAccounts' in region 'swedencentral'.
```

- **Resolution Log**: Created resource group `rg-arm-template-lab` in location `francecentral` and deployed successfully.

---

## 4. Reproducibility

To reproduce this deployment, execute the following prerequisites:
1. An active Azure subscription (e.g., Azure for Students).
2. A destination resource group configured in an allowed region (e.g., `France Central`).
3. Provide a globally unique Storage Account name (lowercase, alphanumeric, 3-24 characters).
4. Run the script `.\deploy.ps1` with the respective arguments.
