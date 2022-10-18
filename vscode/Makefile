
include ../base.mk

CODE_PREFIX=~/Library/Application\ Support/Code/User

.PHONY: preq
preq:
	$(call assert_command_exists,code)
	$(call assert_directory_exists,$(CODE_PREFIX))

.PHONY: all
all: preq
	ln -s -f $(realpath .)/settings.json $(CODE_PREFIX)/settings.json
	ln -s -f $(realpath .)/keybindings.json $(CODE_PREFIX)/keybindings.json

.PHONY: clean
clean: preq
	rm $(CODE_PREFIX)/settings.json
	rm $(CODE_PREFIX)/keybindings.json

.PHONY: install
install: preq
	for ext in $$(cat extensions); do   \
		code --install-extension $$ext; \
	done;
