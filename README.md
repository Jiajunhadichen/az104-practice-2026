# Azure Operations Lab

A hands-on Azure administration and infrastructure-as-code portfolio built while preparing for the AZ-104 certification.

## Scope & Design Philosophy

- **AZ-104 Focus**: This repository begins directly with the AZ-104 learning phase. Fundamental/introductory exercises from the AZ-900 level are intentionally excluded.
- **Operational Reality**: Every lab in this repository represents a real deployment completed on a live Azure environment. There are no simulated or fabricated deployments.
- **Quality Standards**: Each laboratory is designed with five key focuses:
  1. **Reproducibility**: Clear automated scripts and templates.
  2. **Validation**: Explicit steps to check and verify the deployment state.
  3. **Troubleshooting**: Honest documentation of real-world errors and their corresponding fixes.
  4. **Security Awareness**: Mandatory sanitization of credentials, secrets, and identity information.
  5. **Cost Cleanup**: Dedicated cleanup routines to ensure zero cost footprint.

---

## Technical Skills Showcase

- **Infrastructure as Code (IaC)**: ARM Templates (JSON), Bicep **[Learning Area]**
- **Automation**: Azure PowerShell (Az Module), Azure CLI
- **Identity & Access**: RBAC Role Assignments, Azure AD/Entra ID User/Group Management **[Learning Area]**
- **Governance**: Azure Resource Tags, Resource Locks, Azure Policy **[Learning Area]**
- **Storage**: Storage Account Configurations, Lifecycle Management, SAS Tokens
- **Core Networking**: Virtual Networks (VNets), Subnets, Route Tables, Network Security Groups (NSGs) **[Learning Area]**
- **Compute**: Virtual Machines, VMSS, Custom Extensions **[Learning Area]**
- **Monitoring**: Azure Monitor, Log Analytics, KQL Queries, Alerts **[Learning Area]**
- **CI/CD**: GitHub Actions workflows for template linting and validation **[Future Roadmap]**

---

## Lab Portfolio Index

| Lab ID | Topic | Key Skills Demonstrated | Status |
|---|---|---|---|
| [Lab 01](./labs/01-arm-parameterized-storage-account/) | Parameterized Storage Account with ARM | ARM JSON templates, parameter constraints, allowed values, deployment outputs, PowerShell automation | **Completed** |

---

## Getting Started

1. Read the global [Repository Guidelines](./docs/repository-guidelines.md) to understand structure, security, and screenshot standards.
2. Review the [Roadmap](./ROADMAP.md) to see planned laboratory content.
3. To replicate any lab, navigate to its directory under `labs/` and follow the instructions in its respective `README.md`.
