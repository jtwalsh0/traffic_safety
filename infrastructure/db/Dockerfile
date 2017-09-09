FROM postgres:9.6.4

## Postgis installation
RUN apt-get -y update \
    && apt-get -y install wget \
    && wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - \
    && apt-get -y update \
    && apt-get -y install postgresql-9.6-postgis-2.3 postgis postgresql-9.6-pgrouting \
    && service postgresql start

ADD activate_postgis.sql /docker-entrypoint-initdb.d/
RUN chown postgres:postgres /docker-entrypoint-initdb.d/activate_postgis.sql

## Add Alabama road shapefile
RUN mkdir /shapefiles \
    && cd /shapefiles \
    && wget --quiet http://www.mapcruzin.com/download-shapefile/us/alabama_highway.zip \
    && apt-get -y install unzip \
    && unzip alabama_highway.zip \
    && shp2pgsql -I -s 4326 /shapefiles/alabama_highway.shp | psql -U postgres -d postgres
