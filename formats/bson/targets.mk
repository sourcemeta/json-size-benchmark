$(OUTPUT)/documents/%/bson/output.bin: formats/bson/encode.js $(OUTPUT)/documents/%/bson/input.json node_modules \
	| $(OUTPUT)/documents/%/bson
	$(NODE) $< $(word 2,$^) $@

$(OUTPUT)/documents/%/bson/output.json: formats/bson/decode.js $(OUTPUT)/documents/%/bson/output.bin node_modules \
	| $(OUTPUT)/documents/%/bson
	$(NODE) $< $(word 2,$^) > $@

$(OUTPUT)/documents/%/bson/VERSION: | $(OUTPUT)/documents/%/bson
	$(NODE) --eval "console.log('bson', require('./node_modules/bson/package.json').version)" > $@
