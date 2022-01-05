$(OUTPUT)/documents/%/ubjson/output.bin: formats/ubjson/encode.py $(OUTPUT)/documents/%/ubjson/input.json
	$(PYTHON) $< $(word 2,$^) $@

$(OUTPUT)/documents/%/ubjson/output.json: formats/ubjson/decode.py $(OUTPUT)/documents/%/ubjson/output.bin
	$(PYTHON) $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/ubjson/VERSION:
	$(PYTHON) -c "import ubjson; print('py-ubjson', ubjson.__version__)" >> $@
