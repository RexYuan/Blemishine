
include ../base.mk

.PHONY: preq
preq:
	mkdir -p ~/.ssh/
	$(call assert_directory_exists,~/.ssh/)

.DEFAULT_GOAL := all
.PHONY: all
all: preq
	ln -s -f $(realpath .)/config ~/.ssh/config

.PHONY: clean
clean: preq
	rm ~/.ssh/config
