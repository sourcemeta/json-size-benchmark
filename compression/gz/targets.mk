%.gz: %
	$(GZIP) --no-name -9 < $< > $@

$(OUTPUT)/compressors/gz/VERSION: | $(OUTPUT)/compressors/gz
	$(GZIP) --version 2> $@
