CREATE TABLE steelhead                                                                          (              
  catalognumber character varying(50),
  datecollected character varying(20),
  longitude float,
  latitude float
);

\copy steelhead(catalognumber,datecollected,longitude,latitude) FROM 'steelhead.csv' DELIMITERS ',' CSV HEADER;

SELECT AddGeometryColumn('public','steelhead','geom',4326,'POINT',2);

update steelhead set geom = ST_SetSRID(ST_MakePoint(longitude,latitude),4326);

-- create spatial index
CREATE INDEX idx_steelhead ON steelhead USING GIST (geom);

GRANT ALL PRIVILEGES ON TABLE side_adzone TO jerry;