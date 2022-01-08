$(OUTPUT)/documents/%/capnproto-packed/output.bin: \
	$(OUTPUT)/documents/%/capnproto-packed/input.json benchmark/%/capnproto-packed/schema.capnp \
	| $(OUTPUT)/documents/%/capnproto-packed
	$(CAPNP) convert json:packed $(word 2,$^) Main < $(word 1,$^) > $@

$(OUTPUT)/documents/%/capnproto-packed/output.json: \
	$(OUTPUT)/documents/%/capnproto-packed/output.bin benchmark/%/capnproto-packed/schema.capnp \
	| $(OUTPUT)/documents/%/capnproto-packed
	$(CAPNP) convert packed:json $(word 2,$^) Main < $< > $@

$(OUTPUT)/documents/%/capnproto-packed/VERSION: | $(OUTPUT)/documents/%/capnproto-packed
	$(CAPNP) --version > $@
