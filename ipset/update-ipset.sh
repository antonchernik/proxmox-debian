#!/bin/sh
rm /opt/proxmox-debian/ipset/cn.zone
wget http://www.ipdeny.com/ipblocks/data/countries/cn.zone -P /opt/proxmox-debian/ipset
rm /opt/proxmox-debian/ipset/ipset-blacklist.txt
wget https://raw.githubusercontent.com/antonchernik/lnmp-debian/master/ipset-blacklist.txt -P /opt/proxmox-debian/ipset
ipset flush china
for i in $(cat /opt/proxmox-debian/ipset/cn.zone ); do ipset -A china $i; done
ipset flush blacklist
for i in $(cat /opt/proxmox-debian/ipset/ipset-blacklist.txt ); do ipset -A blacklist $i; done
