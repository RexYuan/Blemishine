
include ../base.mk

.PHONY: preq
preq:
	$(call assert_command_exists,brew)

.PHONY: all
all: ;

.PHONY: clean
clean: ;

.PHONY: install
install: install-formulae
install: install-cask

.PHONY: install-formulae
install-formulae: preq
	# brew leaves
	for formula in $$(cat formulae); do \
		brew install $$formula;         \
	done;

.PHONY: install-cask
install-cask: preq
	# brew list --cask
	for cask in $$(cat casks); do   \
		brew install --cask $$cask; \
	done;
