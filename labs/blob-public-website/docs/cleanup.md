# Cleanup Guide

To prevent ongoing charges, remove all resources created for this lab once validation is complete. 

## Automated Cleanup (Azure CLI)

Run the following command in your terminal to delete the resource group and all contained resources:

```bash
az group delete --name rg-publicwebsite-lab --yes --no-wait
```

## Manual Cleanup (Azure Portal)

1. Open the [Azure Portal](https://portal.azure.com).
2. Navigate to **Resource Groups** and select `rg-publicwebsite-lab`.
3. Click **Delete resource group**.
4. Enter the resource group name `rg-publicwebsite-lab` to confirm.
5. Click **Delete** to initiate the teardown.
