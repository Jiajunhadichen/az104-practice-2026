# Troubleshooting Record — Sweden Central Region Policy Restriction

This document records the deployment error encountered during Lab 01, analyzing its root cause and detailing the mitigation steps to resolve it.

## Issue 01: Resource Deployment Disallowed by Policy (Sweden Central)

### Symptoms

When executing the ARM deployment targeting a resource group located in **Sweden Central**, the deployment failed with the following error output in the terminal:

```text
New-AzResourceGroupDeployment : 11:45:12 AM - The resource write operation failed to complete successfully, because it reached terminal provisioning state 'Failed'.
ErrorCode: RequestDisallowedByAzure
ErrorMessage: The subscription 'xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx' has a regional policy restriction that does not allow creating resources of type 'Microsoft.Storage/storageAccounts' in region 'swedencentral'.
```

### Root Cause

1. **Syntax Validation vs. Policy Validation**: The ARM template syntax passed local linter checks (valid JSON structure, schema validation, and parameter mapping). However, Azure Resource Manager performs two layers of validation:
   - **Static Validation**: Checks syntax, types, and resource schemas.
   - **Dynamic/Runtime Validation**: Evaluates target subscription limits, resource quotas, RBAC permissions, and active Azure Policy rules before provisioning.
2. **Azure for Students Restrictions**: The Azure for Students subscription enforces regional policy boundaries. Certain regions, including **Sweden Central**, are restricted for specific resource types (e.g., `Microsoft.Storage/storageAccounts`) to preserve capacity for paying customers.

### Resolution

1. **Identify Allowed Regions**: Checked standard available regions for Azure for Students subscription. Common allowed regions for testing include East US, West Europe, and France Central.
2. **Re-target Resource Group Location**:
   - Created a new resource group `rg-arm-template-lab` in the **France Central** region.
   - Re-executed the deployment pointing to the France Central resource group.
3. **Outcome**: The dynamic validation succeeded, and the Storage Account was provisioned with `ProvisioningState: Succeeded`.

### Lessons Learned

- **Syntax is not Authorization**: A correctly configured Bicep/ARM template does not guarantee successful resource creation. Always verify target subscription capabilities and policies.
- **Location Inheritance**: Using `[resourceGroup().location]` is best practice for resource templates, as it inherits the Resource Group's location and allows changing deployment regions without altering the template.
