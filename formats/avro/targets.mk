$(OUTPUT)/documents/%/avro/output.bin: formats/avro/encode.py \
	$(OUTPUT)/documents/%/avro/input.json benchmark/%/avro/schema.json env \
	| $(OUTPUT)/documents/%/avro
	./$(word 4,$^)/bin/python $< $(word 2,$^) $(word 3,$^) $@

$(OUTPUT)/documents/%/avro/output.json: formats/avro/decode.py \
	$(OUTPUT)/documents/%/avro/output.bin benchmark/%/avro/schema.json env \
	| $(OUTPUT)/documents/%/avro
	./$(word 4,$^)/bin/python $< $(word 2,$^) $(word 3,$^) > $@

$(OUTPUT)/documents/%/avro/VERSION: env scripts/version.py | $(OUTPUT)/documents/%/avro
	./$</bin/python $(word 2,$^) avro > $@
