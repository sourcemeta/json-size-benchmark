.PHONY: lint clean all
.DEFAULT_GOAL = all

#################################################
# PROGRAMS
#################################################

NODE ?= node
NPM ?= npm
PYTHON ?= python3
INSTALL ?= install
SHELLCHECK ?= shellcheck
RMRF ?= rm -rf

CAPNP ?= capnp
GZIP ?= gzip
LZ4 ?= lz4
LZMA ?= lzma

#################################################
# TOP LEVEL INCLUDES
#################################################

include compression/gzip/targets.mk
include compression/lz4/targets.mk
include compression/lzma/targets.mk

#################################################
# VARIABLES
#################################################

OUTPUT_DIRECTORY ?= output

ALL_FORMATS = $(filter-out ORDER,$(notdir $(wildcard formats/*)))
FORMATS ?= $(ALL_FORMATS)

ALL_DOCUMENTS = $(notdir $(wildcard benchmark/*))
DOCUMENTS ?= $(ALL_DOCUMENTS)

#################################################
# PHONY TARGETS
#################################################

node_modules: package.json package-lock.json
	$(NPM) ci

lint: node_modules
	$(NODE) ./node_modules/.bin/standard scripts/**/*.js
	$(SHELLCHECK) scripts/*.sh

clean:
	$(RMRF) $(OUTPUT_DIRECTORY)

all: \
	$(OUTPUT_DIRECTORY)/circleciblank/capnproto/result.json \
	$(OUTPUT_DIRECTORY)/circleciblank/capnproto/output.bin \
	$(OUTPUT_DIRECTORY)/circleciblank/capnproto/output.bin.gz \
	$(OUTPUT_DIRECTORY)/circleciblank/capnproto/output.bin.lz4 \
	$(OUTPUT_DIRECTORY)/circleciblank/capnproto/output.bin.lzma

#################################################
# BENCHMARK
#################################################

# We programatically define these basic rule for every format as they are the
# base ones that requires two wildcards, which GNU Make doesn't support.
define COPY_FROM_BENCHMARK
$(OUTPUT_DIRECTORY)/%/$1/$2: benchmark/%/$2
	$(INSTALL) -d $$(dir $$@)
	$(INSTALL) -m 0664 $$< $$@
endef
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_FROM_BENCHMARK,$(format),document.json)))
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_FROM_BENCHMARK,$(format),NAME)))

# Provide default transformation JSON Patch documents
$(OUTPUT_DIRECTORY)/%/pre.patch.json:
	echo "[]" > $@
$(OUTPUT_DIRECTORY)/%/post.patch.json:
	echo "[]" > $@

$(OUTPUT_DIRECTORY)/%/input.json: scripts/jsonpatch.js \
	$(OUTPUT_DIRECTORY)/%/document.json $(OUTPUT_DIRECTORY)/%/pre.patch.json
	$(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT_DIRECTORY)/%/decode.json: scripts/jsonpatch.js \
	$(OUTPUT_DIRECTORY)/%/output.json $(OUTPUT_DIRECTORY)/%/post.patch.json
	$(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
$(OUTPUT_DIRECTORY)/%/result.json: scripts/json-equals.py \
	$(OUTPUT_DIRECTORY)/%/decode.json $(OUTPUT_DIRECTORY)/%/document.json
	$(PYTHON) $< $(word 2,$^) $(word 3,$^)
	$(INSTALL) -m 0664 $(word 2,$^) $@

# TODO: Make this rule get the size results for a SINGLE format
# When we merge the specific CSVs into a master one in another rule
$(OUTPUT_DIRECTORY)/%/size.csv: \
	compression/ORDER \
	$(OUTPUT_DIRECTORY)/%/NAME \
	$(OUTPUT_DIRECTORY)/%/output.bin \
	$(OUTPUT_DIRECTORY)/%/output.bin.gz \
	$(OUTPUT_DIRECTORY)/%/output.bin.lz4 \
	$(OUTPUT_DIRECTORY)/%/output.bin.lzma
	echo $(dir $@)

include formats/capnproto/targets.mk
