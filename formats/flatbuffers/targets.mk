$(OUTPUT)/documents/%/flatbuffers/output.bin: \
	$(OUTPUT)/documents/%/flatbuffers/input.json benchmark/%/flatbuffers/schema.fbs
	$(FLATC) --force-defaults --raw-binary -o $(dir $@) --binary $(word 2,$^) $<
	mv $(dir $@)$(notdir $(basename $<)).bin $@

$(OUTPUT)/documents/%/flatbuffers/output.json: \
	$(OUTPUT)/documents/%/flatbuffers/output.bin benchmark/%/flatbuffers/schema.fbs
	$(FLATC) --raw-binary -o $(dir $@) --strict-json --json $(word 2,$^) -- $<
	mv $(dir $@)$(notdir $(basename $<)).json $@

$(OUTPUT)/documents/%/flatbuffers/VERSION: | $(OUTPUT)/documents/%/flatbuffers
	$(FLATC) --version > $@
