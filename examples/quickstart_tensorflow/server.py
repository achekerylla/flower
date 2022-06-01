import flwr as fl
import os

# achekerylla: RFV get server address (default IPv6 unspec addr)
SERVER_ADDRESS = os.environ.get("EXAMPLE_SERVER_ADDRESS", "[::]:8080")


# Start Flower server
fl.server.start_server(
    server_address=SERVER_ADDRESS,
    config={"num_rounds": 3},
)
