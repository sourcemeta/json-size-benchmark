$(OUTPUT)/documents/%/avro/output.bin: formats/avro/encode.py \
	$(OUTPUT)/documents/%/avro/input.json benchmark/%/avro/schema.json \
	| $(OUTPUT)/documents/%/avro
	$(PYTHON) $< $(word 2,$^) $(word 3,$^) $@

$(OUTPUT)/documents/%/avro/output.json: formats/avro/decode.py \
	$(OUTPUT)/documents/%/avro/output.bin benchmark/%/avro/schema.json \
	| $(OUTPUT)/documents/%/avro
	$(PYTHON) $< $(word 2,$^) $(word 3,$^) > $@

$(OUTPUT)/documents/%/avro/VERSION: scripts/version.py | $(OUTPUT)/documents/%/avro
	$(PYTHON) $< avro > $@
