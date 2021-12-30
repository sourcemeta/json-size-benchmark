$(OUTPUT)/%/flatbuffers/output.bin: \
	$(OUTPUT)/%/flatbuffers/input.json benchmark/%/flatbuffers/schema.fbs
	$(FLATC) --force-defaults --raw-binary -o $(dir $@) --binary $(word 2,$^) $<
	mv $(dir $@)$(notdir $(basename $<)).bin $@

$(OUTPUT)/%/flatbuffers/output.json: \
	$(OUTPUT)/%/flatbuffers/output.bin benchmark/%/flatbuffers/schema.fbs
	$(FLATC) --raw-binary -o $(dir $@) --strict-json --json $(word 2,$^) -- $<
	mv $(dir $@)$(notdir $(basename $<)).json $@
