.PHONY: lint clean distclean all
.DEFAULT_GOAL = all

#################################################
# PROGRAMS
#################################################

NODE ?= node
NPM ?= npm
PYTHON ?= python3
INSTALL ?= install
RMRF ?= rm -rf
MKDIR ?= mkdir

CAPNP ?= capnp
FLATC ?= flatc
GZIP ?= gzip
LZ4 ?= lz4
LZMA ?= lzma

#################################################
# VARIABLES
#################################################

OUTPUT ?= output

ALL_FORMATS = $(notdir $(wildcard formats/*))
FORMATS ?= $(ALL_FORMATS)

ALL_DOCUMENTS = $(notdir $(wildcard benchmark/*))
DOCUMENTS ?= $(ALL_DOCUMENTS)

ALL_COMPRESSORS = $(notdir $(wildcard compression/*))
COMPRESSORS ?= $(ALL_COMPRESSORS)

#################################################
# PHONY TARGETS
#################################################

env: requirements.txt
	$(PYTHON) -m venv --clear $@
	./$@/bin/python3 -m pip install --requirement $<

node_modules: package.json package-lock.json
	exec $(NPM) ci

lint: node_modules env
	$(NODE) ./node_modules/.bin/standard scripts/**/*.js web/**/*.js
	./$(word 2,$^)/bin/python3 -m flake8 scripts/*.py formats/**/*.py

clean:
	exec $(RMRF) $(OUTPUT)

distclean: clean
	exec $(RMRF) node_modules env

all: lint $(OUTPUT)/index.html

#################################################
# PRELUDE
#################################################

# Create output directory structure
$(OUTPUT):
	mkdir $@
define MAKE_DIRECTORY
$1/$2: | $1; exec $(MKDIR) $$@
endef
$(eval $(call MAKE_DIRECTORY,$(OUTPUT),documents))
$(eval $(call MAKE_DIRECTORY,$(OUTPUT),compressors))
$(foreach compressor,$(ALL_COMPRESSORS),$(eval $(call MAKE_DIRECTORY,$(OUTPUT)/compressors,$(compressor))))
$(foreach document,$(ALL_DOCUMENTS),$(eval $(call MAKE_DIRECTORY,$(OUTPUT)/documents,$(document))))
$(foreach document,$(ALL_DOCUMENTS),$(foreach format,$(ALL_FORMATS),$(eval $(call MAKE_DIRECTORY,$(OUTPUT)/documents/$(document),$(format)))))

# We programatically define these basic rule for every format as they are the
# base ones that requires two wildcards, which GNU Make doesn't support.
define COPY_TO_OUTPUT
$(OUTPUT)/documents/%/$1/$2: $3 | $(OUTPUT)/documents/%/$1
	exec $(INSTALL) -m 0664 $$< $$@
endef
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_TO_OUTPUT,$(format),document.json,benchmark/%/document.json)))
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_TO_OUTPUT,$(format),NAME,formats/$(format)/NAME)))

#################################################
# BENCHMARK
#################################################

include compression/gz/targets.mk
include compression/lz4/targets.mk
include compression/lzma/targets.mk

include formats/capnproto/targets.mk
include formats/flatbuffers/targets.mk
include formats/json/targets.mk
include formats/ubjson/targets.mk
include formats/cbor/targets.mk

# Provide default transformation JSON Patch documents
$(OUTPUT)/documents/%/pre.patch.json: | $(OUTPUT)/documents/%
	exec echo "[]" > $@
$(OUTPUT)/documents/%/post.patch.json: | $(OUTPUT)/documents/%
	exec echo "[]" > $@

$(OUTPUT)/documents/%/input.json: scripts/jsonpatch.js \
	$(OUTPUT)/documents/%/document.json $(OUTPUT)/documents/%/pre.patch.json node_modules \
	| $(OUTPUT)/documents/%
	exec $(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT)/documents/%/decode.json: scripts/jsonpatch.js \
	$(OUTPUT)/documents/%/output.json $(OUTPUT)/documents/%/post.patch.json node_modules \
	| $(OUTPUT)/documents/%
	exec $(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT)/documents/%/result.json: scripts/json-equals.py \
	$(OUTPUT)/documents/%/decode.json $(OUTPUT)/documents/%/document.json \
	| $(OUTPUT)/documents/%
	$(PYTHON) $< $(word 2,$^) $(word 3,$^)
	$(INSTALL) -m 0664 $(word 2,$^) $@

# This target ensures that the result is validated against the original input
$(OUTPUT)/documents/%/size.json: scripts/size.js \
	$(OUTPUT)/documents/%/output.bin $(OUTPUT)/documents/%/NAME $(OUTPUT)/documents/%/VERSION \
	$(foreach compressor,$(ALL_COMPRESSORS),$(addsuffix .$(compressor),$(OUTPUT)/documents/%/output.bin)) \
	$(OUTPUT)/documents/%/result.json \
	| $(OUTPUT)/documents/%
	exec $(NODE) $< $(word 2,$^) "$(shell cat $(word 3,$^))" "$(shell cat $(word 4,$^))" $(COMPRESSORS) > $@

$(OUTPUT)/documents/%/data.json: scripts/data.js benchmark/%/NAME \
	$(addsuffix /NAME,$(addprefix compression/,$(COMPRESSORS))) \
	$(addsuffix /VERSION,$(addprefix output/compressors/,$(COMPRESSORS))) \
	$(addsuffix /size.json,$(addprefix output/documents/%/,$(FORMATS))) \
	| $(OUTPUT)/documents/%
	exec $(NODE) $< "$(shell cat $(word 2,$^))" $(notdir $(realpath $(dir $(word 2,$^)))) \
		$(addsuffix /size.json,$(addprefix $(dir $@),$(FORMATS))) > $@

$(OUTPUT)/documents/aggregate.json: scripts/concat.js \
	$(addsuffix /data.json,$(addprefix output/documents/,$(DOCUMENTS))) \
	| $(OUTPUT)/documents
	exec $(NODE) $^ > $@

#################################################
# WEB
#################################################

$(OUTPUT)/app.min.js: web/app.js node_modules | $(OUTPUT)
	exec ./node_modules/.bin/esbuild --bundle $< --outfile=$@ --minify \
		--target=safari11

$(OUTPUT)/style.min.css: node_modules/simpledotcss/simple.min.css | $(OUTPUT)
	$(INSTALL) -m 0644 $< $@

$(OUTPUT)/index.html: scripts/template.js \
	web/index.tpl.html $(OUTPUT)/documents/aggregate.json \
	node_modules package.json $(OUTPUT)/app.min.js $(OUTPUT)/style.min.css \
	| $(OUTPUT)
	exec $(NODE) $< $(word 2,$^) $(word 3,$^) > $@
