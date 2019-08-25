#!/usr/bin/env python3

from .model import get_model_sequential, get_model
from .load_data import x_train, y_train

def train(mdl):
    mdl.fit(
        x_train,
        y_train,
        batch_size=32,
        epochs=10,
        shuffle=True)
