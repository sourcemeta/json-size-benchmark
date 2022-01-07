$(OUTPUT)/documents/%/capnproto/output.bin: \
	$(OUTPUT)/documents/%/capnproto/input.json benchmark/%/capnproto/schema.capnp \
	| $(OUTPUT)/documents/%/capnproto
	$(CAPNP) convert json:binary $(word 2,$^) Main < $(word 1,$^) > $@

$(OUTPUT)/documents/%/capnproto/output.json: \
	$(OUTPUT)/documents/%/capnproto/output.bin benchmark/%/capnproto/schema.capnp \
	| $(OUTPUT)/documents/%/capnproto
	$(CAPNP) convert binary:json $(word 2,$^) Main < $< > $@

$(OUTPUT)/documents/%/capnproto/VERSION: | $(OUTPUT)/documents/%/capnproto
	$(CAPNP) --version > $@
