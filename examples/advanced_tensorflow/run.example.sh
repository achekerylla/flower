#!/bin/bash

# achekerylla: debug statements
python3 -c "import tensorflow as tf; print(tf.__version__)"

# achekerylla: Download the datasets before starting the clients to avoid the
# case where multiple clients try downloading during execution and fail due to
# resource contention conflict in the Keras cache (at ~/.keras).
echo "Download Datasets"
python -c "import tensorflow as tf; tf.keras.datasets.cifar10.load_data()"

echo "Starting server"
python server.py &
sleep 3  # Sleep for 3s to give the server enough time to start

for i in `seq 0 9`; do
    echo "Starting client $i"
    python client.py --partition=${i} &
done

# This will allow you to use CTRL+C to stop all background processes
trap "trap - SIGTERM && kill -- -$$" SIGINT SIGTERM
# Wait for all background processes to complete
wait
