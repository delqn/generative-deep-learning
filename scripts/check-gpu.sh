#!/usr/bin/env python3

# print('Tensorflow:')
# from tensorflow.python.client import device_lib
# print(device_lib.list_local_devices())

print('Keras:')
from keras import backend as K
K.tensorflow_backend._get_available_gpus()
