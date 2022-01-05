$(OUTPUT)/documents/%/capnproto/output.bin: \
	$(OUTPUT)/documents/%/capnproto/input.json benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert json:binary $(word 2,$^) Main < $(word 1,$^) > $@

$(OUTPUT)/documents/%/capnproto/output.json: \
	$(OUTPUT)/documents/%/capnproto/output.bin benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert binary:json $(word 2,$^) Main < $< > $@

$(OUTPUT)/documents/%/capnproto/VERSION:
	$(CAPNP) --version > $@
