#!/bin/bash

# achekerylla: RFV debug statements
python3 -c "import tensorflow as tf; print(tf.__version__)"

# achekerylla: RFV download the datasets, may include in PR
# Download the example datasets before starting the clients in order to avoid
# the clients competing to write the same files in Keras cache at runtime.
echo "Download Datasets"
python -c "import tensorflow as tf; tf.keras.datasets.cifar10.load_data()"

# achekerylla: RFV set server address (default IPv6 unspec addr)
export EXAMPLE_SERVER_ADDRESS="[::]:8080"  # IPv6 unspec addr
# export EXAMPLE_SERVER_ADDRESS="0.0.0.0:8080"  # IPv4

# achekerylla: RFV set steps per epoch (default none)
unset EXAMPLE_STEPS_PER_EPOCH  # none
# export EXAMPLE_STEPS_PER_EPOCH=3


./run.example.sh
