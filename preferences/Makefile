
include ../base.mk

MKS = $(wildcard *.mk)

.PHONY: all
all: $(basename $(MKS))
	$(info ⚠️  some settings require logout-login to take effect)

include $(MKS)
