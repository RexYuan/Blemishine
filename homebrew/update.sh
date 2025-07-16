#!/bin/bash

# Save Homebrew manually installed formulae (leaves)
brew leaves > $BLEM/homebrew/formulae

# Save Homebrew installed casks
brew list --cask > $BLEM/homebrew/casks
