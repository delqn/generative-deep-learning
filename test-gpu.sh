#!/bin/bash


lspci | grep -i NVIDIA

nvidia-smi

pip3 install tensorflow-gpu==1.14.0 Keras==2.2.5
wget https://raw.githubusercontent.com/fchollet/keras/master/examples/mnist_mlp.py
python3 mnist_mlp.py

