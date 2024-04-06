
include ../base.mk

.PHONY: preq
preq:

.DEFAULT_GOAL := all
.PHONY: all
all: preq
	ln -s -f $(realpath .)/.condarc ~/.condarc

.PHONY: clean
clean: preq
	rm ~/.condarc
