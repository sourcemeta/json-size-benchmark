$(OUTPUT)/documents/%/avro/output.bin: formats/avro/encode.py \
	$(OUTPUT)/documents/%/avro/input.json benchmark/%/avro/schema.json \
	| $(OUTPUT)/documents/%/avro
	$(PYTHON) $< $(word 2,$^) $(word 3,$^) $@

$(OUTPUT)/documents/%/avro/output.json: formats/avro/decode.py \
	$(OUTPUT)/documents/%/avro/output.bin benchmark/%/avro/schema.json \
	| $(OUTPUT)/documents/%/avro
	$(PYTHON) $< $(word 2,$^) $(word 3,$^) > $@

$(OUTPUT)/documents/%/avro/VERSION: | $(OUTPUT)/documents/%/avro
	$(PYTHON) -c "import avro; print('avro', avro.__version__)" > $@
