#!/bin/bash

# achekerylla: Download the datasets before starting the clients to avoid the
# case where multiple clients try downloading during execution and fail due to
# resource contention conflict in the Keras cache (at ~/.keras).
echo "Download Datasets"
python -c "import tensorflow as tf; tf.keras.datasets.cifar10.load_data()"

echo "Starting server"
python server.py &
sleep 3  # Sleep for 3s to give the server enough time to start

for i in `seq 0 1`; do
    echo "Starting client $i"
    python client.py &
done

# This will allow you to use CTRL+C to stop all background processes
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM
# Wait for all background processes to complete
wait
