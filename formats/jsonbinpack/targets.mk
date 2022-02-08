$(OUTPUT)/documents/%/jsonbinpack/encoding.json: benchmark/%/jsonbinpack/schema.json \
	| $(OUTPUT)/documents/%/jsonbinpack
	$(JSONBINPACK) compile $< > $@

$(OUTPUT)/documents/%/jsonbinpack/output.bin: \
	$(OUTPUT)/documents/%/jsonbinpack/input.json $(OUTPUT)/documents/%/jsonbinpack/encoding.json \
	| $(OUTPUT)/documents/%/jsonbinpack
	$(JSONBINPACK) serialize $(word 2,$^) $< > $@

$(OUTPUT)/documents/%/jsonbinpack/output.json: \
	$(OUTPUT)/documents/%/jsonbinpack/output.bin $(OUTPUT)/documents/%/jsonbinpack/encoding.json \
	| $(OUTPUT)/documents/%/jsonbinpack
	$(JSONBINPACK) deserialize $(word 2,$^) $< > $@

$(OUTPUT)/documents/%/jsonbinpack/VERSION: | $(OUTPUT)/documents/%/jsonbinpack
	$(JSONBINPACK) version > $@
