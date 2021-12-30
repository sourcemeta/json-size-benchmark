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

include compression/gz/targets.mk
include compression/lz4/targets.mk
include compression/lzma/targets.mk

#################################################
# VARIABLES
#################################################

OUTPUT ?= output

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
	$(RMRF) $(OUTPUT)

all: \
	$(OUTPUT)/circleciblank/capnproto/result.json \
	$(OUTPUT)/circleciblank/capnproto/output.bin \
	$(OUTPUT)/circleciblank/capnproto/output.bin.gz \
	$(OUTPUT)/circleciblank/capnproto/output.bin.lz4 \
	$(OUTPUT)/circleciblank/capnproto/output.bin.lzma

#################################################
# BENCHMARK
#################################################

# We programatically define these basic rule for every format as they are the
# base ones that requires two wildcards, which GNU Make doesn't support.
define COPY_FROM_BENCHMARK
$(OUTPUT)/%/$1/$2: benchmark/%/$2
	$(INSTALL) -d $$(dir $$@)
	$(INSTALL) -m 0664 $$< $$@
endef
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_FROM_BENCHMARK,$(format),document.json)))
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_FROM_BENCHMARK,$(format),NAME)))

# Provide default transformation JSON Patch documents
$(OUTPUT)/%/pre.patch.json:
	echo "[]" > $@
$(OUTPUT)/%/post.patch.json:
	echo "[]" > $@

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

# TODO: Make this rule get the size results for a SINGLE format
# When we merge the specific CSVs into a master one in another rule
$(OUTPUT)/%/size.txt: scripts/size.sh compression/ORDER $(OUTPUT)/%/output.bin \
	$(OUTPUT)/%/output.bin.gz $(OUTPUT)/%/output.bin.lz4 $(OUTPUT)/%/output.bin.lzma
	exec $< $(word 2,$^) $(dir $(word 3,$^)) > $@

include formats/capnproto/targets.mk
