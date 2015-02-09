build/kntm_matched_detections_2011.zip:
	mkdir -p $(dir $@)
	curl -o $@ http://members.oceantrack.org/data/repository/kntm/detection-extracts/kntm_matched_detections_2011.zip/view/$(notdir $@)

build/kntm_matched_detections_2011.csv: build/kntm_matched_detections_2011.zip
	unzip -od $(dir $@) $<
	touch $@

# run python script to widdle down to steelhead

fish.json: build/steelhead.csv
	node_modules/.bin/topojson \
	-o fish.json \
	-x longitude -y latitude \
	-p fish="catalognumber" \
	-p timestamp="datecollected" \
	-p geom="st_setsrid_4326" \
	-- fish


build/subunits.json: build/Boundaries/CD_2011.shp
	ogr2ogr -f GeoJSON  -t_srs "+proj=latlong +datum=WGS84" -where "CDNAME like 'Greater%'" \
	build/subunits.json \
	build/Boundaries/CD_2011.shp

vancouver.json: build/subunits.json
	node_modules/.bin/topojson \
		-o $@ \
		-- $<

build/lakes.json: build/HydLake_shp
	ogr2ogr -f GeoJSON -t_srs "+proj=latlong +datum=WGS84" \
	build/lakes.json \
	build/HydLake_shp

lakes.json: build/lakes.json
	node_modules/.bin/topojson \
		-o $@ \
		-- $<