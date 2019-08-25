#!/bin/bash

# CUDNN
wget https://developer.download.nvidia.com/compute/redist/cudnn/v7.4.2/cudnn-10.0-linux-x64-v7.4.2.24.tgz
tar -xvf cudnn-10.0-linux-x64-v7.4.2.24.tgz
cp include/cudnn.h /usr/local/cuda-10.0/include/cudnn.h
cp lib64/libcudnn.so.7.4.2 /usr/local/cuda-10.0/lib64/libcudnn.so.7.4.2
sudo ln -s /usr/local/cuda-10.0/lib64/libcudnn.so.7.4.2 /usr/local/cuda-10.0/lib64/libcudnn.so.7
sudo ln -s /usr/local/cuda-10.0/lib64/libcudnn.so.7 /usr/local/cuda-10.0/lib64/libcudnn.so
