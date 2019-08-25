#!/usr/bin/env python3

from .model import model
from .load_data import x_train, y_train

def train():
    model.fit(x_train, y_train, batch_size=32, epochs=10, shuffle=True)
