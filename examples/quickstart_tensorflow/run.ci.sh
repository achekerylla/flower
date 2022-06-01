#!/bin/bash

# achekerylla: WIP reflect ci usage

python -c "import tensorflow as tf; tf.keras.datasets.cifar10.load_data()"

python server.py &
sleep 3

python client.py 1 &
sleep 3

if [[ $(ps aux | grep "[p]ython client.py 1" | awk '{ print $2 }') ]]; then
    echo "Client process 1 started correctly"
else
    echo "Client process 1 crashed" && exit 1
fi

python client.py 2 &
sleep 3

if [[ $(ps aux | grep "[p]ython client.py 2" | awk '{ print $2 }') ]]; then
    echo "Client process 2 started correctly"
else
    echo "Client process 2 crashed" && exit 1
fi

if [[ $(ps aux | grep "[p]ython server.py" | awk '{ print $2 }') ]]; then
    echo "Server process started correctly"
else
    echo "Server process crashed" && exit 1
fi

# killall python
pkill -9 python
