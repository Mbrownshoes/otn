--this is stored in Data on Darjeeling
--sudo su - postgres
--psql otn
--sudo psql -d otn -c "CREATE EXTENSION postgis;" 
sudo  -u postgres psql
\connect otn;

CREATE EXTENSION postgis;

CREATE TABLE steelhead                                                                          (              
  catalognumber character varying(50),
  datecollected character varying(20),
  longitude float,
  latitude float,
  geom geometry
);

\copy steelhead(catalognumber,datecollected,longitude,latitude) FROM 'steelhead.csv' DELIMITERS ',' CSV HEADER;

SELECT AddGeometryColumn('public','steelhead','geom',4326,'POINT',2);

update steelhead set geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

-- create spatial index
CREATE INDEX idx_steelhead ON steelhead USING GIST (geom);

GRANT ALL PRIVILEGES ON TABLE steelhead TO mathew;