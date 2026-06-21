#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    CREATE USER forgejo WITH PASSWORD 'forgejo-pass';
    CREATE DATABASE forgejo;
    GRANT ALL PRIVILEGES ON DATABASE forgejo TO forgejo;

    CREATE USER n8n WITH PASSWORD 'hypeno-pass-change-me';
    CREATE DATABASE n8n;
    GRANT ALL PRIVILEGES ON DATABASE n8n TO n8n;

    CREATE USER synapse WITH PASSWORD 'synapse-pass';
    CREATE DATABASE synapse;
    GRANT ALL PRIVILEGES ON DATABASE synapse TO synapse;
EOSQL
