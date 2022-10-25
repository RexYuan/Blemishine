#!/bin/zsh
#
# run this:
# /bin/zsh -c "$(curl -fsSL https://raw.githubusercontent.com/RexYuan/Blemishine/main/init.zsh)"
#

# https://github.com/mathiasbynens/dotfiles/blob/master/.macos
# keep sudo status until the end
sudo -v
while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null &

echo "\n🟡 installing command line tools..."
xcode-select --install
[[ $? -eq 0 ]] && echo "🟢 installed command line tools" || echo "🔴 could not install command line tools"

echo "\n🟡 installing homebrew..."
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
[[ $? -eq 0 ]] && echo "🟢 installed homebrew" || echo "🔴 could not install homebrew"

echo "\n🟡 cloning Blemishine..."
mkdir -p ~/Projects/ && git clone https://github.com/RexYuan/Blemishine.git ~/Projects/Blemishine
[[ $? -eq 0 ]] && echo "🟢 cloned Blemishine" || echo "🔴 could not clone Blemishine"

echo "\n🟡 installing vscode..."
brew install --cask visual-studio-code
[[ $? -eq 0 ]] && echo "🟢 installed vscode" || echo "🔴 could not install vscode"

echo "\n🟡 make-ing Blemishine..."
make -C ~/Projects/Blemishine
[[ $? -eq 0 ]] && echo "🟢 make-ed Blemishine" || echo "🔴 could not make Blemishine"

echo "\n🟡 make install-ing Blemishine..."
make -C ~/Projects/Blemishine install
[[ $? -eq 0 ]] && echo "🟢 make install-ed Blemishine" || echo "🔴 could not make install Blemishine"
