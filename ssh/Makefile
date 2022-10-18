
include ../base.mk

.PHONY: preq
preq:
	$(call assert_file_exists,~/.ssh/config)

.PHONY: all
all: preq
	ln -s -f $(realpath .)/config ~/.ssh/config

.PHONY: clean
clean: preq
	rm ~/.ssh/config
