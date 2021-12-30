output/%/capnproto/output.bin: output/%/capnproto/encode.json benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert json:binary $(word 2,$^) Main < $(word 1,$^) > $@
	xxd $@

output/%/capnproto/decode.json: output/%/capnproto/output.bin benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert binary:json $(word 2,$^) Main < $< > $@
