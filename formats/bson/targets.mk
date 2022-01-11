$(OUTPUT)/documents/%/bson/output.bin: formats/bson/encode.py $(OUTPUT)/documents/%/bson/input.json \
	| $(OUTPUT)/documents/%/bson
	$(PYTHON) $< $(word 2,$^) $@

$(OUTPUT)/documents/%/bson/output.json: formats/bson/decode.py $(OUTPUT)/documents/%/bson/output.bin \
	| $(OUTPUT)/documents/%/bson
	$(PYTHON) $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/bson/VERSION: | $(OUTPUT)/documents/%/bson
	$(PYTHON) --version > $@
	echo "pymongo" >> $@
