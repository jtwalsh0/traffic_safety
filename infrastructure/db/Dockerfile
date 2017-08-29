FROM postgres:9.6.4

## Postgis installation
RUN apt-get -y update \
    && apt-get -y  install wget \
    && wget --quiet -O - http://apt.postgresql.org/pub/repos/apt/ACCC4CF8.asc | apt-key add - \
    && apt-get -y update \
    && apt-get -y install postgresql-9.6-postgis-2.3 postgis postgresql-9.6-pgrouting

ADD activate_postgis.sql /docker-entrypoint-initdb.d/
RUN chown postgres:postgres /docker-entrypoint-initdb.d/activate_postgis.sql

