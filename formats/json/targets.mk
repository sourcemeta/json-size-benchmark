$(OUTPUT)/%/json/output.bin: $(OUTPUT)/%/json/input.json
	$(INSTALL) -m 0664 $< $@

$(OUTPUT)/%/json/output.json: $(OUTPUT)/%/json/output.bin
	$(INSTALL) -m 0664 $< $@
