#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

function install_packages {
    sudo apt-get install -y "$@"
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
    sudo snap install spotify
}

function install_google_drive {
    sudo add-apt-repository -y ppa:alessandro-strada/ppa \
        && sudo apt update \
	&& sudo apt install -y google-drive-ocamlfuse

    if [[ ! -d ~/Drive ]]; then
	mkdir ~/Drive \
            && google-drive-ocamlfuse \
	    && google-drive-ocamlfuse ~/Drive
    fi
}

function install_zotero {
    sudo add-apt-repository -y ppa:smathot/cogscinl \
        && sudo apt update \
        && sudo apt install -y zotero-standalone
}

function install_slack {
    sudo snap install --classic slack
}

sudo apt-get update && sudo apt-get upgrade -y

install_packages \
    autoconf \
    automake \
    bison \
    cscope \
    curl \
    emacs \
    flex \
    g++ \
    gcc \
    gdb \
    git \
    latexmk \
    libelf-dev \
    libncurses5-dev \
    libssl-dev \
    libtool \
    lm-sensors \
    redshift-gtk \
    screen \
    texinfo \
    texlive \
    texlive-bibtex-extra \
    texlive-latex-extra \
    texlive-science \
    valgrind \
    vim \
    wget \
    whois

install_emacsd
install_spotify
install_google_drive
install_zotero
install_slack

link_dotfiles \
    gitconfig
