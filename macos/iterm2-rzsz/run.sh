#!/bin/sh
# shellcheck shell=dash

url="https://raw.githubusercontent.com/bugwz/x/master/macos/iterm2-rzsz"
path="/usr/local/bin"
sz="iterm2-send-zmodem.sh"
rz="iterm2-recv-zmodem.sh"

p(){
    echo "\033[32m[ $1 ]\033[0m"
}

getrzsz() {
    p "Installing lrzsz using brew..."
    brew install lrzsz
}

getsh() {
    p "Downloading $sz and $rz..."
    rm $path/$sz $path/$rz
    curl -sS -O $url/$sz -O $url/$rz || exit
    chmod +x $sz $rz || exit
    mv $sz $path/$sz || exit
    mv $rz $path/$rz || exit
    ls $path/$sz $path/$rz
}

todo() {
    p "Please open iterm2 and perform the following operations"
    echo "  1. Click to open 'Preferences...'"
    echo "  2. Choose 'Profiles' tab"
    echo "  3. Select the 'Advanced' tab on the right"
    echo "  4. Click the 'Edit' button in the 'Triggers' column"
    echo "  5. Add the following matching rules (remove the single quotes) :"
    echo "    5.1 Regular Expression: 'rz waiting to receive.\*\*B0100'"
    echo "        Action: 'Run Silent Coprocess...'"
    echo "        Parameters: '$path/$sz'"
    echo "        Instant: 'checked'"
    echo "    5.2 Regular Expression: '\*\*B00000000000000'"
    echo "        Action: 'Run Silent Coprocess...'"
    echo "        Parameters: '$path/$rz'"
    echo "        Instant: 'checked'"
    echo "  6. End"
}

getrzsz
getsh
todo




