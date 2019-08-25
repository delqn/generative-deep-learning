#!/bin/bash

set -aueo pipefail

# az login

source .env

az vm start \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME

IP=$(az vm show -d \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --query publicIps -o tsv)

echo "VM $IP is up"
