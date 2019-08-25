#!/bin/bash

rm -rf $HOME/src/generative-deep-learning
pushd $HOME/src
git clone git@github.com:delqn/generative-deep-learning.git
git pull --rebase origin master
make train
git commit -m 'Newly trained model' model.*
git push origin master
