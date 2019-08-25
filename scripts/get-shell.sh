#!/bin/bash

## This assumes you have done:
# az login

source .env

IP=$(az vm show -d \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --query publicIps -o tsv)


scp -oStrictHostKeyChecking=no .ssh/id_rsa* $AZURE_USER@$IP:.ssh/
scp -oStrictHostKeyChecking=no ~/.gitconfig $AZURE_USER@$IP:
scp ./scripts/trainer-init.sh $AZURE_USER@$IP:
# ssh $AZURE_USER@$IP './trainer-init.sh'
ssh -oStrictHostKeyChecking=no $AZURE_USER@$IP
