REGIONS = 01 02 03N 03S 03W 04 05 06 07 08 09 10U 10L 11 12 13 14 15 16 17 18

# all: $(addsuffix -geometry.7z,$(addprefix zip/,$(REGIONS))) $(addsuffix -attributes.7z,$(addprefix zip/,$(REGIONS)))
# all: $(addsuffix -geometry.shp,$(addprefix shp/,$(REGIONS))) $(addsuffix -attributes.dbf,$(addprefix shp/,$(REGIONS)))
all: png/us-rivers.png

clean:
	rm -rf -- shp zip

zip/%-geometry.7z:
	mkdir -p zip
	curl -o $@ $$(curl 'http://www.horizon-systems.com/nhdplus/NHDPlusV2_$*.php' \
			| grep 'http://www.horizon-systems.com/NHDPlusData/NHDPlusV21/Data/' \
			| grep '_NHDSnapshot_' \
			| sed 's/.*href="//' \
			| sed 's/".*//g')

zip/%-attributes.7z:
	mkdir -p zip
	curl -o $@ $$(curl 'http://www.horizon-systems.com/nhdplus/NHDPlusV2_$*.php' \
			| grep 'http://www.horizon-systems.com/NHDPlusData/NHDPlusV21/Data/' \
			| grep '_NHDPlusAttributes_' \
			| sed 's/.*href="//' \
			| sed 's/".*//g')

shp/%-geometry.shp: zip/%-geometry.7z
	mkdir -p shp
	7z -y -oshp/$*-geometry e $< '*/*/NHDSnapshot/Hydrography/NHDFlowline.*'
	for i in shp/$*-geometry/NHDFlowline.*; do mv -v "$$i" "shp/$*-geometry.$${i##*\.}"; done
	rmdir shp/$*-geometry
	touch $@

shp/%-attributes.dbf: zip/%-attributes.7z
	mkdir -p shp
	7z -y -oshp/$*-attributes e $< '*/*/NHDPlusAttributes/PlusFlowlineVAA.*'
	for i in shp/$*-attributes/PlusFlowlineVAA.*; do mv -v "$$i" "shp/$*-attributes.$${i##*\.}"; done
	rmdir shp/$*-attributes
	touch $@

png/us-rivers.png: $(addsuffix -geometry.shp,$(addprefix shp/,$(REGIONS)))
	mkdir -p png
	for i in $^; do shp2json -g -n $$i; done \
		| geoproject -n 'd3.geoAlbersUsa().scale(4 * 1280).translate([4 * 480, 4 * 300])' \
		| bin/geo2canvas -n --width 3840 --height 2400 -o $@
