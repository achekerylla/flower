import flwr as fl
import os

# (Optional) Set EXAMPLE_SERVER_ADDRESS in your environment to override the
# default value if `[::]:8080` is not available on your system.
SERVER_ADDRESS = os.environ.get("EXAMPLE_SERVER_ADDRESS", "[::]:8080")

# Start Flower server
fl.server.start_server(
    server_address=SERVER_ADDRESS,
    config={"num_rounds": 3},
)
