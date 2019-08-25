#!/bin/bash

set -aueo pipefail

## This assumes you have done:
# az login

source .env

echo "Getting IP of VM..."
IP=$(az vm show -d \
	--resource-group $AZURE_RESOURCEGRP \
	--name $AZURE_VMNAME \
	--query publicIps -o tsv)

echo "VM IP is $IP"

echo "Copy keys for GitHub integration..."
scp -oStrictHostKeyChecking=no .ssh/id_rsa* $AZURE_USER@$IP:.ssh/

echo "Copy GitHub config..."
scp -oStrictHostKeyChecking=no ~/.gitconfig $AZURE_USER@$IP:

echo "Copy Init script..."
scp ./scripts/azure/init.sh $AZURE_USER@$IP:

echo "Shell into it..."
ssh -oStrictHostKeyChecking=no $AZURE_USER@$IP
