#!/usr/bin/env bash

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <kernel_version>"
    exit 1
fi

function rmkernel {
    local version="$1"

    sudo rm -f /boot/vmlinuz-"$1"
    sudo rm -f /boot/initrd.img-"$1"
    sudo rm -f /boot/System-map-"$1"
    sudo rm -f /boot/config-"$1"
    sudo rm -rf /lib/modules/"$1"/
    sudo rm -rf /var/lib/initramfs/"$1"/

    sudo update-grub2
}

rmkernel "$1"
