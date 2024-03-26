#!/bin/bash

CURRENT_DIR=$(pwd) 
ACCOUNT_DIR="$CURRENT_DIR/account"
cd "$ACCOUNT_DIR"
docker-compose   -f docker-compose.account.yaml down
cd "$CURRENT_DIR"
docker-compose -f docker-compose.main.yaml down
docker network rm kafka-network