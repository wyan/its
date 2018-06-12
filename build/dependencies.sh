if test -n "$GITLAB_CI" -o -n "$CIRCLECI"; then
    sudo() {
        "$@"
    }
fi

install_linux() {
    sudo apt-get update -myq
    sudo apt-get install -my expect
    # For GitLab CI
    sudo apt-get install -my git make gcc libncurses-dev autoconf
    case "$EMULATOR" in
        simh) sudo apt-get install -y simh;;
        sims) sudo apt-get install -y libegl1-mesa-dev libgles2-mesa-dev
              sudo apt-get install -y libx11-dev libxt-dev libsdl2-dev
              sudo apt-get install -y libsdl-dev libsdl-image1.2-dev;;
        klh10) sudo apt-get install -y libusb-1.0-0-dev;;
    esac
}

install_osx() {
    brew update > /dev/null
    brew install expect
    case "$EMULATOR" in
        sims) brew install sdl2;;
    esac
}

"$1"
