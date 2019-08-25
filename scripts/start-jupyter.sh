#!/bin/bash

source generative/bin/activate
python3 -m ipykernel install --user --name generative
jupyter notebook
