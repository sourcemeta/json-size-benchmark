$(OUTPUT)/documents/%/smile/output.bin: formats/smile/encode.clj $(OUTPUT)/documents/%/smile/input.json \
	| $(OUTPUT)/documents/%/smile
	JSON_FILE="$(abspath $(word 2,$^))" OUTPUT_FILE="$(abspath $@)" clj -M $<

$(OUTPUT)/documents/%/smile/output.json: formats/smile/decode.clj $(OUTPUT)/documents/%/smile/output.bin \
	| $(OUTPUT)/documents/%/smile
	INPUT_FILE="$(abspath $(word 2,$^))" clj -M $< > $(abspath $@)

# TODO: Is there a more standard way to this in Clojure?
$(OUTPUT)/documents/%/smile/VERSION: deps.edn | $(OUTPUT)/documents/%/smile
	$(PRINTF) "cheshire " > $@
	$(CUT) -d '"' -f 2 < $< >> $@
