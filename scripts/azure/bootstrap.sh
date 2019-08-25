#!/bin/bash

set -aueo pipefail

# This assumes "az login" has been done already

source .env

az vm start \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME

IP=$(az vm show -d \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --query publicIps -o tsv)

echo "Init..."
# Give the VM time to start SSH etc.
for i in 1 2 3 4 5; do scp -oStrictHostKeyChecking=no .ssh/id_rsa* $AZURE_USER@$IP:.ssh/ && break || sleep 15; done
scp -oStrictHostKeyChecking=no ./scripts/azure/init.sh $AZURE_USER@$IP:
ssh -oStrictHostKeyChecking=no $AZURE_USER@$IP './init.sh'
