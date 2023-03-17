
include ../base.mk

.PHONY: preq
preq:

.DEFAULT_GOAL := all
.PHONY: all
all: preq
	ln -s -f $(realpath .)/.screenrc ~/.screenrc

.PHONY: clean
clean: preq
	rm ~/.screenrc
