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

echo "VM's IP: $IP"

echo "Copy train script..."
for i in 1 2 3 4 5; do scp -oStrictHostKeyChecking=no ./scripts/azure/remote-train.sh $AZURE_USER@$IP: && break || sleep 15; done

echo "Train..."
ssh -oStrictHostKeyChecking=no "$AZURE_USER@$IP" "./remote-train.sh"
