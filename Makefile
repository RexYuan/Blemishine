
include base.mk

DIRS = $(wildcard */)

define mapdirs
@for dir in $(DIRS); do \
	echo "\nmake -C $$dir $(1)"; \
	$(MAKE) -C $$dir $(1); \
done
endef

.DEFAULT_GOAL := all

all:
	$(call assert_command_exists,git)
	git submodule update --init --recursive
	$(call mapdirs,all)

.DEFAULT:
	$(call mapdirs,$@)
