$(OUTPUT)/documents/%/json/output.bin: $(OUTPUT)/documents/%/json/input.json
	$(INSTALL) -m 0664 $< $@

$(OUTPUT)/documents/%/json/output.json: $(OUTPUT)/documents/%/json/output.bin
	$(INSTALL) -m 0664 $< $@

$(OUTPUT)/documents/%/json/VERSION:
	echo "ECMA-404" > $@
