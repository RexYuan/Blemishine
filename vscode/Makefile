
.PHONY: all
all:
	ln -s $(realpath .)/settings.json ~/Library/Application Support/Code/User/settings.json
	ln -s $(realpath .)/keybindings.json ~/Library/Application Support/Code/User/keybindings.json

.PHONY: clean
clean:
	rm ~/Library/Application Support/Code/User/settings.json
	rm ~/Library/Application Support/Code/User/keybindings.json

.PHONY: install
install:
	for ext in $$(cat extensions); do   \
		code --install-extension $$ext; \
	done;
