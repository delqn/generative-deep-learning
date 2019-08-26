from keras.optimizers import Adam

def compile(model):
    model.compile(
        loss='categorical_crossentropy',
        optimizer=Adam(lr=0.0005),
        metrics=['accuracy'],
    )
