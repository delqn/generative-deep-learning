#!/bin/bash

sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install git make emacs25-nox
mkdir -p /home/$AZURE_USER/src
cd src
ssh-keyscan -H github.com >> ~/.ssh/known_hosts
git clone git@github.com:delqn/generative-deep-learning.git || true
cd /home/$AZURE_USER/src/generative-deep-learning
pip3 install virtualenv
virtualenv generative
source generative/bin/activate
make prereqs
