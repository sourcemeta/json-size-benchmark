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
	$(OUTPUT)/circleciblank/capnproto/result.json \
	$(OUTPUT)/circleciblank/flatbuffers/result.json \
	$(OUTPUT)/circleciblank/json/result.json \
	$(OUTPUT)/circleciblank/ubjson/result.json \
	$(OUTPUT)/circleciblank/capnproto/VERSION \
	$(OUTPUT)/circleciblank/flatbuffers/VERSION \
	$(OUTPUT)/circleciblank/json/VERSION \
	$(OUTPUT)/circleciblank/ubjson/VERSION \
	$(OUTPUT)/circleciblank/data.json

#################################################
# PRELUDE
#################################################

# We programatically define these basic rule for every format as they are the
# base ones that requires two wildcards, which GNU Make doesn't support.
define COPY_TO_OUTPUT
$(OUTPUT)/%/$1/$2: $3
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
$(OUTPUT)/%/pre.patch.json:
	exec echo "[]" > $@
$(OUTPUT)/%/post.patch.json:
	exec echo "[]" > $@

$(OUTPUT)/%/input.json: scripts/jsonpatch.js \
	$(OUTPUT)/%/document.json $(OUTPUT)/%/pre.patch.json node_modules
	$(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT)/%/decode.json: scripts/jsonpatch.js \
	$(OUTPUT)/%/output.json $(OUTPUT)/%/post.patch.json node_modules
	$(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT)/%/result.json: scripts/json-equals.py \
	$(OUTPUT)/%/decode.json $(OUTPUT)/%/document.json
	$(PYTHON) $< $(word 2,$^) $(word 3,$^)
	$(INSTALL) -m 0664 $(word 2,$^) $@

$(OUTPUT)/%/size.json: scripts/size.js $(OUTPUT)/%/output.bin $(OUTPUT)/%/NAME \
	$(foreach compressor,$(ALL_COMPRESSORS),$(addsuffix .$(compressor),$(OUTPUT)/%/output.bin))
	exec $(NODE) $< $(word 2,$^) "$(shell cat $(word 3,$^))" $(COMPRESSORS) > $@

$(OUTPUT)/%/data.json: scripts/data.js benchmark/%/NAME \
	$(addsuffix /NAME,$(addprefix compression/,$(COMPRESSORS))) \
	$(addsuffix /size.json,$(addprefix output/%/,$(FORMATS)))
	exec $(NODE) $< "$(shell cat $(word 2,$^))" $(addsuffix /size.json,$(addprefix $(dir $@),$(FORMATS))) > $@
