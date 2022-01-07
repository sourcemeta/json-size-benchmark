$(OUTPUT)/documents/%/ubjson/output.bin: formats/ubjson/encode.py $(OUTPUT)/documents/%/ubjson/input.json \
	| $(OUTPUT)/documents/%/ubjson
	$(PYTHON) $< $(word 2,$^) $@

$(OUTPUT)/documents/%/ubjson/output.json: formats/ubjson/decode.py $(OUTPUT)/documents/%/ubjson/output.bin \
	| $(OUTPUT)/documents/%/ubjson
	$(PYTHON) $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/ubjson/VERSION: | $(OUTPUT)/documents/%/ubjson
	$(PYTHON) -c "import ubjson; print('py-ubjson', ubjson.__version__)" >> $@
