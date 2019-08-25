#!/bin/bash

rm -rf $HOME/src/generative-deep-learning
pushd $HOME/src
git clone git@github.com:delqn/generative-deep-learning.git
cd ./generative-deep-learning
git pull --rebase origin master
export LD_LIBRARY_PATH=/usr/local/cuda/lib64/:/usr/lib/x86_64-linux-gnu/:$LD_LIBRARY_PATH
make train
git commit -m 'Newly trained model' model.*
git push origin master
