#!/usr/bin/env bash

set -o errexit -o nounset

TOP_DIR=$(cd "$(dirname "$0")/.." && pwd)

source "$TOP_DIR/config/paths"
source "$CONFIG_DIR/openstack"
source "$LIB_DIR/functions.guest.sh"

indicate_current_auto

exec_logfile

# Note: We assume that apt_init.sh set up repos and updated the apt index files

# Upgrade installed packages and the kernel
sudo DEBIAN_FRONTEND=noninteractive apt-get -y upgrade
sudo apt-get -y dist-upgrade

# If we upgraded the kernel, remove the old one
INSTALLED_KERNEL=$(readlink /vmlinuz)
INSTALLED_KERNEL=${INSTALLED_KERNEL#boot/vmlinuz-}
RUNNING_KERNEL=$(uname -r)

if [[ $INSTALLED_KERNEL != $RUNNING_KERNEL ]]; then
    echo "Kernel $INSTALLED_KERNEL installed. Removing $RUNNING_KERNEL."
    if dpkg -s "linux-image-extra-$RUNNING_KERNEL" >/dev/null 2>&1; then
        sudo dpkg --purge "linux-image-extra-$RUNNING_KERNEL"
    fi
    sudo dpkg --purge "linux-image-$RUNNING_KERNEL"
    sudo dpkg --purge "linux-headers-$RUNNING_KERNEL"
fi

# Clean apt cache
sudo apt-get -y autoremove
sudo apt-get -y clean
