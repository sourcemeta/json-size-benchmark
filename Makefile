.PHONY: lint clean

#################################################
# PROGRAMS 
#################################################

NODE ?= node
NPM ?= npm

CAPNP ?= capnp

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
# VARIABLES 
#################################################

ALL_FORMATS = $(notdir $(wildcard base/*))
FORMATS ?= $(ALL_FORMATS)

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
benchmark/%/pre.patch.json:
	echo "[]" > $@
benchmark/%/post.patch.json:
	echo "[]" > $@

output/%/encode.json: output/%/document.json benchmark/%/pre.patch.json
	$(NODE) scripts/jsonpatch.js $(word 2,$^) < $< > $@

include base/capnproto/targets.mk
