#!/usr/bin/env python3

from keras.layers import Input, Flatten, Dense
from keras.models import Model, Sequential
from keras.models import model_from_json

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
