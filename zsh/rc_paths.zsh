
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
    cs setup
fi
# <<< coursier install directory <<<

# rustup
if [[ -f "$HOME/.cargo/env" ]]; then
    source "$HOME/.cargo/env"
else
    rustup-init
fi

# ruby
export PATH="$BREW_PREFIX/opt/ruby/bin:$PATH"
