# Repository Guidelines

This document outlines the organization, contribution guidelines, privacy rules, and evidence standards for the `azure-operations-lab` repository.

## 1. Directory Structure

The repository is structured to separate re-usable scripts, core templates, and individual lab walk-throughs:

- `/docs/`: Global repository guidelines, study notes, or governance rules.
- `/labs/`: Multi-step Azure practice tasks.
  - `/labs/_template/`: A boilerplate folder containing files needed to bootstrap a new lab.
  - `/labs/XX-<lab-name>/`: A specific lab folder (e.g., `01-arm-parameterized-storage-account`).
- `/scripts/`: Cross-lab automation scripts.
  - `/scripts/powershell/`: Shared PowerShell functions or modules.
  - `/scripts/azure-cli/`: Shared Bash/Azure CLI utilities.

## 2. Lab Standards

Every lab included in this repository must meet the following four criteria:

1. **Reproducible**: Includes clear instructions, templates (ARM, Bicep, Terraform), and automation scripts (`deploy.ps1`/`deploy.sh`).
2. **Verifiable**: Provides specific validation steps (via Portal or Terminal queries) to prove deployment succeeded.
3. **Troubleshot**: Documents real errors encountered, their causes, and how they were resolved.
4. **Cleanable**: Provides a cleanup method (e.g., `cleanup.ps1`) to remove all provisioned resources and prevent billing leaks.

## 3. Privacy & Secrets Protection

> [!CAUTION]
> Never commit real secrets, personal identification, or subscription details.

Before submitting any files or committing changes, ensure that:
- **No Access Keys**: Do not commit storage account access keys, connection strings, or SAS tokens.
- **No Identity Information**: Do not include Tenant IDs, Subscription IDs, email addresses, or real-world usernames.
- **Example Files Only**: Parameter files (`parameters.example.json`) must contain only generic placeholders.
- **Interactive Login**: Login states (`Connect-AzAccount` or `az login`) must never be hardcoded or cached.

## 4. Screenshot and Terminal Evidence Policy

To document validation while maintaining privacy, follow these cropping rules:

- **Browser Content Only**: Portal screenshots must be tightly cropped to the main content panel. Do *not* include the browser address bar, bookmark bar, open tabs, or top-right profile settings (which show login emails/directories).
- **Sanitized Terminal**: Terminal outputs must only display command output and parameters. Crop out local machine prompts showing the Windows username, home path, or domain name.
- **Placeholder Replacements**: Use text boxes or blurring to redact resource group names if they contain sensitive or internal naming conventions, though lab resource groups (e.g., `rg-arm-template-lab`) are safe to display.
