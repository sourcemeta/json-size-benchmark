%.gz: %
	$(GZIP) --no-name -9 < $< > $@

%.lz4: %
	$(LZ4) -f -9 $< $@

%.lzma: %
	$(LZMA) -9 --stdout < $< > $@
