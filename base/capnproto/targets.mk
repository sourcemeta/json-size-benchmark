output/%/capnproto/output.bin: output/%/capnproto/encode.json benchmark/%/capnproto/schema.capnp
	$(CAPNP) convert json:binary $(word 2,$^) Main < $(word 1,$^) > $@
	xxd $@
