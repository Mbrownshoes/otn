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
	-- fish=$<