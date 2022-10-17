
DIRS = $(wildcard */)

define mapdirs
@for dir in $(DIRS); do \
	echo "make -C $$dir all"; \
	$(call submake,$$dir,$(1)); \
done
endef

define submake
$(MAKE) -C $(1) $(2)
endef

.DEFAULT_GOAL := all

all:
	git submodule update --init --recursive
	$(call mapdirs,$@)

.DEFAULT:
	$(info nothing was done)
