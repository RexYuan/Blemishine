
# Set PATH, MANPATH, etc., for Homebrew.
# https://stackoverflow.com/q/65259300/2448540
arch="$(uname -m)"
if [[ "$arch" == 'arm64' ]]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ "$arch" == 'x86_64' ]]; then
    eval "$(/usr/local/bin/brew shellenv)"
else
    exit 1
fi

export PATH="/Users/rexyuan/Library/Python/3.9:/Users/rexyuan/Library/Python/3.8/bin:$PATH"
export LDFLAGS="-L/usr/local/opt/python@3.9/lib -L/usr/local/opt/python@3.8/lib"
# pipx
export PATH="/Users/rexyuan/.local/bin:$PATH"

# Scala
# >>> JVM installed by coursier >>>
export JAVA_HOME="/Users/rexyuan/Library/Caches/Coursier/arc/https/github.com/AdoptOpenJDK/openjdk8-binaries/releases/download/jdk8u292-b10/OpenJDK8U-jdk_x64_mac_hotspot_8u292b10.tar.gz/jdk8u292-b10/Contents/Home"
# <<< JVM installed by coursier <<<
# >>> coursier install directory >>>
export PATH="$PATH:/Users/rexyuan/Library/Application Support/Coursier/bin"
# <<< coursier install directory <<<