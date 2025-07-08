
# upgrade and clean Homebrew with sudo kept alive
# usage: upbrew
function upbrew {
    with-sudo-keepalive "$SHELL" -c '
        brew update
        brew upgrade
        brew cleanup
    '
}
