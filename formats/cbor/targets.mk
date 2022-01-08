$(OUTPUT)/documents/%/cbor/output.bin: formats/cbor/encode.py $(OUTPUT)/documents/%/cbor/input.json env \
	| $(OUTPUT)/documents/%/cbor
	./$(word 3,$^)/bin/python $< $(word 2,$^) $@

$(OUTPUT)/documents/%/cbor/output.json: formats/cbor/decode.py $(OUTPUT)/documents/%/cbor/output.bin env \
	| $(OUTPUT)/documents/%/cbor
	./$(word 3,$^)/bin/python $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/cbor/VERSION: env scripts/version.py | $(OUTPUT)/documents/%/cbor
	./$</bin/python $(word 2,$^) cbor2 > $@
