
include ../base.mk

.PHONY: preq
preq:
	$(call assert_command_exists,mas)

.DEFAULT_GOAL := all
.PHONY: all
all: ;

.PHONY: install
install: preq
	# mas list
	for app in $$(cat apps | tr -s ' ' | cut -d ' ' -f 1); do \
		mas install $$app; \
	done;
