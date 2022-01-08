$(OUTPUT)/documents/%/messagepack/output.bin: $(OUTPUT)/documents/%/messagepack/input.json \
	| $(OUTPUT)/documents/%/messagepack
	$(JSON2MSGPACK) < $< > $@

$(OUTPUT)/documents/%/messagepack/output.json: $(OUTPUT)/documents/%/messagepack/output.bin \
	| $(OUTPUT)/documents/%/messagepack
	$(MSGPACK2JSON) < $< > $@

$(OUTPUT)/documents/%/messagepack/VERSION: | $(OUTPUT)/documents/%/messagepack
	$(MSGPACK2JSON) -v 2>&1 | head -n 1 > $@
