
.PHONY: nothing
nothing: ;

.PHONY: install
install: install-formulae
install: install-cask

.PHONY: install-formulae
install-formulae:
	# brew leaves
	for formula in $$(cat formulae); do \
		brew install $$formula;         \
	done;

.PHONY: install-cask
install-cask:
	# brew list --cask
	for cask in $$(cat casks); do   \
		brew install --cask $$cask; \
	done;
