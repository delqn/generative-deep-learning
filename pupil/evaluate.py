def evaluate(model, x_test, y_test):
    """Evaluates the model"""
    score = model.evaluate(x_test, y_test, batch_size=1000)
    print(f'{model.metrics_names[1]}:')
    print('Test loss:', score[0])
    print('Test accuracy:', score[1])
