%.gz: %
	$(GZIP) --no-name -9 < $< > $@
