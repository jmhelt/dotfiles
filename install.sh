#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function is_installed {
    dpkg-query -W -f='${Status}' "$1" 2>/dev/null | grep "ok installed" &> /dev/null
}

function install_package {
    sudo apt-get install -y "$1"
}

function install_packages {
    for pkg in "$@"; do
	is_installed "$pkg" || install_package "$pkg"
    done
}

function link_dotfile {
    ln -sf "$SCRIPT_DIR/$1" "$HOME/.$1"
}

function link_dotfiles {
    for f in "$@"; do
	link_dotfile "$f"
    done
}

function install_emacsd {
    if [[ -d ~/.emacs.d ]]; then
	cd ~/.emacs.d
	git pull -f origin master
    else
	git clone git@github.com:jmhelt/emacs.d.git ~/.emacs.d
    fi
}

function install_spotify {
    if ! is_installed spotify-client; then
	sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 0DF731E45CE24F27EEEB1450EFDC8610341D9410
	echo deb http://repository.spotify.com stable non-free | sudo tee /etc/apt/sources.list.d/spotify.list
	sudo apt-get update
	sudo apt-get install -y spotify-client
    fi
}

function install_dropbox {
    if ! is_installed dropbox; then
	cd /tmp \
	    && wget -O dropbox.deb https://www.dropbox.com/download?dl=packages/ubuntu/dropbox_2015.10.28_amd64.deb \
	    && (sudo dpkg -i dropbox.deb || sudo apt-get -f install -y)

	# Restart nautilus if necessary
	if which nautilus; then
	    nautilus --quit
	fi
    fi
}

sudo apt-get update && sudo apt-get upgrade -y

install_packages \
    autoconf \
    automake \
    cscope \
    curl \
    emacs \
    firefox \
    g++ \
    gcc \
    gdb \
    git \
    libtool \
    lm-sensors \
    openvpn \
    redshift \
    texlive \
    thunderbird \
    valgrind \
    vim \
    wget

install_emacsd
install_spotify
install_dropbox

link_dotfiles \
    gitconfig
