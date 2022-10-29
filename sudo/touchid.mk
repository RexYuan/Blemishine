
LINE := auth       sufficient     pam_tid.so
FILE := /etc/pam.d/sudo

# https://apple.stackexchange.com/q/259093/130792
# https://stackoverflow.com/q/6537490/2448540
.PHONY: touchid
touchid:
	if [[ ! $$(grep -n '$(LINE)' $(FILE)) ]]; then \
		sudo sed -i '' '2s/^/$(LINE)\n/' $(FILE); \
	fi

# https://stackoverflow.com/q/14093452/2448540
# https://stackoverflow.com/q/3213748/2448540
.PHONY: touchid-clean
touchid-clean:
	if [[ $$(grep -n '$(LINE)' $(FILE)) ]]; then \
		sudo sed -i '' "$$(grep -n '$(LINE)' $(FILE) | cut -d : -f 1 | head -n 1)d" $(FILE); \
	fi
