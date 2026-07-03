# Lab Template Guidelines

Before creating a new lab, verify it meets the following minimum requirements:
1. **Real Execution**: The lab must have been executed, configured, and verified successfully on your Azure subscription.
2. **Reproducible Code**: Must include ARM templates, Bicep code, or scripts allowing another engineer to run it.
3. **Verification**: Include explicit instructions (queries, CLI commands, Portal views) to verify the deployment.
4. **Cleanup Method**: Include a cleanup script (e.g., `cleanup.ps1` or CLI command) to teardown resources.
5. **Zero Secrets**: Ensure no credentials, keys, tenant IDs, or subscription IDs are embedded in code or parameters.
6. **No Fabricated Data**: Only document actual results, configurations, and errors encountered.
7. **Troubleshooting Records**: If you hit a blocker or error, document the error message and the fix.
8. **Privacy Compliance**: All screenshots must be cropped and redacted to exclude email addresses, subscription IDs, browser tabs, or local folder structures.

---

# Lab XX — [Lab Title]

## Objective
A short statement describing what this lab accomplishes and the learning goal.

## Scenario
The operational problem, requirement, or scenario modeled by this lab (e.g., "Standardizing disk encryption across VMs in Dev environment").

## Skills Demonstrated
- Skill 1
- Skill 2
- Skill 3

## Architecture
An ASCII diagram showing the deployment flow or resource layout.
```text
[Local Machine] --> [Azure API Endpoint] --> [Resource Group] --> [Deployed Resources]
```

## Prerequisites
- Active Azure subscription.
- Installed tools (e.g., Azure PowerShell, Azure CLI, VS Code Azure tools).
- Authentication steps.

## Resources Created
| Resource | Type | Purpose |
|---|---|---|
| Resource Group | Microsoft.Resources/resourceGroups | Isolated deployment scope |
| Deployed Resource | Microsoft.Storage/storageAccounts | [Example Purpose] |

## Parameters
| Parameter | Type | Description | Default Value | Example Value |
|---|---|---|---|---|
| parameterName | string | Purpose of this parameter | Default | Example |

## Deployment
Steps to run the deployment, including script usage:
```powershell
# Example invocation
.\deploy.ps1 -ResourceGroupName "rg-name" -ParameterName "value"
```

## Validation
Instructions to verify that the resources are deployed and configured correctly.
- Verification Step 1
- Verification Step 2

## Troubleshooting
Document any real-world errors encountered during the lab and how they were resolved.
- **Error**: `[Error Code / Name]`
- **Cause**: Detailed explanation of why the deployment failed.
- **Resolution**: Steps taken to fix the issue.

## Security Notes
- Avoid committing secrets or credentials.
- Note any specific security measures implemented in the templates.

## Cleanup
Instructions to delete the resources created by this lab to avoid billing charges.
```powershell
.\cleanup.ps1 -ResourceGroupName "rg-name" -ConfirmDeletion
```

## Evidence
Link to the [Evidence Directory](./evidence/README.md).

## Lessons Learned
Brief takeaway points regarding design decisions, API limitations, or Azure features discovered during the lab.
