#!/bin/bash
set -e

# folder structure
WORKDIR=$(jq '.working_directory' < credentials.json | tr -d '"')
parallel 'mkdir -p {1}/{2}/{3}' ::: "$WORKDIR" ::: 'raw' 'preprocessed' ::: 'ALDOT' 'CAPS'

# read database credentials
PGHOST=$(jq '.db.PGHOST' < credentials.json | tr -d '"')
PGUSER=$(jq '.db.PGUSER' < credentials.json | tr -d '"')
PGPASSWORD=$(jq '.db.PGPASSWORD' < credentials.json | tr -d '"')
PGDATABASE=$(jq '.db.PGDATABASE' < credentials.json | tr -d '"')
PGPORT=$(jq '.db.PGPORT' < credentials.json | tr -d '"')

# run db creation scripts
PGPASSWORD="$PGPASSWORD" psql -X -h "$PGHOST" -U "$PGUSER" -d "$PGDATABASE" -p "$PGPORT" -f infrastructure/db/create_matrices_schema.sql
PGPASSWORD="$PGPASSWORD" psql -X -h "$PGHOST" -U "$PGUSER" -d "$PGDATABASE" -p "$PGPORT" -f infrastructure/db/create_modeling_schema.sql
PGPASSWORD="$PGPASSWORD" psql -X -h "$PGHOST" -U "$PGUSER" -d "$PGDATABASE" -p "$PGPORT" -f infrastructure/db/create_results_schema.sql
