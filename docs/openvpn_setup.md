# Installing OpenVPN on Ubuntu VPS

## Step 1: Download OpenVPN Auto Installer

```bash
wget https://git.io/vpn -O openvpn-install.sh
chmod +x openvpn-install.sh
sudo bash openvpn-install.sh
```

## Step 2: Enable IP Forwarding

```bash
sudo sysctl -w net.ipv4.ip_forward=1
echo "net.ipv4.ip_forward = 1" | sudo tee -a /etc/sysctl.conf
sudo sysctl -p
```

## Step 3: Configure NAT Forwarding (Assuming eth0 is public interface)

```bash
sudo iptables -t nat -A PREROUTING -i eth0 -p udp --dport 1194 -j DNAT --to-destination 10.8.0.1:1194
sudo iptables -A FORWARD -i eth0 -p udp --dport 1194 -d 10.8.0.1 -j ACCEPT
sudo iptables -t nat -A POSTROUTING -s 10.8.0.0/24 -o eth0 -j MASQUERADE
```

## Step 4: Save iptables Rules

```bash
sudo apt install iptables-persistent -y
sudo netfilter-persistent save
```

## Step 5: Generate a New Client File

```bash
sudo bash openvpn-install.sh  # choose to add a new client
sudo cp /root/client1.ovpn ~/
```
