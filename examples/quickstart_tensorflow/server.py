import flwr as fl


# Start Flower server
address = "0.0.0.0:8080"  # achekerylla: Use IPv4
fl.server.start_server(
    server_address=address,
    config={"num_rounds": 3},
)
