#!/bin/bash

mkdir -p /dev/net
/usr/bin/mknod /dev/net/tun c 10 200
chmod 600 /dev/net/tun

# Run challenge in background
while :; do sudo -u chal python3 chal.py; done &

# Run vpn server in foreground
cd /etc/openvpn/server
/usr/sbin/openvpn --config server.conf
