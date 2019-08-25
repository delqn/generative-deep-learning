#!/bin/bash

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

scp .ssh/id_rsa* $AZURE_USER@$IP:.ssh/

ssh $AZURE_USER@$IP "sudo apt-get install git make && mkdir -p /home/$AZURE_USER/src && git clone git@github.com:delqn/generative-deep-learning.git && cd /home/$AZURE_USER/src/generative-deep-learning && make train && git commit -m 'new model' -a && git push origin master"

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
