
DIRS = $(wildcard */)

define mapdirs
for dir in $(DIRS); do \
	$(call submake,$$dir,$(1)); \
done
endef

define submake
$(MAKE) -C $(1) $(2)
endef

.DEFAULT_GOAL := all

.DEFAULT:
	git submodule update --init --recursive
	$(call mapdirs,$@)
