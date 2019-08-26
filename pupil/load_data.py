from keras.utils import to_categorical
from keras.datasets import cifar10

from .const import NUM_CLASSES

def get_train_data():
    (x_train, y_train), (_, _) = cifar10.load_data()
    x_train = x_train.astype('float32') / 255.0
    y_train = to_categorical(y_train, NUM_CLASSES)
    return x_train, y_train


def get_test_data():
    (_, _), (x_test, y_test) = cifar10.load_data()
    x_test = x_test.astype('float32') / 255.0
    y_test = to_categorical(y_test, NUM_CLASSES)
    return x_test, y_test
