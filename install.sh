#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GIT_REPO_DIR="$HOME/git"

function install_packages {
    sudo apt-get install -y "$@"
}

function makedirs {
    for dir in "$@"; do
	mkdir -p "$dir"
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

function install_r {
    sudo apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9 \
	&& sudo add-apt-repository -y 'deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/' \
	&& sudo apt update \
	&& sudo apt install -y r-base
}

function install_google_drive {
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys ACCAF35C \
	&& sudo add-apt-repository -y "deb http://apt.insynchq.com/ubuntu $(lsb_release -sc) non-free contrib" \
        && sudo apt update \
	&& sudo apt install -y insync
}

function install_spotify {
    sudo snap install spotify
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
    firefox \
    g++ \
    gcc \
    gdb \
    git \
    latexmk \
    libcurl4-openssl-dev \
    libelf-dev \
    libncurses5-dev \
    libssl-dev \
    libtool \
    lm-sensors \
    screen \
    texinfo \
    texlive \
    texlive-bibtex-extra \
    texlive-fonts-extra \
    texlive-latex-extra \
    texlive-science \
    valgrind \
    vim \
    wget \
    whois

makedirs $GIT_REPO_DIR

install_r
install_google_drive
install_spotify
install_slack

link_dotfiles \
    gitconfig \
    emacs.d \
    spacemacs \
    xinitrc \
    i3 \
    zprofile \
    zshrc \
    oh-my-zsh

