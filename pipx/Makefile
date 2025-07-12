
include ../base.mk

.PHONY: preq
preq:
	$(call assert_command_exists,pipx)

.DEFAULT_GOAL := all
.PHONY: all
all: ;

.PHONY: install
install: preq
	for package in $$(cat packages); do \
		pipx install $$package;         \
	done;
