# http://www.horizon-systems.com/nhdplus/NHDPlusV2_data.php

all: topo/us.json

clean:
	rm -rf -- shp zip topo

zip/%.7z:
	mkdir -p $(dir $@)
	curl -o $@ --raw 'http://www.horizon-systems.com/NHDPlusData/NHDPlusV21/Data/$*.7z'

REGIONS = 01 02 03N 03S 03W 04 05 06 07 08 09 10U 10L 11 12 13 14 15 16 17 18

# 	NHDPlusCA/NHDPlusV21_CA_18_NHDPlusAttributes_03 \
# 	NHDPlusCO/NHDPlus14/NHDPlusV21_CO_14_NHDPlusAttributes_03 \
# 	NHDPlusCO/NHDPlus15/NHDPlusV21_CO_15_NHDPlusAttributes_02 \
# 	NHDPlusGB/NHDPlusV21_GB_16_NHDPlusAttributes_02 \
# 	NHDPlusGL/NHDPlusV21_GL_04_NHDPlusAttributes_06 \
# 	NHDPlusMA/NHDPlusV21_MA_02_NHDPlusAttributes_03 \
# 	NHDPlusMS/NHDPlus05/NHDPlusV21_MS_05_NHDPlusAttributes_04 \
# 	NHDPlusMS/NHDPlus06/NHDPlusV21_MS_06_NHDPlusAttributes_06 \
# 	NHDPlusMS/NHDPlus07/NHDPlusV21_MS_07_NHDPlusAttributes_05 \
# 	NHDPlusMS/NHDPlus08/NHDPlusV21_MS_08_NHDPlusAttributes_02 \
# 	NHDPlusMS/NHDPlus10L/NHDPlusV21_MS_10L_NHDPlusAttributes_07 \
# 	NHDPlusMS/NHDPlus10U/NHDPlusV21_MS_10U_NHDPlusAttributes_06 \
# 	NHDPlusMS/NHDPlus11/NHDPlusV21_MS_11_NHDPlusAttributes_03 \
# 	NHDPlusNE/NHDPlusV21_NE_01_NHDPlusAttributes_03 \
# 	NHDPlusPN/NHDPlusV21_PN_17_NHDPlusAttributes_04 \
# 	NHDPlusRG/NHDPlusV21_RG_13_NHDPlusAttributes_02 \
# 	NHDPlusSA/NHDPlus03N/NHDPlusV21_SA_03N_NHDPlusAttributes_02 \
# 	NHDPlusSA/NHDPlus03S/NHDPlusV21_SA_03S_NHDPlusAttributes_02 \
# 	NHDPlusSA/NHDPlus03W/NHDPlusV21_SA_03W_NHDPlusAttributes_02 \
# 	NHDPlusSR/NHDPlusV21_SR_09_NHDPlusAttributes_03 \
# 	NHDPlusTX/NHDPlusV21_TX_12_NHDPlusAttributes_04

# Northeast
shp/01.shp: zip/NHDPlusNE/NHDPlusV21_NE_01_NHDSnapshot_03.7z

# Mid Atlantic
shp/02.shp: zip/NHDPlusMA/NHDPlusV21_MA_02_NHDSnapshot_03.7z

# South Atlantic North
shp/03N.shp: zip/NHDPlusSA/NHDPlus03N/NHDPlusV21_SA_03N_NHDSnapshot_03.7z

# South Atlantic South
shp/03S.shp: zip/NHDPlusSA/NHDPlus03S/NHDPlusV21_SA_03S_NHDSnapshot_03.7z

# South Atlantic West
shp/03W.shp: zip/NHDPlusSA/NHDPlus03W/NHDPlusV21_SA_03W_NHDSnapshot_03.7z

# Great Lakes
shp/04.shp: zip/NHDPlusGL/NHDPlusV21_GL_04_NHDSnapshot_07.7z

# Ohio
shp/05.shp: zip/NHDPlusMS/NHDPlus05/NHDPlusV21_MS_05_NHDSnapshot_05.7z

# Tennessee
shp/06.shp: zip/NHDPlusMS/NHDPlus06/NHDPlusV21_MS_06_NHDSnapshot_06.7z

# Upper Mississippi
shp/07.shp: zip/NHDPlusMS/NHDPlus07/NHDPlusV21_MS_07_NHDSnapshot_04.7z

# Lower Mississippi
shp/08.shp: zip/NHDPlusMS/NHDPlus08/NHDPlusV21_MS_08_NHDSnapshot_03.7z

# Souris-Red-Rainy
shp/09.shp: zip/NHDPlusSR/NHDPlusV21_SR_09_NHDSnapshot_04.7z

# Upper Missouri
shp/10U.shp: zip/NHDPlusMS/NHDPlus10U/NHDPlusV21_MS_10U_NHDSnapshot_06.7z

# Lower Missouri
shp/10L.shp: zip/NHDPlusMS/NHDPlus10L/NHDPlusV21_MS_10L_NHDSnapshot_05.7z

# Ark-Red-White
shp/11.shp: zip/NHDPlusMS/NHDPlus11/NHDPlusV21_MS_11_NHDSnapshot_04.7z

# Texas
shp/12.shp: zip/NHDPlusTX/NHDPlusV21_TX_12_NHDSnapshot_04.7z

# Rio Grande
shp/13.shp: zip/NHDPlusRG/NHDPlusV21_RG_13_NHDSnapshot_04.7z

# Upper Colorado
shp/14.shp: zip/NHDPlusCO/NHDPlus14/NHDPlusV21_CO_14_NHDSnapshot_04.7z

# Lower Colorado
shp/15.shp: zip/NHDPlusCO/NHDPlus15/NHDPlusV21_CO_15_NHDSnapshot_03.7z

# Great Basin
shp/16.shp: zip/NHDPlusGB/NHDPlusV21_GB_16_NHDSnapshot_05.7z

# Pacific Northwest
shp/17.shp: zip/NHDPlusPN/NHDPlusV21_PN_17_NHDSnapshot_04.7z

# California
shp/18.shp: zip/NHDPlusCA/NHDPlusV21_CA_18_NHDSnapshot_04.7z

shp/%.shp:
	mkdir -p $(dir $@)
	7z -y -oshp e $< '*/*/NHDSnapshot/Hydrography/NHDFlowline*' '*/*/NHDSnapshot/Hydrography/nhdflowline*'
	for i in shp/*lowline.*; do mv -v "$$i" "shp/$*.$${i##*\.}"; done
	touch $@

topo/01-unmerged.json: shp/01.shp
topo/02-unmerged.json: shp/02.shp
topo/03N-unmerged.json: shp/03N.shp
topo/03S-unmerged.json: shp/03S.shp
topo/03W-unmerged.json: shp/03W.shp
topo/04-unmerged.json: shp/04.shp
topo/05-unmerged.json: shp/05.shp
topo/06-unmerged.json: shp/06.shp
topo/07-unmerged.json: shp/07.shp
topo/08-unmerged.json: shp/08.shp
topo/09-unmerged.json: shp/09.shp
topo/10U-unmerged.json: shp/10U.shp
topo/10L-unmerged.json: shp/10L.shp
topo/11-unmerged.json: shp/11.shp
topo/12-unmerged.json: shp/12.shp
topo/13-unmerged.json: shp/13.shp
topo/14-unmerged.json: shp/14.shp
topo/15-unmerged.json: shp/15.shp
topo/16-unmerged.json: shp/16.shp
topo/17-unmerged.json: shp/17.shp
topo/18-unmerged.json: shp/18.shp
topo/us-unmerged.json: $(addsuffix .shp,$(addprefix shp/,$(REGIONS)))

topo/%-unmerged.json:
	mkdir -p $(dir $@)
	node_modules/.bin/topojson -o $@ -- $(filter %.shp,$^)

topo/%.json: topo/%-unmerged.json
	bin/topomerge $< > $@
