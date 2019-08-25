#!/bin/bash

## This assumes you have done:
# az login

source .env

IP=$(az vm show -d \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --query publicIps -o tsv)


scp -oStrictHostKeyChecking=no .ssh/id_rsa* $AZURE_USER@$IP:.ssh/
ssh $AZURE_USER@$IP "sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install git make && mkdir -p /home/$AZURE_USER/src && cd src && ssh-keyscan -H github.com >> ~/.ssh/known_hosts && git clone git@github.com:delqn/generative-deep-learning.git && cd /home/$AZURE_USER/src/generative-deep-learning && make prereqs"
ssh -oStrictHostKeyChecking=no $AZURE_USER@$IP
