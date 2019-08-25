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

echo "Train..."
ssh $AZURE_USER@$IP "cd src/generative-deep-learning && git pull --rebase origin master && make train && git commit -m 'new model' -a && git push origin master"
