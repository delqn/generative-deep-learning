#!/bin/bash

set -auexo pipefail

# az login

source .env

#    --no-wait
az vm start \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME

IP=$(az vm show -d \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --query publicIps -o tsv)

scp -oStrictHostKeyChecking=no .ssh/id_rsa* $AZURE_USER@$IP:.ssh/
scp ./scripts/trainer-init.sh $AZURE_USER@$IP:
# ssh $AZURE_USER@$IP './trainer-init.sh'
ssh -oStrictHostKeyChecking=no $AZURE_USER@$IP "cd src/generative-deep-learning && git pull --rebase origin master && make train && git commit -m 'new model' -a && git push origin master"

echo az vm stop \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --no-wait

echo "Deallocating VM..."
echo az vm deallocate \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --no-wait
