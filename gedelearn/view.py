#!/usr/bin/env python3

from absl import logging
logging._warn_preinit_stderr = 0

import numpy as np
import matplotlib.pyplot as plt

from .load_data import *
from .model import model

CLASSES = np.array([
    'airplane',
    'automobile',
    'bird',
    'cat',
    'deer',
    'dog',
    'frog',
    'horse',
    'ship',
    'truck'
])

def show():
    preds = model.predict(x_test)
    preds_single = CLASSES[np.argmax(preds, axis=-1)]
    actual_single = CLASSES[np.argmax(y_test, axis=-1)]

    n_to_show = 10
    indices = np.random.choice(range(len(x_test)), n_to_show)

    fig = plt.figure(figsize=(15, 3))
    fig.subplots_adjust(hspace=0.4, wspace=0.4)

    for i, idx in enumerate(indices):
        img = x_test[idx]
        ax = fig.add_subplot(1, n_to_show, i+1)
        ax.axis('off')
        ax.text(0.5, -0.35, 'pred = ' + str(preds_single[idx]), fontsize=10, ha='center', transform=ax.transAxes)
        ax.text(0.5, -0.7, 'act = ' + str(actual_single[idx]), fontsize=10, ha='center',transform=ax.transAxes)
        ax.imshow(img)
