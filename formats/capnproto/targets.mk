$(OUTPUT)/%/capnproto/output.bin: \
	$(OUTPUT)/%/capnproto/input.json benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert json:binary $(word 2,$^) Main < $(word 1,$^) > $@

$(OUTPUT)/%/capnproto/output.json: \
	$(OUTPUT)/%/capnproto/output.bin benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert binary:json $(word 2,$^) Main < $< > $@
