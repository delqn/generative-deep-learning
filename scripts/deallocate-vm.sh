#!/bin/bash

set -aueo pipefail

# az login

source .env

#    --no-wait
echo az vm stop \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME

#    --no-wait
echo "Deallocating VM..."
echo az vm deallocate \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME
