%.lzma: %
	$(LZMA) -9 --stdout < $< > $@

$(OUTPUT)/compressors/lzma/VERSION: | $(OUTPUT)/compressors/lzma
	lzma --version > $@
