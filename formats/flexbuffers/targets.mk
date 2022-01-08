$(OUTPUT)/documents/%/flexbuffers/output.bin: $(OUTPUT)/documents/%/flexbuffers/input.json \
	| $(OUTPUT)/documents/%/flexbuffers
	$(FLATC) --flexbuffers -o $(dir $@) --binary $<
	mv $(dir $@)$(notdir $(basename $<)).bin $@

$(OUTPUT)/documents/%/flexbuffers/output.json: $(OUTPUT)/documents/%/flexbuffers/output.bin \
	| $(OUTPUT)/documents/%/flexbuffers
	$(FLATC) --flexbuffers -o $(dir $@) --strict-json --json $<
	mv $(dir $@)$(notdir $(basename $<)).json $@

$(OUTPUT)/documents/%/flexbuffers/VERSION: | $(OUTPUT)/documents/%/flexbuffers
	$(FLATC) --version > $@
