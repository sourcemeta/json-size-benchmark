$(OUTPUT_DIRECTORY)/%/capnproto/output.bin: \
	$(OUTPUT_DIRECTORY)/%/capnproto/input.json benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert json:binary $(word 2,$^) Main < $(word 1,$^) > $@
	xxd $@

$(OUTPUT_DIRECTORY)/%/capnproto/output.json: \
	$(OUTPUT_DIRECTORY)/%/capnproto/output.bin benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert binary:json $(word 2,$^) Main < $< > $@
