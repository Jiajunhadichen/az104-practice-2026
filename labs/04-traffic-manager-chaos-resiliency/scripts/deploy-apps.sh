#!/usr/bin/env bash
set -euo pipefail

# Replace these values before running.
PRIMARY_REGION="swedencentral"
BACKUP_REGION="canadacentral"
PRIMARY_RG="rg-resiliency-primary"
BACKUP_RG="rg-resiliency-backup"
PRIMARY_PLAN="asp-resiliency-primary"
BACKUP_PLAN="asp-resiliency-backup"
PRIMARY_APP="replace-with-globally-unique-primary-name"
BACKUP_APP="replace-with-globally-unique-backup-name"
RUNTIME="NODE:24-lts"
SKU="S1"

az group create --name "$PRIMARY_RG" --location "$PRIMARY_REGION" --output none
az group create --name "$BACKUP_RG" --location "$BACKUP_REGION" --output none

az appservice plan create \
  --name "$PRIMARY_PLAN" \
  --resource-group "$PRIMARY_RG" \
  --location "$PRIMARY_REGION" \
  --sku "$SKU" \
  --is-linux \
  --output none

az appservice plan create \
  --name "$BACKUP_PLAN" \
  --resource-group "$BACKUP_RG" \
  --location "$BACKUP_REGION" \
  --sku "$SKU" \
  --is-linux \
  --output none

az webapp create \
  --name "$PRIMARY_APP" \
  --resource-group "$PRIMARY_RG" \
  --plan "$PRIMARY_PLAN" \
  --runtime "$RUNTIME" \
  --output none

az webapp create \
  --name "$BACKUP_APP" \
  --resource-group "$BACKUP_RG" \
  --plan "$BACKUP_PLAN" \
  --runtime "$RUNTIME" \
  --output none

echo "App Services created. Deploy application packages and expose a /health endpoint returning HTTP 200."
