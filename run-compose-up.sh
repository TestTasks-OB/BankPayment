#!/bin/bash

docker network create kafka-network 2>/dev/null || true

CURRENT_DIR=$(pwd) 
ACCOUNT_DIR="$CURRENT_DIR/account"
docker-compose -f docker-compose.main.yaml  up -d
cd "$ACCOUNT_DIR"
docker-compose   -f docker-compose.account.yaml up -d
 

KAFKA_CONTAINER_NAME=bankpayment_kafka_1

echo "Waiting for the Kafka container to start..."
until docker inspect --format='{{.State.Running}}' $KAFKA_CONTAINER_NAME 2>/dev/null | grep true > /dev/null; do
  sleep 1
done
 
echo "Waiting for Kafka to be fully ready..."
until docker exec $KAFKA_CONTAINER_NAME cub kafka-ready -b localhost:9092 1 20; do
  sleep 1
done

echo "Kafka is fully ready."

docker exec  $KAFKA_CONTAINER_NAME cub kafka-ready -b localhost:9092 1 20
docker exec  $KAFKA_CONTAINER_NAME kafka-topics --create --if-not-exists --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1 --topic your_topic_name_1
docker exec  $KAFKA_CONTAINER_NAME kafka-topics --create --if-not-exists --bootstrap-server localhost:9092 --partitions 1 --replication-factor 1 --topic your_topic_name_2

echo "Topics created successfully."
