
define not_found_exit
echo "🔴 $(1) not found"; \
exit 1
endef

define assert_command_exists
@if ! command -v $(1) &> /dev/null; then \
	$(not_found_exit); \
fi
endef

define assert_directory_exists
@if [[ ! -d $(1) ]]; then \
    $(not_found_exit); \
fi
endef

define assert_file_exists
@if [[ ! -f $(1) ]]; then \
    $(not_found_exit); \
fi
endef
