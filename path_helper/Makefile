
include ../base.mk

.PHONY: all
all:
	cat path/* | tr -s '\n' | sudo tee /etc/paths.d/BlemPaths > /dev/null

.PHONY: clean
clean:
	sudo rm /etc/paths.d/BlemPaths
