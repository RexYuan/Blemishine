
# Set PATH, MANPATH, etc., for Homebrew.
eval "$($BREW_PREFIX/bin/brew shellenv)"

# Scala
# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/rexyuan/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# <<< JVM installed by coursier <<<
# >>> coursier install directory >>>
if [[ -d "$HOME/Library/Application Support/Coursier" ]]; then
    export PATH="$PATH:$HOME/Library/Application Support/Coursier/bin"
else
    echo "🟠 Coursier not set up. Run \"cs setup\""
fi
# <<< coursier install directory <<<

# rustup
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
else
    echo "🟠 Rust not set up. Run \"rustup-init\""
fi

# ruby
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"

# coreutils
export PATH="/usr/local/opt/coreutils/libexec/gnubin:$PATH"

# sed
export PATH="/usr/local/opt/gnu-sed/libexec/gnubin:$PATH"

# python c extension
export C_INCLUDE_PATH="/usr/local/Cellar/python@3.11/3.11.3/Frameworks/Python.framework/Versions/3.11/include/python3.11/:$C_INCLUDE_PATH"

# nvm
# export NVM_DIR="$HOME/.nvm"
# [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
# [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# ocaml, frama-c
eval $(opam env)

# flex, bison
export PATH="/usr/local/opt/flex/bin:$PATH"
export PATH="/usr/local/opt/bison/bin:$PATH"

# curl
export PATH="/usr/local/opt/curl/bin:$PATH"
