#!/bin/bash

## This assumes you have done:
# az login

source .env

IP=$(az vm show -d \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --query publicIps -o tsv)


scp -oStrictHostKeyChecking=no .ssh/id_rsa* $AZURE_USER@$IP:.ssh/
scp ./init.sh $AZURE_USER@$IP:
ssh $AZURE_USER@$IP 'init.sh'
ssh -oStrictHostKeyChecking=no $AZURE_USER@$IP "cd src/generative-deep-learning && git pull --rebase origin master && make train-sequential && git commit -m 'new model' -a && git push origin master"

ssh -oStrictHostKeyChecking=no $AZURE_USER@$IP
