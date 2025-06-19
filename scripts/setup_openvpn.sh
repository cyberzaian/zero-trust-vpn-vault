#!/bin/bash

set -e

echo "[*] Installing OpenVPN..."
wget https://git.io/vpn -O openvpn-install.sh
chmod +x openvpn-install.sh
sudo bash openvpn-install.sh

echo "[*] Enabling IP forwarding..."
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p

echo "[*] Setting up NAT rules..."
PUBLIC_IFACE="eth0"
VPN_IP="10.8.0.1"
VPN_SUBNET="10.8.0.0/24"

sudo iptables -t nat -A PREROUTING -i $PUBLIC_IFACE -p udp --dport 1194 -j DNAT --to-destination $VPN_IP:1194
sudo iptables -A FORWARD -i $PUBLIC_IFACE -p udp --dport 1194 -d $VPN_IP -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s $VPN_SUBNET -o $PUBLIC_IFACE -j MASQUERADE

echo "[*] Saving iptables rules..."
sudo apt install -y iptables-persistent
sudo netfilter-persistent save

echo "[*] OpenVPN setup complete. You can now add clients with:"
echo "    sudo bash openvpn-install.sh"
