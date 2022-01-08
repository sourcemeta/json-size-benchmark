$(OUTPUT)/documents/%/ubjson/output.bin: formats/ubjson/encode.py $(OUTPUT)/documents/%/ubjson/input.json env \
	| $(OUTPUT)/documents/%/ubjson
	./$(word 3,$^)/bin/python $< $(word 2,$^) $@

$(OUTPUT)/documents/%/ubjson/output.json: formats/ubjson/decode.py $(OUTPUT)/documents/%/ubjson/output.bin env \
	| $(OUTPUT)/documents/%/ubjson
	./$(word 3,$^)/bin/python $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/ubjson/VERSION: env scripts/version.py | $(OUTPUT)/documents/%/ubjson
	./$</bin/python $(word 2,$^) py-ubjson > $@
