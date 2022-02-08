$(OUTPUT)/documents/%/jsonbinpack-schemaless/encoding.json: benchmark/%/jsonbinpack-schemaless/schema.json \
	| $(OUTPUT)/documents/%/jsonbinpack-schemaless
	$(JSONBINPACK) compile $< > $@

$(OUTPUT)/documents/%/jsonbinpack-schemaless/output.bin: \
	$(OUTPUT)/documents/%/jsonbinpack-schemaless/input.json $(OUTPUT)/documents/%/jsonbinpack-schemaless/encoding.json \
	| $(OUTPUT)/documents/%/jsonbinpack-schemaless
	$(JSONBINPACK) serialize $(word 2,$^) $< > $@

$(OUTPUT)/documents/%/jsonbinpack-schemaless/output.json: \
	$(OUTPUT)/documents/%/jsonbinpack-schemaless/output.bin $(OUTPUT)/documents/%/jsonbinpack-schemaless/encoding.json \
	| $(OUTPUT)/documents/%/jsonbinpack-schemaless
	$(JSONBINPACK) deserialize $(word 2,$^) $< > $@

$(OUTPUT)/documents/%/jsonbinpack-schemaless/VERSION: | $(OUTPUT)/documents/%/jsonbinpack-schemaless
	$(JSONBINPACK) version > $@
