#!/bin/bash

set -aueo pipefail

sudo DEBIAN_FRONTEND=noninteractive apt-get -yq install git make emacs25-nox mg
ssh-keyscan -H github.com >> ~/.ssh/known_hosts

echo "Install NVidia drivers"
CUDA_REPO_PKG=cuda-repo-ubuntu1604_10.0.130-1_amd64.deb
wget -q -O /tmp/${CUDA_REPO_PKG} http://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/${CUDA_REPO_PKG}
sudo dpkg -i /tmp/${CUDA_REPO_PKG}
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu1604/x86_64/7fa2af80.pub
rm -f /tmp/${CUDA_REPO_PKG}

## This should not be needed - but we've seen package conflicts
# sudo apt-get -yq -o Dpkg::Options::="--force-overwrite" install --fix-broken

sudo apt-get -yq update
sudo apt-get -yq install cuda-drivers cuda-driver-dev-10-0 cuda-10-0

echo "Install CudaNN"
CUDADIR=$(mktemp -d)
CUDATGZ="cudnn-10.0-linux-x64-v7.4.2.24.tgz"
wget -q "https://developer.download.nvidia.com/compute/redist/cudnn/v7.4.2/$CUDATGZ"

tar -xvf "$CUDATGZ" -C "$CUDADIR"

sudo cp "$CUDADIR/cuda/include/cudnn.h" /usr/local/cuda-10.0/include/cudnn.h
sudo cp "$CUDADIR/cuda/lib64/libcudnn.so.7.4.2" /usr/local/cuda-10.0/lib64/libcudnn.so.7.4.2

sudo rm -rf /usr/local/cuda-10.0/lib64/libcudnn.so.7
sudo rm -rf /usr/local/cuda-10.0/lib64/libcudnn.so

sudo ln -s /usr/local/cuda-10.0/lib64/libcudnn.so.7.4.2 /usr/local/cuda-10.0/lib64/libcudnn.so.7
sudo ln -s /usr/local/cuda-10.0/lib64/libcudnn.so.7 /usr/local/cuda-10.0/lib64/libcudnn.so

rm -rf $CUDATGZ
rm -rf $CUDADIR


echo "Clone the repo"
mkdir -p ~/src
cd ~/src
git clone git@github.com:delqn/generative-deep-learning.git || true
cd ~/src/generative-deep-learning
pip3 install virtualenv


# Git LFS
sudo apt-get install git-lfs
git lfs install
git lfs track model.h5
git lfs track model.json
