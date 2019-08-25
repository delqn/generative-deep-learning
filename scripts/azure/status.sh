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


echo "Getting power state of VM..."
PWRSTATE=$(az vm show -d \
	--resource-group $AZURE_RESOURCEGRP \
	--name $AZURE_VMNAME \
	--query powerState -o tsv)

echo "VM's Power State is $PWRSTATE"
