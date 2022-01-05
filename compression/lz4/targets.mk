%.lz4: %
	$(LZ4) -f -12 $< $@

$(OUTPUT)/compressors/lz4/VERSION: | $(OUTPUT)/compressors/lz4
	lz4 --version > $@
