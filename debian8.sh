#!/bin/sh
#Locale
LOCAL="Europe/Kiev"
LOCALE="ru_RU.UTF-8"
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
apt-get -y install bsdutils build-essential libaio1 libssl-dev libcurl4-openssl-dev libevent-dev sendmail-bin sensible-mda
apt-get -y install module-init-tools

