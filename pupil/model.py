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
    return Sequential([
        Dense(200, activation='relu', input_shape=(32, 32, 3)),
        Flatten(),
        Dense(150, activation='relu'),
        Dense(10, activation='softmax'),
    ])


def get_model_0():
    input_layer = Input(shape=(32, 32, 3))
    layers = Flatten()(input_layer)
    layers = Dense(units=200, activation='relu')(layers)
    layers = Dense(units=150, activation='relu')(layers)
    output_layer = Dense(units=10, activation='softmax')(layers)
    return Model(input_layer, output_layer)

def get_model():
    input_layer = Input(shape=(32, 32, 3))

    cl1 = Conv2D(filters=32, kernel_size=3, strides=1, padding='same')(input_layer)
    batch_normalized_1 = BatchNormalization()(cl1)
    first = LeakyReLU()(batch_normalized_1)

    cl2 = Conv2D(filters=32, kernel_size=3, strides=2, padding='same')(first)
    bn2 = BatchNormalization()(cl2)
    second = LeakyReLU()(bn2)

    cl3 = Conv2D(filters=64, kernel_size=3, strides=2, padding='same')(first)
    bn3 = BatchNormalization()(cl3)
    third = LeakyReLU()(bn3)

    cl4 = Conv2D(filters=64, kernel_size=3, strides=2, padding='same')(first)
    bn4 = BatchNormalization()(cl4)
    fourth = LeakyReLU()(bn4)

    flatten_layer = Flatten()(fourth)

    dl5 = Dense(128)(flatten_layer)
    bn5 = BatchNormalization()(dl5)
    fifth = LeakyReLU()(bn5)
    do = Dropout(rate=0.5)(fifth)

    dl6 = Dense(NUM_CLASSES)(do)
    output_layer = Activation('softmax')(dl6)
    return Model(input_layer, output_layer)


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
