%.lzma: %
	$(LZMA) -9 --stdout < $< > $@
