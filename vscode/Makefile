
.PHONY: all
all:
	ln -s -f $(realpath .)/settings.json ~/Library/Application\ Support/Code/User/settings.json
	ln -s -f $(realpath .)/keybindings.json ~/Library/Application\ Support/Code/User/keybindings.json

.PHONY: clean
clean:
	rm ~/Library/Application Support/Code/User/settings.json
	rm ~/Library/Application Support/Code/User/keybindings.json

.PHONY: install
install:
	for ext in $$(cat extensions); do   \
		code --install-extension $$ext; \
	done;
