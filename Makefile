
include base.mk

DIRS = $(wildcard */)

define mapdirs
@for dir in $(DIRS); do \
	if grep -q $(1): $${dir%/}/Makefile; then \
		echo "\nmake -C $$dir $(1)"; \
		$(MAKE) -C $$dir $(1); \
	fi \
done
endef

.PHONY: preq
preq:
	$(call assert_command_exists,git)

.DEFAULT_GOAL := all
.PHONY: all
all: preq
	git submodule update --init --recursive
	$(call mapdirs,all)

.DEFAULT:
	$(call mapdirs,$@)
