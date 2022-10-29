
TIMEOUT_MIN := 1
USER := ${USER}

# https://unix.stackexchange.com/q/382060/145856
# https://stackoverflow.com/q/323957/2448540
.PHONY: timeout
timeout:
	cd /etc/sudoers.d/; \
	echo "Defaults timestamp_timeout=$(TIMEOUT_MIN)" | sudo EDITOR='tee' visudo -f $(USER)

.PHONY: timeout-clean
timeout-clean:
	sudo rm /etc/sudoers.d/$(USER)
