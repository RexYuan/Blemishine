
include ../base.mk

TIMEOUT_MIN := 1
USER := ${USER}

# https://unix.stackexchange.com/q/382060/145856
# https://stackoverflow.com/q/323957/2448540
.PHONY: all
all:
	cd /etc/sudoers.d/; \
	echo "Defaults timestamp_timeout=$(TIMEOUT_MIN)" | sudo EDITOR='tee' visudo -f $(USER)

.PHONY: clean
clean:
	sudo rm /etc/sudoers.d/$(USER)
