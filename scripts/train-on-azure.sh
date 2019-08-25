#!/bin/bash

set -auexo pipefail

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

echo "Init..."
scp -oStrictHostKeyChecking=no .ssh/id_rsa* $AZURE_USER@$IP:.ssh/
scp ./scripts/init.sh $AZURE_USER@$IP:
ssh $AZURE_USER@$IP './init.sh'

echo "Train..."
ssh $AZURE_USER@$IP "cd src/generative-deep-learning && git pull --rebase origin master && make train && git commit -m 'new model' -a && git push origin master"

echo "Stop the VM..."
echo az vm stop \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME

echo "Deallocating VM..."
echo az vm deallocate \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME
