#!/bin/bash
set -e

# this script extracts and loads the ALDOT shapefile into Postgres

# read database credentials
PGHOST=$(jq '.db.PGHOST' < credentials.json | tr -d '"')
PGUSER=$(jq '.db.PGUSER' < credentials.json | tr -d '"')
PGPASSWORD=$(jq '.db.PGPASSWORD' < credentials.json | tr -d '"')
PGDATABASE=$(jq '.db.PGDATABASE' < credentials.json | tr -d '"')
PGPORT=$(jq '.db.PGPORT' < credentials.json | tr -d '"')

WORKDIR="/Users/joewalsh/git-projects/traffic_safety/"

# load shapefiles into postgres
aldot_shapefiles() {

  FILENAME=$1
  BASENAME=$(basename "$FILENAME")
  TABLENAME=$(echo "$BASENAME" | cut -d'.' -f1)

  echo "$TABLENAME"

  # ogr2ogr doesn't like an existing file
  rm -rfv "$WORKDIR/data/preprocessed/ALDOT/4326/" &&\
  mkdir -p "$WORKDIR/data/preprocessed/ALDOT/4326/"
  
  # drop table if exists
  PGPASSWORD="$PGPASSWORD" psql -v ON_ERROR_STOP=1 -h "$PGHOST" -U "$PGUSER" -d "$PGDATABASE" -c "DROP TABLE IF EXISTS shapefiles.$TABLENAME"
  
  # -q suppresses query output which for large shapefiles seems to slow down the import
  ogr2ogr -t_srs EPSG:4326 "$WORKDIR/data/preprocessed/ALDOT/4326/$BASENAME" "$WORKDIR/data/preprocessed/ALDOT/$BASENAME" &&\
  shp2pgsql -I -D -s 4326 "$WORKDIR/data/preprocessed/ALDOT/4326/$BASENAME" "shapefiles.$TABLENAME" | 
  PGPASSWORD="$PGPASSWORD" psql -v ON_ERROR_STOP=1 -h "$PGHOST" -U "$PGUSER" -d "$PGDATABASE" 
}


URL="https://www.dot.state.al.us/tpmpweb/dcdm/pdf/AADTShapeFiles/StatewideShapeFile.zip"
wget -N "$WORKDIR/data/raw/ALDOT/ALDOT_shapefile.zip" "$URL" &&\
unzip -d "$WORKDIR/data/preprocessed/ALDOT/" "$WORKDIR/data/raw/ALDOT/ALDOT_shapefile.zip"


aldot_shapefiles "$WORKDIR/data/preprocessed/ALDOT/Statewide_Counters.shp"
aldot_shapefiles "$WORKDIR/data/preprocessed/ALDOT/Statewide_Routes.shp"

