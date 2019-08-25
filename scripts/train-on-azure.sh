#!/bin/bash

# az login

source .env
az vm start \
   --subscription $AZURE_SUBSCR \
   --resource-group $AZURE_RESOURCEGRP \
   --name $AZURE_VMNAME \
   --no-wait
