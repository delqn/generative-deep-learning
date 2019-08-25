#!/bin/bash

set -aueo pipefail

# This assumes "az login" has been done already

source .env

echo "Start the VM"
az vm start \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME

echo "Get the IP address of the VM"
IP=$(az vm show -d \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --query publicIps -o tsv)

echo "Copy train script..."
scp -oStrictHostKeyChecking=no ./scripts/azure/remote-train.sh $AZURE_USER@$IP:

echo "Train..."
ssh -oStrictHostKeyChecking=no "$AZURE_USER@$IP" "remote-train.sh"
