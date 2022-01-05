$(OUTPUT)/compressors/gz: | $(OUTPUT)/compressors
	mkdir $@

%.gz: %
	$(GZIP) --no-name -9 < $< > $@

$(OUTPUT)/compressors/gz/VERSION: | $(OUTPUT)/compressors/gz
	gzip --version 2> $@
