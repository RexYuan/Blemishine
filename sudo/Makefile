
include ../base.mk

MKS = $(wildcard *.mk)

.PHONY: all
all: $(basename $(MKS))

.PHONY: clean
clean: $(addsuffix -clean,$(basename $(MKS)))

include $(MKS)
