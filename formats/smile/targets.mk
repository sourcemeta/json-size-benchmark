$(OUTPUT)/documents/%/smile/output.bin: formats/smile/encode.clj $(OUTPUT)/documents/%/smile/input.json \
	| $(OUTPUT)/documents/%/smile
	JSON_FILE=$(word 2,$^) OUTPUT_FILE=$@ \
		$(JAVA) -cp /usr/share/java/cheshire.jar:/usr/share/java/clojure.jar clojure.main $<

$(OUTPUT)/documents/%/smile/output.json: formats/smile/decode.clj $(OUTPUT)/documents/%/smile/output.bin \
	| $(OUTPUT)/documents/%/smile
	INPUT_FILE=$(word 2,$^) \
		$(JAVA) -cp /usr/share/java/cheshire.jar:/usr/share/java/clojure.jar clojure.main $< > $@

$(OUTPUT)/documents/%/smile/VERSION: | $(OUTPUT)/documents/%/smile
	echo "XXX" > $@
