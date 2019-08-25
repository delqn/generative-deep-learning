# Generative Deep Learning Experiments

This repository contains generative deep learning experiments using [Azure NV GPU VMs](Standard NV12_Promo (12 vcpus, 112 GiB memory))

# Using this
  - Train locally: `make train`
  - Train in Azure: `make azure-train`
  - Deallocate the VM as soon as training is done: `make azure-deallocate`
  - Start jupyter: `source ./generative/bin/activate && jupyter notebook`
  - [Jupyter Notebook](http://localhost:8888/notebooks/compile-train-test.ipynb)

### Resources
 - [Save Keras Model to Disk](https://machinelearningmastery.com/save-load-keras-deep-learning-models/)
