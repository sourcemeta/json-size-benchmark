$(OUTPUT)/documents/%/json/output.bin: $(OUTPUT)/documents/%/json/input.json \
	| $(OUTPUT)/documents/%/json
	$(JQ) -c '.' < $< > $@

$(OUTPUT)/documents/%/json/output.json: $(OUTPUT)/documents/%/json/output.bin \
	| $(OUTPUT)/documents/%/json
	$(JQ) '.' < $< > $@

$(OUTPUT)/documents/%/json/VERSION: | $(OUTPUT)/documents/%/json
	echo "ECMA-404" > $@
