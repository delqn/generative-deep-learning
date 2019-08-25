#!/usr/bin/env python3

from keras.optimizers import Adam
from model import model

opt = Adam(lr=0.0005)
model.compile(loss='categorical_crossentropy', optimizer=opt, metrics=['accuracy'])

print("x"*90)
