#!/bin/bash

# Start Kafka Connect in the background
/etc/confluent/docker/run &

# Wait for Kafka Connect to start. Adjust the sleep time as necessary.
sleep 20

# Post the connector configuration to Kafka Connect
curl -X POST -H "Content-Type: application/json" --data @/etc/kafka-connect/account-connector-config.json http://localhost:8083/connectors

# Keep the container running
wait