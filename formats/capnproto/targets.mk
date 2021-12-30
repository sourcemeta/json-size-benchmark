output/%/capnproto/output.bin: output/%/capnproto/input.json benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert json:binary $(word 2,$^) Main < $(word 1,$^) > $@
	xxd $@

output/%/capnproto/output.json: output/%/capnproto/output.bin benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert binary:json $(word 2,$^) Main < $< > $@
