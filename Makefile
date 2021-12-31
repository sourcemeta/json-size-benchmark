.PHONY: lint clean distclean test all
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
FLATC ?= flatc
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

ALL_COMPRESSORS = $(filter-out ORDER,$(notdir $(wildcard compression/*)))
COMPRESSORS ?= $(ALL_COMPRESSORS)

#################################################
# PHONY TARGETS
#################################################

node_modules: package.json package-lock.json
	exec $(NPM) ci

lint: node_modules
	$(NODE) ./node_modules/.bin/standard scripts/**/*.js
	$(SHELLCHECK) scripts/*.sh test/*.sh

clean:
	exec $(RMRF) $(OUTPUT)

distclean: clean
	exec $(RMRF) node_modules

test:
	./test/formats-total-order.sh
	./test/compression-total-order.sh

all: lint test \
	$(OUTPUT)/circleciblank/capnproto/result.json \
	$(OUTPUT)/circleciblank/flatbuffers/result.json \
	$(OUTPUT)/circleciblank/json/result.json \
	$(OUTPUT)/circleciblank/capnproto/VERSION \
	$(OUTPUT)/circleciblank/flatbuffers/VERSION \
	$(OUTPUT)/circleciblank/json/VERSION \
	$(OUTPUT)/circleciblank/data.csv

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

$(OUTPUT)/%/size.txt: scripts/size.sh compression/ORDER $(OUTPUT)/%/output.bin \
	$(foreach compressor,$(ALL_COMPRESSORS),$(addsuffix .$(compressor),$(OUTPUT)/%/output.bin))
	exec $< $(word 2,$^) $(word 3,$^) > $@

$(OUTPUT)/%/data.csv: scripts/csv.sh formats/ORDER compression/ORDER \
	$(addsuffix /NAME,$(addprefix compression/,$(COMPRESSORS))) \
	$(addsuffix /NAME,$(addprefix formats/,$(FORMATS))) \
	$(addsuffix /size.txt,$(addprefix output/%/,$(FORMATS)))
	exec $< $(word 2,$^) $(word 3,$^) $(dir $@) > $@

include formats/capnproto/targets.mk
include formats/flatbuffers/targets.mk
include formats/json/targets.mk
