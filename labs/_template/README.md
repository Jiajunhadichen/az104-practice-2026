# Lab XX — [Lab Title]

## Objective
A short statement describing what this lab accomplishes and the learning goal.

## Scenario
The operational problem, requirement, or scenario modeled by this lab.

## Skills Demonstrated
- Skill 1
- Skill 2

## Architecture
An ASCII diagram showing the deployment flow or resource layout.
```text
[Local Machine] --> [Azure API Endpoint] --> [Resource Group] --> [Deployed Resources]
```

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
