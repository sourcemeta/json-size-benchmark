# The Thrift compiler creates all these files
$(OUTPUT)/documents/%/thrift/__init__.py \
$(OUTPUT)/documents/%/thrift/schema/__init__.py \
$(OUTPUT)/documents/%/thrift/schema/constants.py \
$(OUTPUT)/documents/%/thrift/schema/ttypes.py: benchmark/%/thrift/schema.thrift \
	| $(OUTPUT)/documents/%/thrift
	$(THRIFT) --gen py -o $| -out $| $<

$(OUTPUT)/documents/%/thrift/output.bin: formats/thrift/encode.py \
	$(OUTPUT)/documents/%/thrift/input.json \
	env benchmark/%/thrift/run.py \
	$(OUTPUT)/documents/%/thrift/__init__.py \
	$(OUTPUT)/documents/%/thrift/schema/__init__.py \
	$(OUTPUT)/documents/%/thrift/schema/constants.py \
	$(OUTPUT)/documents/%/thrift/schema/ttypes.py \
	| $(OUTPUT)/documents/%/thrift
	PYTHONPATH="$(dir $(word 4,$^)):$(dir $@)" ./$(word 3,$^)/bin/python $< $(word 2,$^) $@

$(OUTPUT)/documents/%/thrift/output.json: formats/thrift/decode.py \
	$(OUTPUT)/documents/%/thrift/output.bin \
	env benchmark/%/thrift/run.py env \
	$(OUTPUT)/documents/%/thrift/__init__.py \
	$(OUTPUT)/documents/%/thrift/schema/__init__.py \
	$(OUTPUT)/documents/%/thrift/schema/constants.py \
	$(OUTPUT)/documents/%/thrift/schema/ttypes.py \
	| $(OUTPUT)/documents/%/thrift
	PYTHONPATH="$(dir $(word 4,$^)):$(dir $@)" ./$(word 3,$^)/bin/python $< $(word 2,$^) $@

$(OUTPUT)/documents/%/thrift/VERSION: | $(OUTPUT)/documents/%/thrift
	$(THRIFT) --version > $@
