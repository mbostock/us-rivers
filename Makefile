# http://www.horizon-systems.com/nhdplus/NHDPlusV2_data.php

REGIONS = 01 02 03N 03S 03W 04 05 06 07 08 09 10U 10L 11 12 13 14 15 16 17 18
TOPOJSON = node --max_old_space_size=8192 node_modules/.bin/topojson
BASEURL := http://www.horizon-systems.com/NHDPlusData/NHDPlusV21/Data
SNAPREGEX := NHDPlusV21_.._...?_NHDSnapshot_..\.7z
ATTRREGEX := NHDPlusV21_.._...?_NHDPlusAttributes_..\.7z
REGLOC := 01-/NHDPlusNE/ 02-/NHDPlusMA/ 03N-/NHDPlusSA/NHDPlus03N/ 03S-/NHDPlusSA/NHDPlus03S/ 03W-/NHDPlusSA/NHDPlus03W/ 04-/NHDPlusGL/ 05-/NHDPlusMS/NHDPlus05/ \
	06-/NHDPlusMS/NHDPlus06/ 07-/NHDPlusMS/NHDPlus07/ 08-/NHDPlusMS/NHDPlus08/ 09-/NHDPlusSR/ 10U-/NHDPlusMS/NHDPlus10U/ 10L-/NHDPlusMS/NHDPlus10L/ \
	11-/NHDPlusMS/NHDPlus11/ 12-/NHDPlusTX/ 13-/NHDPlusRG/ 14-/NHDPlusCO/NHDPlus14/ 15-/NHDPlusCO/NHDPlus15/ 16-/NHDPlusGB/ 17-/NHDPlusPN/ 18-/NHDPlusCA/

all: png/us-rivers.png

clean:
	rm -rf -- shp zip topo fileVersions.dep

zip/%.7z:
	mkdir -p $(dir $@)
	curl -o $@ --raw 'http://www.horizon-systems.com/NHDPlusData/NHDPlusV21/Data/$*.7z'

zip/%.tar.gz:
	mkdir -p $(dir $@)
	curl -o $@ --raw 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)'

shp/%-geometry.shp:
	mkdir -p $(dir $@)
	7z -y -oshp e $< '*/*/NHDSnapshot/Hydrography/NHDFlowline*' '*/*/NHDSnapshot/Hydrography/nhdflowline*'
	for i in shp/*lowline.*; do mv -v "$$i" "shp/$*-geometry.$${i##*\.}"; done
	touch $@

shp/%-attributes.dbf:
	mkdir -p $(dir $@)
	7z -y -oshp e $< '*/*/NHDPlusAttributes/PlusFlowlineVAA.dbf'
	mv shp/PlusFlowlineVAA.dbf $@
	touch $@

shp/land.shp: zip/statep010_nt00798.tar.gz
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

png/us-rivers.png: shp/land.shp $(addsuffix -geometry.shp,$(addprefix shp/,$(REGIONS))) $(addsuffix -attributes.dbf,$(addprefix shp/,$(REGIONS))) bin/rasterize
	mkdir -p $(dir $@)
	bin/rasterize $@
	optipng $@

topo/%-unmerged.json: shp/%-geometry.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) -o $@ -- $(filter %.shp,$^)

topo/%.json: topo/%-unmerged.json
	bin/topomerge $< > $@

fileVersions.dep:
	echo '' > fileVersions.dep
	for reg in $(REGLOC);\
		do\
		URL=$$(echo $${reg} | cut -d- -f2);\
		ID=$$(echo $${reg} | cut -d- -f1);\
		LS=$$(curl --raw "$(BASEURL)$${URL}");\
		echo "shp/$${ID}-geometry.shp: zip$$(echo $${LS} | egrep -o "$${URL}$(SNAPREGEX)")" >> fileVersions.dep;\
		echo "shp/$${ID}-attributes.dbf: zip$$(echo $${LS} | egrep -o "$${URL}$(ATTRREGEX)")" >> fileVersions.dep;\
	done;

include fileVersions.dep
