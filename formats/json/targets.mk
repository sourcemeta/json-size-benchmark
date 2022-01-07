$(OUTPUT)/documents/%/json/output.bin: $(OUTPUT)/documents/%/json/input.json \
	| $(OUTPUT)/documents/%/json
	$(INSTALL) -m 0664 $< $@

$(OUTPUT)/documents/%/json/output.json: $(OUTPUT)/documents/%/json/output.bin \
	| $(OUTPUT)/documents/%/json
	$(INSTALL) -m 0664 $< $@

$(OUTPUT)/documents/%/json/VERSION: | $(OUTPUT)/documents/%/json
	echo "ECMA-404" > $@
