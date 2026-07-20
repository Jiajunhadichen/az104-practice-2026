#!/usr/bin/env bash
set -euo pipefail

CONTROL_RG="rg-resiliency-control"
PRIMARY_RG="rg-resiliency-primary"
BACKUP_RG="rg-resiliency-backup"

az group delete --name "$CONTROL_RG" --yes --no-wait
az group delete --name "$PRIMARY_RG" --yes --no-wait
az group delete --name "$BACKUP_RG" --yes --no-wait

echo "Deletion requests submitted."
