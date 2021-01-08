
DIRS = $(wildcard */)

TARGETS := all clean

.PHONY: $(TARGETS)
$(TARGETS):
	for dir in $(DIRS); do \
		$(MAKE) -C $$dir $@; \
	done
