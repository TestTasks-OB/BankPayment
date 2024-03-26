#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    GRANT SELECT, INSERT, UPDATE, DELETE ON app.accounts TO $APP_DB_USER;
    GRANT USAGE ON SCHEMA app to $APP_DB_USER;
EOSQL
