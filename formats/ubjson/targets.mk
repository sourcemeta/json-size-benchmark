$(OUTPUT)/%/ubjson/output.bin: formats/ubjson/encode.py $(OUTPUT)/%/ubjson/input.json
	$(PYTHON) $< $(word 2,$^) $@

$(OUTPUT)/%/ubjson/output.json: formats/ubjson/decode.py $(OUTPUT)/%/ubjson/output.bin
	$(PYTHON) $< $(word 2,$^) > $@

$(OUTPUT)/%/ubjson/VERSION:
	$(PYTHON) -c "import ubjson; print('py-ubjson', ubjson.__version__)" >> $@
