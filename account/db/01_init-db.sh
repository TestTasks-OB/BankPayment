#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL 
    CREATE SCHEMA app;
    CREATE USER $APP_DB_USER WITH PASSWORD '$APP_DB_PASS';
    GRANT ALL PRIVILEGES ON DATABASE db TO $APP_DB_USER;
EOSQL