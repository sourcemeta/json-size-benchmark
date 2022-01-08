$(OUTPUT)/documents/%/cbor/output.bin: formats/cbor/encode.py $(OUTPUT)/documents/%/cbor/input.json \
	| $(OUTPUT)/documents/%/cbor
	$(PYTHON) $< $(word 2,$^) $@

$(OUTPUT)/documents/%/cbor/output.json: formats/cbor/decode.py $(OUTPUT)/documents/%/cbor/output.bin \
	| $(OUTPUT)/documents/%/cbor
	$(PYTHON) $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/cbor/VERSION: scripts/version.py | $(OUTPUT)/documents/%/cbor
	$(PYTHON) $< cbor2 >> $@
