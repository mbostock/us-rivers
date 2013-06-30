# http://www.horizon-systems.com/nhdplus/NHDPlusV2_data.php

REGIONS = 01 02 03N 03S 03W 04 05 06 07 08 09 10U 10L 11 12 13 14 15 16 17 18
TOPOJSON = node --max_old_space_size=8192 node_modules/.bin/topojson

all: png/us-rivers.png

clean:
	rm -rf -- shp zip topo

zip/%.7z:
	mkdir -p $(dir $@)
	curl -o $@ --raw 'http://www.horizon-systems.com/NHDPlusData/NHDPlusV21/Data/$*.7z'

zip/%.tar.gz:
	mkdir -p $(dir $@)
	curl -o $@ --raw 'http://dds.cr.usgs.gov/pub/data/nationalatlas/$(notdir $@)'

# Northeast
shp/01-geometry.shp: zip/NHDPlusNE/NHDPlusV21_NE_01_NHDSnapshot_03.7z
shp/01-attributes.dbf: zip/NHDPlusNE/NHDPlusV21_NE_01_NHDPlusAttributes_03.7z

# Mid Atlantic
shp/02-geometry.shp: zip/NHDPlusMA/NHDPlusV21_MA_02_NHDSnapshot_03.7z
shp/02-attributes.dbf: zip/NHDPlusMA/NHDPlusV21_MA_02_NHDPlusAttributes_03.7z

# South Atlantic North
shp/03N-geometry.shp: zip/NHDPlusSA/NHDPlus03N/NHDPlusV21_SA_03N_NHDSnapshot_03.7z
shp/03N-attributes.dbf: zip/NHDPlusSA/NHDPlus03N/NHDPlusV21_SA_03N_NHDPlusAttributes_02.7z

# South Atlantic South
shp/03S-geometry.shp: zip/NHDPlusSA/NHDPlus03S/NHDPlusV21_SA_03S_NHDSnapshot_03.7z
shp/03S-attributes.dbf: zip/NHDPlusSA/NHDPlus03S/NHDPlusV21_SA_03S_NHDPlusAttributes_02.7z

# South Atlantic West
shp/03W-geometry.shp: zip/NHDPlusSA/NHDPlus03W/NHDPlusV21_SA_03W_NHDSnapshot_03.7z
shp/03W-attributes.dbf: zip/NHDPlusSA/NHDPlus03W/NHDPlusV21_SA_03W_NHDPlusAttributes_02.7z

# Great Lakes
shp/04-geometry.shp: zip/NHDPlusGL/NHDPlusV21_GL_04_NHDSnapshot_07.7z
shp/04-attributes.dbf: zip/NHDPlusGL/NHDPlusV21_GL_04_NHDPlusAttributes_06.7z

# Ohio
shp/05-geometry.shp: zip/NHDPlusMS/NHDPlus05/NHDPlusV21_MS_05_NHDSnapshot_05.7z
shp/05-attributes.dbf: zip/NHDPlusMS/NHDPlus05/NHDPlusV21_MS_05_NHDPlusAttributes_04.7z

# Tennessee
shp/06-geometry.shp: zip/NHDPlusMS/NHDPlus06/NHDPlusV21_MS_06_NHDSnapshot_06.7z
shp/06-attributes.dbf: zip/NHDPlusMS/NHDPlus06/NHDPlusV21_MS_06_NHDPlusAttributes_06.7z

# Upper Mississippi
shp/07-geometry.shp: zip/NHDPlusMS/NHDPlus07/NHDPlusV21_MS_07_NHDSnapshot_04.7z
shp/07-attributes.dbf: zip/NHDPlusMS/NHDPlus07/NHDPlusV21_MS_07_NHDPlusAttributes_05.7z

# Lower Mississippi
shp/08-geometry.shp: zip/NHDPlusMS/NHDPlus08/NHDPlusV21_MS_08_NHDSnapshot_03.7z
shp/08-attributes.dbf: zip/NHDPlusMS/NHDPlus08/NHDPlusV21_MS_08_NHDPlusAttributes_02.7z

# Souris-Red-Rainy
shp/09-geometry.shp: zip/NHDPlusSR/NHDPlusV21_SR_09_NHDSnapshot_04.7z
shp/09-attributes.dbf: zip/NHDPlusSR/NHDPlusV21_SR_09_NHDPlusAttributes_03.7z

# Upper Missouri
shp/10U-geometry.shp: zip/NHDPlusMS/NHDPlus10U/NHDPlusV21_MS_10U_NHDSnapshot_06.7z
shp/10U-attributes.dbf: zip/NHDPlusMS/NHDPlus10U/NHDPlusV21_MS_10U_NHDPlusAttributes_06.7z

# Lower Missouri
shp/10L-geometry.shp: zip/NHDPlusMS/NHDPlus10L/NHDPlusV21_MS_10L_NHDSnapshot_05.7z
shp/10L-attributes.dbf: zip/NHDPlusMS/NHDPlus10L/NHDPlusV21_MS_10L_NHDPlusAttributes_07.7z

# Ark-Red-White
shp/11-geometry.shp: zip/NHDPlusMS/NHDPlus11/NHDPlusV21_MS_11_NHDSnapshot_04.7z
shp/11-attributes.dbf: zip/NHDPlusMS/NHDPlus11/NHDPlusV21_MS_11_NHDPlusAttributes_03.7z

# Texas
shp/12-geometry.shp: zip/NHDPlusTX/NHDPlusV21_TX_12_NHDSnapshot_04.7z
shp/12-attributes.dbf: zip/NHDPlusTX/NHDPlusV21_TX_12_NHDPlusAttributes_04.7z

# Rio Grande
shp/13-geometry.shp: zip/NHDPlusRG/NHDPlusV21_RG_13_NHDSnapshot_04.7z
shp/13-attributes.dbf: zip/NHDPlusRG/NHDPlusV21_RG_13_NHDPlusAttributes_02.7z

# Upper Colorado
shp/14-geometry.shp: zip/NHDPlusCO/NHDPlus14/NHDPlusV21_CO_14_NHDSnapshot_04.7z
shp/14-attributes.dbf: zip/NHDPlusCO/NHDPlus14/NHDPlusV21_CO_14_NHDPlusAttributes_03.7z

# Lower Colorado
shp/15-geometry.shp: zip/NHDPlusCO/NHDPlus15/NHDPlusV21_CO_15_NHDSnapshot_03.7z
shp/15-attributes.dbf: zip/NHDPlusCO/NHDPlus15/NHDPlusV21_CO_15_NHDPlusAttributes_02.7z

# Great Basin
shp/16-geometry.shp: zip/NHDPlusGB/NHDPlusV21_GB_16_NHDSnapshot_05.7z
shp/16-attributes.dbf: zip/NHDPlusGB/NHDPlusV21_GB_16_NHDPlusAttributes_02.7z

# Pacific Northwest
shp/17-geometry.shp: zip/NHDPlusPN/NHDPlusV21_PN_17_NHDSnapshot_04.7z
shp/17-attributes.dbf: zip/NHDPlusPN/NHDPlusV21_PN_17_NHDPlusAttributes_04.7z

# California
shp/18-geometry.shp: zip/NHDPlusCA/NHDPlusV21_CA_18_NHDSnapshot_04.7z
shp/18-attributes.dbf: zip/NHDPlusCA/NHDPlusV21_CA_18_NHDPlusAttributes_03.7z

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

shp/land.shp: zip/nationalp010g_nt00797.tar.gz
	rm -rf $(basename $@)
	mkdir -p $(basename $@)
	tar -xzm -C $(basename $@) -f $<
	for file in $(basename $@)/*; do chmod 644 $$file; mv $$file $(basename $@).$${file##*.}; done
	rmdir $(basename $@)

png/us-rivers.png: shp/land.shp $(addsuffix -geometry.shp,$(addprefix shp/,$(REGIONS))) $(addsuffix -attributes.dbf,$(addprefix shp/,$(REGIONS))) bin/rasterize
	mkdir -p $(dir $@)
	bin/rasterize $@
# optipng $@

topo/%-unmerged.json: shp/%-geometry.shp
	mkdir -p $(dir $@)
	$(TOPOJSON) -o $@ -- $(filter %.shp,$^)

topo/%.json: topo/%-unmerged.json
	bin/topomerge $< > $@
