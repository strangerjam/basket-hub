#!/bin/bash
set -e

psql -v ON_ERROR_STOP=1 --username "$POSTGRES_USER" --dbname "$POSTGRES_DB" <<-EOSQL
    -- create initial tables
    CREATE TABLE IF NOT EXISTS baskethub.public.league (
        id SERIAL PRIMARY KEY,
        external_code VARCHAR(50) NOT NULL,
        code VARCHAR(50) NOT NULL,
        name VARCHAR(50) NOT NULL
    );

    CREATE TABLE IF NOT EXISTS baskethub.public.season (
        id SERIAL PRIMARY KEY,
        name VARCHAR(100) NOT NULL,
        year_start INT NOT NULL,
        year_end INT NOT NULL
    );

    -- insert initial data
    INSERT INTO league (external_code, code, name) VALUES
    ('00', 'nba', 'NBA'),
    ('10', 'wnba', 'WNBA');

    INSERT INTO season (name, year_start, year_end) VALUES
    ('2024-25', 2024, 2025);
EOSQL