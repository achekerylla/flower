#!/bin/bash

# Download the example datasets before starting the clients in order to avoid
# the clients competing to write the same files in Keras cache at runtime.
echo "Download Datasets"
python -c "import tensorflow as tf; tf.keras.datasets.cifar10.load_data()"

# (Optional) Set EXAMPLE_SERVER_ADDRESS to a new server address if the default
# server address `[::]:8080` is not available on your system.
export EXAMPLE_SERVER_ADDRESS="${EXAMPLE_SERVER_ADDRESS:-[::]:8080}"

# achekerylla: RFV set steps per epoch (default none)
unset EXAMPLE_STEPS_PER_EPOCH  # none
# export EXAMPLE_STEPS_PER_EPOCH=3


./run.example.sh
