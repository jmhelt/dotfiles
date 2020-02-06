#!/usr/bin/env bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
GIT_REPO_DIR="$HOME/git"

# os constants
ARCH="Arch Linux"

# get this os string
if [[ -n "$(command -v lsb_release)" ]]; then
	  OS=$(lsb_release -s -d)
elif [[ -f "/etc/os-release" ]]; then
	  OS=$(grep PRETTY_NAME /etc/os-release | sed 's/PRETTY_NAME=//g' | tr -d '="')
elif [[ -f "/etc/debian_version" ]]; then
	  OS="Debian $(cat /etc/debian_version)"
elif [[ -f "/etc/redhat-release" ]]; then
	  OS=$(cat /etc/redhat-release)
else
	  OS="$(uname -s) $(uname -r)"
fi

function update_upgrade {
    if [[ $OS == $ARCH ]]; then
        sudo pacman -Syu --noconfirm
    else
        sudo apt-get update && sudo apt-get upgrade -y
    fi
}

function install_packages {
    if [[ $OS == $ARCH ]]; then
        sudo pacman -S --noconfirm "$@"
    else
        sudo apt-get install -y "$@"
    fi
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

function link_xdg_file {
    [[ ! -e "$HOME/.config" ]] && mkdir "$HOME/.config"
    ln -sf "$SCRIPT_DIR/$1" "$HOME/.config/$1"
}

function link_xdg_files {
    for f in "$@"; do
	      link_xdg_file "$f"
    done
}

update_upgrade

install_packages \
    dmenu \
    emacs \
    firefox \
    git \
    i3-wm \
    i3blocks \
    i3lock \
    i3status \
    openssh \
    termite \
    ttf-dejavu \
    vim \
    xautolock \
    zsh

makedirs $GIT_REPO_DIR

link_xdg_files \
    i3 \
    termite

link_dotfiles \
    emacs.d \
    gitconfig \
    oh-my-zsh \
    spacemacs \
    xinitrc \
    Xmodmap \
    zprofile \
    zshrc
