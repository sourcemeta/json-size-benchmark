$(OUTPUT)/documents/%/protobuf/schema_pb2.py: benchmark/%/protobuf/schema.proto \
	| $(OUTPUT)/documents/%/protobuf
	$(PROTOC) --experimental_allow_proto3_optional -I$(dir $<) --python_out=$(dir $@) $<

$(OUTPUT)/documents/%/protobuf/output.bin: formats/protobuf/encode.py \
	$(OUTPUT)/documents/%/protobuf/input.json $(OUTPUT)/documents/%/protobuf/schema_pb2.py \
	benchmark/%/protobuf/run.py env \
	| $(OUTPUT)/documents/%/protobuf
	PYTHONPATH="$(dir $(word 3,$^)):$(dir $(word 4,$^))" ./env/bin/python $< $(word 2,$^) $@

$(OUTPUT)/documents/%/protobuf/output.json: formats/protobuf/decode.py \
	$(OUTPUT)/documents/%/protobuf/output.bin $(OUTPUT)/documents/%/protobuf/schema_pb2.py \
	benchmark/%/protobuf/run.py env \
	| $(OUTPUT)/documents/%/protobuf
	PYTHONPATH="$(dir $(word 3,$^)):$(dir $(word 4,$^))" ./env/bin/python $< $(word 2,$^) $@

$(OUTPUT)/documents/%/protobuf/VERSION: | $(OUTPUT)/documents/%/protobuf
	$(PROTOC) --version > $@
