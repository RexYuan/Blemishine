
.PHONY: nothing
nothing: ;

.PHONY: install
install:
	for cask in $$(cat casks); do   \
		brew install --cask $$cask; \
	done;
