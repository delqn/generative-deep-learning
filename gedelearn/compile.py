#!/usr/bin/env python3

from keras.optimizers import Adam

from .model import model

def compile():
    model.compile(
        loss='categorical_crossentropy',
        optimizer=Adam(lr=0.0005),
        metrics=['accuracy'],
    )
