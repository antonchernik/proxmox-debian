#!/bin/sh
#Locale
LOCAL="Europe/Kiev"
LOCALE="ru_RU.UTF-8"
HDHOST=node0.cloud365.com.ua
SSHD_PORT=50392
apt-get update; apt-get upgrade -y;
apt-get -y install vim htop cron zip unzip wget curl mc sudo apache2-utils debconf-utils ipset debian-keyring fail2ban git
gpg --keyserver pgp.mit.edu --recv-keys 1F41B907
gpg --armor --export 1F41B907 | apt-key add -
update-alternatives --set editor /usr/bin/vim.basic
locale-gen "$LOCALE"
sed -i -e "s/# $LOCALE UTF-8/$LOCALE UTF-8/" /etc/locale.gen && \
echo "LANG=$LOCALE">/etc/default/locale && \
dpkg-reconfigure --frontend=noninteractive locales && \
update-locale LANG="$LOCALE"
echo $LOCAL > /etc/timezone && \
dpkg-reconfigure -f noninteractive tzdata

sed -i -e 's/"syntax on/syntax on\ncolorscheme ron\nset number/' /etc/vim/vimrc
apt-get -y install bsdutils build-essential libaio1 libssl-dev libcurl4-openssl-dev libevent-dev
apt-get -y install module-init-tools

modprobe kvm
modprobe kvm_intel

sed -i "s/Debian-82-jessie-64-minimal/Debian-82-jessie-64-minimal $HDHOST prox4m1.proxmox.com prox4m1 pvelocalhost/g" /etc/hosts
sed -i "s/Debian-82-jessie-64-minimal/$HDHOST/g" /etc/hostname
sed -i "s/Port 22/Port $SSHD_PORT/g" /etc/ssh/sshd_config
sed -i "s/PermitRootLogin yes/PermitRootLogin no/g" /etc/ssh/sshd_config

#echo "deb http://download.proxmox.com/debian jessie pve-no-subscription" > /etc/apt/sources.list.d/pve-install-repo.list
#wget -O- "http://download.proxmox.com/debian/key.asc" | apt-key add -
#apt-get update && apt-get dist-upgrade
#apt-get install proxmox-ve ntp ssh postfix ksm-control-daemon open-iscsi
#apt-get remove linux-image-amd64 linux-image-3.16.0-4-amd64 linux-base
#update-grub
