#!/usr/bin/env python3

from keras.layers import Input, Flatten, Dense
from keras.models import Model, Sequential

def get_model_sequential():
    model = Sequential([
        Dense(200, activation='relu', input_shape=(32, 32, 3)),
        Flatten(),
        Dense(150, activation='relu'),
        Dense(10, activation='softmax'),
    ])

    return model


def get_model():
    input_layer = Input(shape=(32, 32, 3))

    x = Flatten()(input_layer)

    x = Dense(units=200, activation='relu')(x)
    x = Dense(units=150, activation='relu')(x)

    output_layer = Dense(units=10, activation='softmax')(x)

    model = Model(input_layer, output_layer)

    return model
