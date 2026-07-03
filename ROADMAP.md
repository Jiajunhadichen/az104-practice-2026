# AZ-104 Learning Roadmap

This roadmap outlines a structured, hands-on path over approximately three months to demonstrate proficiency in Azure administration, automation, and Infrastructure as Code (IaC). 

All future goals are marked as **[Planned]** and will only be marked as **[Completed]** once the respective lab has been fully deployed, verified, and pushed with real-world artifacts.

---

## Phase 1 — Infrastructure as Code and Governance

Focuses on resource provisioning consistency, access control, and organizational compliance.

- **[Completed]** **Lab 01 — Parameterized Azure Storage Account with ARM Templates**
  - Provisioning a parameterized Storage Account.
  - Using validation lists (`allowedValues`) and returning endpoints via deployment outputs.
  - Setting up localized PowerShell deployment and cleanup logic.
- **[Planned]** **Bicep Migration and Conversion**
  - Migrating the storage ARM JSON template to Bicep.
  - Decompiling, cleaning, and optimizing syntax.
- **[Planned]** **Resource Tagging and Locks**
  - Automating the application of tags (e.g., Environment, Owner, CostCenter) to prevent resource leaks.
  - Applying read-only and delete resource locks on production-ready resource groups.
- **[Planned]** **Azure Policy Guardrails**
  - Implementing custom Azure Policies to restrict allowed VM SKUs or allowed storage redundancy types.
  - Remediating non-compliant resources.
- **[Planned]** **RBAC and Identity Least Privilege**
  - Creating custom RBAC roles and assigning them to service accounts or users with minimal privileges.

---

## Phase 2 — Compute, Network, Storage, and Monitoring

Focuses on core administrative duties, troubleshooting, network configurations, and monitoring setups.

- **[Planned]** **VNet, Subnets, and Network Security Groups (NSGs)**
  - Setting up multi-subnet VNets with custom route tables.
  - NSG rule configuration and troubleshooting connectivity issues.
- **[Planned]** **Virtual Machine Deployments and Scale Sets**
  - Deploying VMs using automated scripts and configuring customized extensions.
  - Managing high availability via Virtual Machine Scale Sets (VMSS).
- **[Planned]** **Azure Storage Governance and Access Control**
  - Configuring Shared Access Signatures (SAS) with expiration policies and IP constraints.
  - Implementing lifecycle management policies for blob storage tiers.
- **[Planned]** **Azure Monitor, Log Analytics, and Alerts**
  - Provisioning Log Analytics Workspaces.
  - Writing KQL (Kusto Query Language) queries to audit administrative logs.
  - Creating alerts triggered by threshold actions.
- **[Planned]** **Backup and Recovery Vaults**
  - Designing backup schedules and recovery policies for virtual machines and storage assets.

---

## Phase 3 — Automation and Portfolio Integration

Focuses on advanced scripting, CI/CD integrations, and enterprise deployment methodologies.

- **[Planned]** **Modular Bicep Deployments**
  - Composing multi-tier environments (VNet + VM + Storage) utilizing Bicep modules.
- **[Planned]** **Azure CLI and PowerShell Advanced Automation**
  - Developing reusable operational runbooks for daily maintenance tasks.
- **[Planned]** **GitHub Actions CI/CD Integration**
  - Creating GitHub Actions workflows to validate Bicep files on push using linting and what-if operations.
- **[Planned]** **What-If Deployment Previews**
  - Introducing pre-flight validation processes to inspect environment changes before execution.
- **[Planned]** **Cost Governance and Cleanup Automation**
  - Budgeting setups and scheduled cleanup tasks to keep lab expenditures at zero.
