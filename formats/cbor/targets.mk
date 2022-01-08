$(OUTPUT)/documents/%/cbor/output.bin: formats/cbor/encode.py $(OUTPUT)/documents/%/cbor/input.json \
	| $(OUTPUT)/documents/%/cbor
	$(PYTHON) $< $(word 2,$^) $@

$(OUTPUT)/documents/%/cbor/output.json: formats/cbor/decode.py $(OUTPUT)/documents/%/cbor/output.bin \
	| $(OUTPUT)/documents/%/cbor
	$(PYTHON) $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/cbor/VERSION: | $(OUTPUT)/documents/%/cbor
	$(PYTHON) -c "import pkg_resources; print('cbor2', pkg_resources.get_distribution('cbor2').version)" >> $@
