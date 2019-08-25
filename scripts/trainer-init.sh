#!/bin/bash

set -auexo pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install git make emacs25-nox
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

sudo apt-get -yq -o Dpkg::Options::="--force-overwrite" install --fix-broken

## Install NVidia drivers
CUDA_REPO_PKG=cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
wget -O /tmp/${CUDA_REPO_PKG} http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/${CUDA_REPO_PKG}
sudo dpkg -i /tmp/${CUDA_REPO_PKG}
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
rm -f /tmp/${CUDA_REPO_PKG}

sudo apt-get -yq -o Dpkg::Options::="--force-overwrite" install --fix-broken

sudo apt-get -yq update
sudo apt-get -yq install cuda-drivers cuda


mkdir -p ~/src
cd ~/src
git clone git@github.com:delqn/generative-deep-learning.git || true
cd ~/src/generative-deep-learning
pip3 install virtualenv
virtualenv generative
source generative/bin/activate
make prereqs
