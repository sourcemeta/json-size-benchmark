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
	rm -rf output

all: \
	output/circleciblank/capnproto/result.json \
	output/circleciblank/capnproto/output.bin \
	output/circleciblank/capnproto/output.bin.gz \
	output/circleciblank/capnproto/output.bin.lz4 \
	output/circleciblank/capnproto/output.bin.lzma

#################################################
# BENCHMARK
#################################################

# We programatically define these basic rule for every format as they are the
# base ones that requires two wildcards, which GNU Make doesn't support.
define COPY_FROM_BENCHMARK
output/%/$1/$2: benchmark/%/$2
	$(INSTALL) -d $$(dir $$@)
	$(INSTALL) -m 0664 $$< $$@
endef
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_FROM_BENCHMARK,$(format),document.json)))
$(foreach format,$(ALL_FORMATS),$(eval $(call COPY_FROM_BENCHMARK,$(format),NAME)))

# Provide default transformation JSON Patch documents
output/%/pre.patch.json:
	echo "[]" > $@
output/%/post.patch.json:
	echo "[]" > $@

output/%/input.json: scripts/jsonpatch.js output/%/document.json output/%/pre.patch.json
	$(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
output/%/decode.json: scripts/jsonpatch.js output/%/output.json output/%/post.patch.json
	$(NODE) $< $(word 3,$^) < $(word 2,$^) > $@
output/%/result.json: scripts/json-equals.py output/%/decode.json output/%/document.json
	$(PYTHON) $< $(word 2,$^) $(word 3,$^)
	$(INSTALL) -m 0664 $(word 2,$^) $@

# TODO: Make this rule get the size results for a SINGLE format
# When we merge the specific CSVs into a master one in another rule
output/%/size.csv: \
	compression/ORDER \
	output/%/NAME \
	output/%/output.bin \
	output/%/output.bin.gz \
	output/%/output.bin.lz4 \
	output/%/output.bin.lzma
	echo $(dir $@)

include formats/capnproto/targets.mk
