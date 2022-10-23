
include ../base.mk

.PHONY: preq
preq:
	$(call assert_command_exists,brew)

.PHONY: install
install: install-formulae
install: install-casks

.PHONY: install-formulae
install-formulae: preq
	# brew leaves
	for formula in $$(cat formulae); do \
		brew install $$formula;         \
	done;

.PHONY: install-casks
install-casks: preq
	# brew list --cask
	for cask in $$(cat casks); do   \
		brew install --cask $$cask; \
	done;
