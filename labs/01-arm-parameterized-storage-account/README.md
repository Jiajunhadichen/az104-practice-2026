# Lab 01 — Parameterized Azure Storage Account with ARM Templates

## Objective

Deploy an Azure Storage Account through an ARM template and make the deployment reusable with parameters, allowed values, and deployment outputs.

## Scenario

A reusable infrastructure template is needed so that different environments can deploy Storage Accounts with different names and redundancy SKUs without editing the template source code.

## Skills Demonstrated

- **Azure Resource Manager (ARM) deployments**: Using JSON templates to define and deploy cloud infrastructure.
- **ARM Parameterization**: Making templates modular using parameter files and validation rules.
- **Azure PowerShell Automation**: Executing deployments and resource teardowns via script files.
- **Allowed Value Validation**: Restricting deployment inputs (`allowedValues`) directly in the ARM schema to control cost and configurations.
- **Deployment Outputs**: Extracting deployment properties (e.g., storage endpoints) to integrate with downstream systems.
- **Azure Portal Verification**: Reviewing deployment metrics, configuration details, inputs, and outputs in the Azure Portal interface.
- **Subscription Region Policy Troubleshooting**: Identifying subscription-level regional resource placement constraints and recovering from deployment blockages.

## Architecture / Deployment Flow

```text
Local VS Code
  → PowerShell
  → Azure PowerShell Az module
  → Azure Resource Manager
  → Resource Group
  → Azure Storage Account
```

## Resources Created

| Resource | Type | Purpose |
|---|---|---|
| Resource Group | `Microsoft.Resources/resourceGroups` | Isolated lab deployment scope |
| Storage Account | `Microsoft.Storage/storageAccounts` | Parameterized storage deployment |
| Deployment Record | `Microsoft.Resources/deployments` | Audit trail for template execution |

## Parameters

| Parameter Name | Type | Purpose | Default Value | Validation / Allowed Values | Example Value |
|---|---|---|---|---|---|
| `storageAccountName` | `string` | Globally unique Storage Account name | *None (Required)* | 3 to 24 alphanumeric lowercase characters | `myuniquelabstorage1` |
| `storageAccountType` | `string` | Redundancy and performance SKU | `Standard_LRS` | `Standard_LRS`, `Standard_GRS`, `Standard_ZRS`, `Premium_LRS` | `Standard_LRS` |

## Deployment

Ensure you are logged in to your Azure account before running the script:
```powershell
Connect-AzAccount
```

Deploy the storage account by running:
```powershell
.\deploy.ps1 `
  -ResourceGroupName "rg-arm-template-lab" `
  -StorageAccountName "yourgloballyuniquename123" `
  -StorageAccountType "Standard_LRS"
```

## Validation

1. **Successful Execution**: The terminal command outputs `ProvisioningState: Succeeded` and displays the storage endpoint details.
2. **Resource Group View**: The newly created Storage Account appears in the specified Resource Group `rg-arm-template-lab` in the Azure Portal.
3. **Deployment Logs**: Inspecting the Resource Group's "Deployments" section in the Portal shows:
   - **Inputs**: The exact parameter values submitted by the script.
   - **Outputs**: The generated primary endpoints (`storageEndpoint`).
4. **Configuration Check**: The SKU matches `Standard_LRS` and tags include the `displayName`.

## Troubleshooting

### Regional Policy Restriction

When attempting the initial deployment of the Storage Account in the **Sweden Central** region, Azure Resource Manager rejected the deployment with an error related to `RequestDisallowedByAzure` and subscription regional policy restrictions.

**Analysis**:
- Validating the ARM template syntax is insufficient; ARM also validates permissions, policy restrictions, quotas, and subscription regions.
- The **Azure for Students** subscription imposes region restrictions that prevent provisioning Storage Accounts in Sweden Central.

**Resolution**:
- Created a new Resource Group `rg-arm-template-lab` in the **France Central** region.
- Re-executed the deployment targetting France Central, resulting in a successful deployment.

For detailed error outputs and troubleshooting logs, refer to the [Troubleshooting Record](./troubleshooting.md).

## Security Notes

- **Secrets Sanitization**: Do not commit access keys, connection strings, SAS tokens, or service principal credentials.
- **Example Parameters**: The `parameters.example.json` file contains only dummy placeholders. Never upload production parameters to version control.

## Cleanup

To avoid charges on your Azure account, clean up the resources by deleting the entire resource group:
```powershell
.\cleanup.ps1 -ResourceGroupName "rg-arm-template-lab" -ConfirmDeletion
```

## Evidence

Refer to the [Evidence Documentation](./evidence/README.md) for verified output parameters and logs.
