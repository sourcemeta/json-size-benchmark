.PHONY: lint clean

#################################################
# PROGRAMS 
#################################################

NODE ?= node
NPM ?= npm
PYTHON ?= python3
CAPNP ?= capnp

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

clean:
	rm -rf output

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
