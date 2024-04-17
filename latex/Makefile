
include ../base.mk

.PHONY: preq
preq:
	$(call assert_command_exists,tlmgr)

.DEFAULT_GOAL := all
.PHONY: all
all: ;

.PHONY: install
install: preq
	for package in $$(cat packages); do \
		sudo tlmgr install $$package;         \
	done;
