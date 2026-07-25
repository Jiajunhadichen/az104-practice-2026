# Implementation Steps

This document details the step-by-step procedure for deploying, configuring, and verifying the resilient public website host on Azure Blob Storage.

---

## Step 1: Provision the Resource Group and Storage Account

1. Create a Resource Group named `rg-publicwebsite-lab` in the **Sweden Central** region.
2. Provision a Standard general-purpose v2 storage account using **Read-access geo-redundant storage (RA-GRS)** redundancy.

### CLI Reference
```bash
# Create Resource Group
az group create --name rg-publicwebsite-lab --location swedencentral

# Create Storage Account with RA-GRS
az storage account create \
  --name stpublicwebsitelab \
  --resource-group rg-publicwebsite-lab \
  --location swedencentral \
  --sku Standard_RAGRS \
  --kind StorageV2 \
  --allow-blob-public-access true
```

*Expected Verification*:
- The storage account is successfully provisioned.
- Redundancy is set to RA-GRS (providing cross-region read access to secondary replica).
- Account-level setting `allowBlobPublicAccess` is set to `true`.

![Storage Account Created](../screenshots/01-storage-account-created.png)
![RA-GRS Redundancy Enabled](../screenshots/02-ra-grs-enabled.png)

---

## Step 2: Enable Anonymous Blob Access and Configure the Container

1. In the storage account's **Configuration** blade under the Azure Portal, verify **Allow Blob anonymous access** is enabled (set to Enabled).
2. Go to **Containers** under the Data storage menu.
3. Create a new container named `public`.
4. Set the **Anonymous access level** for the container to **Blob (anonymous read access for blobs only)**. This ensures that while individual blobs are accessible via direct URL, listing the container's blobs anonymously is blocked.

![Anonymous Access Enabled](../screenshots/03-anonymous-access-enabled.png)
![Public Container Configured](../screenshots/04-public-container.png)

---

## Step 3: Configure Resiliency and Data Protection Settings

Enable features to protect against accidental deletion and overwrite:

1. Navigate to **Data protection** under the Data management menu.
2. Under **Recovery**, configure the following:
   - Enable **soft delete for blobs** and set the retention period to **21 days**.
   - Enable **soft delete for containers** and set the retention period to **21 days**.
   - Enable **tracking/versioning** by checking **Enable blob versioning**.

### CLI Reference
```bash
az storage account blob-service-properties update \
  --account-name stpublicwebsitelab \
  --resource-group rg-publicwebsite-lab \
  --enable-delete-retention true \
  --delete-retention-days 21 \
  --enable-container-delete-retention true \
  --container-delete-retention-days 21 \
  --enable-versioning true
```

![Data Protection Settings](../screenshots/06-data-protection-settings.png)

---

## Step 4: Perform Public Access and Versioning Operations

Refer to [validation.md](./validation.md) for verification procedures and how version restoration operations were executed.
