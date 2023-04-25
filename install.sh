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

function install_zotero {
    local zotero_version=5.0.45
    
    if [[ ! -d /opt/zotero ]]; then
	cd /tmp \
	    && wget -O zotero.tar.bz2 "https://www.zotero.org/download/client/dl?channel=release&platform=linux-x86_64&version=$zotero_version" \
	    && tar -xjf zotero.tar.bz2 \
	    && chmod -R 0755 Zotero_linux-x86_64 \
	    && sudo chown -R root:root Zotero_linux-x86_64 \
	    && sudo mv Zotero_linux-x86_64 /opt/zotero \
	    && echo "[Desktop Entry]
Name=Zotero
Comment=Open-source reference manager
Exec=/opt/zotero/zotero
Icon=/opt/zotero/chrome/icons/default/default256.png
Type=Application
Terminal=false
Categories=Office;
MimeType=text/plain
StartupNotify=true" | sudo tee /usr/share/applications/zotero.desktop
    fi
}

function install_slack {
    sudo snap install --classic slack
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
    texlive-full \
    thunderbird \
    valgrind \
    vim \
    wget \
    whois

install_emacsd
install_spotify
install_dropbox
install_zotero
install_slack

link_dotfiles \
    gitconfig
