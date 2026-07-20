#!/usr/bin/env bash
set -euo pipefail

TM_RG="rg-resiliency-control"
TM_LOCATION="swedencentral"
TM_PROFILE="replace-with-globally-unique-traffic-manager-name"

PRIMARY_RG="rg-resiliency-primary"
BACKUP_RG="rg-resiliency-backup"
PRIMARY_APP="replace-with-primary-app-name"
BACKUP_APP="replace-with-backup-app-name"

az group create --name "$TM_RG" --location "$TM_LOCATION" --output none

az network traffic-manager profile create \
  --name "$TM_PROFILE" \
  --resource-group "$TM_RG" \
  --routing-method Priority \
  --unique-dns-name "$TM_PROFILE" \
  --ttl 5 \
  --protocol HTTPS \
  --port 443 \
  --path "/health" \
  --interval 30 \
  --timeout 10 \
  --max-failures 3 \
  --output none

PRIMARY_ID=$(az webapp show --name "$PRIMARY_APP" --resource-group "$PRIMARY_RG" --query id --output tsv)
BACKUP_ID=$(az webapp show --name "$BACKUP_APP" --resource-group "$BACKUP_RG" --query id --output tsv)

az network traffic-manager endpoint create \
  --name primary-endpoint \
  --resource-group "$TM_RG" \
  --profile-name "$TM_PROFILE" \
  --type azureEndpoints \
  --target-resource-id "$PRIMARY_ID" \
  --priority 1 \
  --endpoint-status Enabled \
  --output none

az network traffic-manager endpoint create \
  --name backup-endpoint \
  --resource-group "$TM_RG" \
  --profile-name "$TM_PROFILE" \
  --type azureEndpoints \
  --target-resource-id "$BACKUP_ID" \
  --priority 2 \
  --endpoint-status Enabled \
  --output none

az network traffic-manager endpoint list \
  --resource-group "$TM_RG" \
  --profile-name "$TM_PROFILE" \
  --query "[].{Endpoint:name,Priority:priority,Monitor:endpointMonitorStatus,Target:target}" \
  --output table
