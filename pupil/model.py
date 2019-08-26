#!/usr/bin/env python3

from keras.layers import (
    Input,
    Flatten,
    Dense,
    Conv2D,
    BatchNormalization,
    LeakyReLU,
    Dropout,
    Activation,
)
from keras.models import Model, Sequential
from keras.models import model_from_json

from .const import NUM_CLASSES

def get_model_sequential():
    model = Sequential([
        Dense(200, activation='relu', input_shape=(32, 32, 3)),
        Flatten(),
        Dense(150, activation='relu'),
        Dense(10, activation='softmax'),
    ])
    model.summary()
    return model


def get_model_0():
    input_layer = Input(shape=(32, 32, 3))
    layers = Flatten()(input_layer)
    layers = Dense(units=200, activation='relu')(layers)
    layers = Dense(units=150, activation='relu')(layers)
    output_layer = Dense(units=10, activation='softmax')(layers)
    model = Model(input_layer, output_layer)
    model.summary()
    return model

def b_a(layer):
    return LeakyReLU()(BatchNormalization()(layer))

def get_model():
    input_layer = Input(shape=(32, 32, 3))
    cl1 = b_a(Conv2D(filters=32, kernel_size=3, strides=1, padding='same')(input_layer))
    cl2 = b_a(Conv2D(filters=32, kernel_size=3, strides=2, padding='same')(cl1))
    cl3 = b_a(Conv2D(filters=64, kernel_size=3, strides=2, padding='same')(cl2))
    cl4 = b_a(Conv2D(filters=64, kernel_size=3, strides=2, padding='same')(cl3))

    flatten_layer = Flatten()(cl4)

    dl1 = b_a(Dense(128)(flatten_layer))

    do = Dropout(rate=0.5)(dl1)

    dl2 = Dense(NUM_CLASSES)(do)
    output_layer = Activation('softmax')(dl2)

    model = Model(input_layer, output_layer)

    model.summary()
    return model


def load():
    # Source: https://machinelearningmastery.com/save-load-keras-deep-learning-models/
    # load json and create model
    with open('model.json', 'r') as json_file:
        loaded_model_json = json_file.read()

    loaded_model = model_from_json(loaded_model_json)
    # load weights into new model
    loaded_model.load_weights("model.h5")
    print("Loaded model from disk")
    return loaded_model
