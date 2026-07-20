#!/usr/bin/env bash
set -euo pipefail

TM_RG="rg-resiliency-control"
TM_PROFILE="replace-with-traffic-manager-name"
TM_DNS="${TM_PROFILE}.trafficmanager.net"

echo "Endpoint state:"
az network traffic-manager endpoint list \
  --resource-group "$TM_RG" \
  --profile-name "$TM_PROFILE" \
  --query "[].{Endpoint:name,Priority:priority,Monitor:endpointMonitorStatus,Target:target}" \
  --output table

echo
echo "DNS resolution:"
nslookup "$TM_DNS"

echo
echo "Application identity:"
curl -sL --max-time 30 "http://${TM_DNS}" | grep -E "PRIMARY|BACKUP"
