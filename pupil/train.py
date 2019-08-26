from .model import get_model_sequential, get_model
from .load_data import get_train_data, get_test_data

def train(model):
    x_train, y_train = get_train_data()
    x_test, y_test = get_test_data()
    model.fit(
        x_train,
        y_train,
        batch_size=32,
        epochs=10,
        shuffle=True,
        validation_data=(x_test, y_test),
        verbose=1,  # set this to 0 to remove noise
    )

def save(model):
    file_name = 'model.json'
    file_name_weights = 'model.h5'
    # serialize model to JSON
    model_json = model.to_json()
    with open(file_name, 'w') as json_file:
        json_file.write(model_json)
        # serialize weights to HDF5
        model.save_weights(file_name_weights)
        print(f'Saved model to disk: {file_name}, {file_name_weights}')
