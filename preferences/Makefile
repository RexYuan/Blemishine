
include ../base.mk

MKS = $(wildcard *.mk)

# https://apple.stackexchange.com/q/405937/130792
.PHONY: all
all: $(basename $(MKS))
	/System/Library/PrivateFrameworks/SystemAdministration.framework/Resources/activateSettings -u
	$(info 🟠 some settings require logout-login to take effect)

include $(MKS)
