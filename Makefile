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
	$(NODE) ./node_modules/.bin/standard scripts/**/*.js
	./$(word 2,$^)/bin/python3 -m flake8 scripts/*.py formats/**/*.py

clean:
	exec $(RMRF) $(OUTPUT)

distclean: clean
	exec $(RMRF) node_modules env

all: lint \
	$(OUTPUT)/documents/circleciblank/capnproto/result.json \
	$(OUTPUT)/documents/circleciblank/flatbuffers/result.json \
	$(OUTPUT)/documents/circleciblank/json/result.json \
	$(OUTPUT)/documents/circleciblank/ubjson/result.json \
	$(OUTPUT)/documents/circleciblank/capnproto/VERSION \
	$(OUTPUT)/documents/circleciblank/flatbuffers/VERSION \
	$(OUTPUT)/documents/circleciblank/json/VERSION \
	$(OUTPUT)/documents/circleciblank/ubjson/VERSION \
	$(OUTPUT)/documents/circleciblank/data.json

#################################################
# PRELUDE
#################################################

# We programatically define these basic rule for every format as they are the
# base ones that requires two wildcards, which GNU Make doesn't support.
define COPY_TO_OUTPUT
$(OUTPUT)/documents/%/$1/$2: $3
	$(INSTALL) -d $$(dir $$@)
	$(INSTALL) -m 0664 $$< $$@
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

# Provide default transformation JSON Patch documents
$(OUTPUT)/documents/%/pre.patch.json:
	exec echo "[]" > $@
$(OUTPUT)/documents/%/post.patch.json:
	exec echo "[]" > $@

$(OUTPUT)/documents/%/input.json: scripts/jsonpatch.js \
	$(OUTPUT)/documents/%/document.json $(OUTPUT)/documents/%/pre.patch.json node_modules
	exec $(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT)/documents/%/decode.json: scripts/jsonpatch.js \
	$(OUTPUT)/documents/%/output.json $(OUTPUT)/documents/%/post.patch.json node_modules
	exec $(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT)/documents/%/result.json: scripts/json-equals.py \
	$(OUTPUT)/documents/%/decode.json $(OUTPUT)/documents/%/document.json
	$(PYTHON) $< $(word 2,$^) $(word 3,$^)
	$(INSTALL) -m 0664 $(word 2,$^) $@

$(OUTPUT)/documents/%/size.json: scripts/size.js $(OUTPUT)/documents/%/output.bin $(OUTPUT)/documents/%/NAME \
	$(foreach compressor,$(ALL_COMPRESSORS),$(addsuffix .$(compressor),$(OUTPUT)/documents/%/output.bin))
	exec $(NODE) $< $(word 2,$^) "$(shell cat $(word 3,$^))" $(COMPRESSORS) > $@

$(OUTPUT)/documents/%/data.json: scripts/data.js benchmark/%/NAME \
	$(addsuffix /NAME,$(addprefix compression/,$(COMPRESSORS))) \
	$(addsuffix /size.json,$(addprefix output/documents/%/,$(FORMATS)))
	exec $(NODE) $< "$(shell cat $(word 2,$^))" $(addsuffix /size.json,$(addprefix $(dir $@),$(FORMATS))) > $@
