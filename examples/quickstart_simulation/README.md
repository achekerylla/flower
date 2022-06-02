# EXPERIMENTAL Flower Simulation Example using TensorFlow/Keras

This introductory example uses the simulation capabilities of Flower to simulate a large number of clients on either a single machine of a cluster of machines.

## Running the example (via Jupyter Notebook)

Run the example on Google Colab: [![Open In Colab](https://colab.research.google.com/assets/colab-badge.svg)](https://colab.research.google.com/github/adap/flower/blob/main/examples/quickstart_simulation/sim.ipynb)

Alternatively, you can run `sim.ipynb` locally or in any other Jupyter environment.

## Running the example (via Poetry)

Start by cloning the code example. We prepared a single-line command that you can copy into your shell which will checkout the example for you:

```shell
git clone --depth=1 https://github.com/adap/flower.git && mv flower/examples/quickstart_simulation . && rm -rf flower && cd quickstart_simulation
```

This will create a new directory called `quickstart_simulation` containing the following files:

```shell
-- README.md       <- Your're reading this right now
-- sim.ipynb       <- Example notebook
-- sim.py          <- Example code
-- pyproject.toml  <- Example dependencies (for Poetry)
```

Project dependencies (such as `tensorflow` and `flwr`) are defined in `pyproject.toml` (the modern alternative to `requirements.txt`). We recommend [Poetry](https://python-poetry.org/docs/) to install those dependencies and manage your virtual environment ([Poetry installation](https://python-poetry.org/docs/#installation)), but feel free to use a different way of installing dependencies and managing virtual environments if you have other preferences.

```shell
poetry install
```

Poetry will install all your dependencies in a newly created virtual environment. To verify that everything works correctly you can run the following command:

```shell
poetry run python3 -c "import flwr"
```

If you don't see any errors you're good to go! 

```bash
poetry run python3 sim.py
```

## Troubleshooting

Before `poetry install`, confirm gcc-5 is in your path.  It is needed for building the `hiredis` extension in the `quickstart_simulation` example.

```bash
if ! command -v gcc-5 2>/dev/null ; then
    echo "Warning! gcc-5 not found!"
    echo "Required for poetry build of hiredis."
fi
```

Before `poetry run`, confirm IPv6 is enabled.  It is needed for running Flower.

```bash
if [ -f /proc/net/if_inet6 ]; then
    echo "IPv6 kernel support found!"
else
    echo "Warning! IPv6 kernel support not found!"
fi
if lsmod | grep -qw ipv6; then
    echo "IPv6 kernel module found!"
else
    echo "Warning! IPv6 kernel module not found!"
fi
modprobe ipv6 || echo "Error! IPv6 load failed!"
ping6 -c 1 ::1 || echo "Error! IPv6 ping failed!"
```
