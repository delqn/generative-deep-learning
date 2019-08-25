#!/bin/bash

set -aueo pipefail

CUDADIR=$(mktemp -d)
CUDATGZ="cudnn-10.0-linux-x64-v7.4.2.24.tgz"
# CUDNN
wget "https://developer.download.nvidia.com/compute/redist/cudnn/v7.4.2/$CUDATGZ"

tar -xvf "$CUDATGZ" -C "$CUDADIR"

sudo cp "$CUDADIR/cuda/include/cudnn.h" /usr/local/cuda-10.0/include/cudnn.h
sudo cp "$CUDADIR/cuda/lib64/libcudnn.so.7.4.2" /usr/local/cuda-10.0/lib64/libcudnn.so.7.4.2

sudo rm -rf /usr/local/cuda-10.0/lib64/libcudnn.so.7
sudo rm -rf /usr/local/cuda-10.0/lib64/libcudnn.so

sudo ln -s /usr/local/cuda-10.0/lib64/libcudnn.so.7.4.2 /usr/local/cuda-10.0/lib64/libcudnn.so.7
sudo ln -s /usr/local/cuda-10.0/lib64/libcudnn.so.7 /usr/local/cuda-10.0/lib64/libcudnn.so

rm -rf $CUDATGZ
rm -rf $CUDADIR
