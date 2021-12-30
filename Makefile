.PHONY: lint clean all
.DEFAULT_GOAL = all

#################################################
# PROGRAMS
#################################################

NODE ?= node
NPM ?= npm
PYTHON ?= python3
CAPNP ?= capnp
GZIP ?= gzip
LZ4 ?= lz4
LZMA ?= lzma
SHELLCHECK ?= shellcheck

#################################################
# TOP LEVEL INCLUDES
#################################################

include compression/gzip/targets.mk
include compression/lz4/targets.mk
include compression/lzma/targets.mk

#################################################
# VARIABLES
#################################################

ALL_FORMATS = $(notdir $(wildcard base/*))
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

# We programatically define this rule for every format as it is the
# base one that requires two wildcards, which GNU Make doesn't support.
define RULE_PREPARE_DOCUMENT
output/%/$1/document.json: benchmark/%/document.json
	mkdir -p $$(dir $$@)
	cp $$< $$@
endef
$(foreach format,$(ALL_FORMATS),$(eval $(call RULE_PREPARE_DOCUMENT,$(format))))

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
	cp $(word 2,$^) $@

include base/capnproto/targets.mk
