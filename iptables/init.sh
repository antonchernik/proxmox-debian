#!/bin/sh
ipset -N china hash:net
for i in $(cat /opt/proxmox-debian/ipset/cn.zone ); do ipset -A china $i; done
ipset -N blacklist iphash
for i in $(cat /opt/proxmox-debian/ipset/ipset-blacklist.txt ); do ipset -A blacklist $i; done
/sbin/iptables-restore < /opt/proxmox-debian/iptables/iptables.up.rules
