#!/bin/bash

# Ensure the file is named 'packages' in the current directory
pipx list --json | jq -r '.venvs | keys[]' > $BLEM/homebrew/packages
