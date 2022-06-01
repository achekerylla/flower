import os

import flwr as fl
import tensorflow as tf


# Make TensorFlow log less verbose
os.environ["TF_CPP_MIN_LOG_LEVEL"] = "3"

# achekerylla: RFV get server address (default IPv6 unspec addr)
SERVER_ADDRESS = os.environ.get("EXAMPLE_SERVER_ADDRESS", "[::]:8080")

# achekerylla: RFV get steps per epoch (default none)
STEPS_PER_EPOCH = os.environ.get("EXAMPLE_STEPS_PER_EPOCH", None)

# Load model and data (MobileNetV2, CIFAR-10)
model = tf.keras.applications.MobileNetV2((32, 32, 3), classes=10, weights=None)
model.compile("adam", "sparse_categorical_crossentropy", metrics=["accuracy"])
(x_train, y_train), (x_test, y_test) = tf.keras.datasets.cifar10.load_data()

# Define Flower client
class CifarClient(fl.client.NumPyClient):
    def get_parameters(self):
        return model.get_weights()

    def fit(self, parameters, config):
        model.set_weights(parameters)
        model.fit(x_train, y_train, epochs=1, batch_size=32, steps_per_epoch=STEPS_PER_EPOCH)
        return model.get_weights(), len(x_train), {}

    def evaluate(self, parameters, config):
        model.set_weights(parameters)
        loss, accuracy = model.evaluate(x_test, y_test)
        return loss, len(x_test), {"accuracy": accuracy}


# Start Flower client
fl.client.start_numpy_client(SERVER_ADDRESS, client=CifarClient())
