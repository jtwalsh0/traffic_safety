CREATE SCHEMA postgis;

ALTER DATABASE postgres SET search_path=public, postgis, contrib;

CREATE EXTENSION postgis SCHEMA postgis;
CREATE EXTENSION postgis_sfcgal SCHEMA postgis;
CREATE EXTENSION pgrouting;
