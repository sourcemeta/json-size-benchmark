$(OUTPUT)/documents/%/messagepack/output.bin: formats/messagepack/encode.py $(OUTPUT)/documents/%/messagepack/input.json \
	| $(OUTPUT)/documents/%/messagepack
	$(PYTHON) $< $(word 2,$^) $@

$(OUTPUT)/documents/%/messagepack/output.json: formats/messagepack/decode.py $(OUTPUT)/documents/%/messagepack/output.bin \
	| $(OUTPUT)/documents/%/messagepack
	$(PYTHON) $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/messagepack/VERSION: scripts/version.py | $(OUTPUT)/documents/%/messagepack
	$(PYTHON) $< msgpack > $@
