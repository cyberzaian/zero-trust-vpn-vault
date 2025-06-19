#!/bin/bash
# setup_vault.sh
# Automates Vault installation and basic configuration

set -e

echo "[*] Installing Vault..."
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/hashicorp.gpg
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault -y

echo "[*] Creating Vault config..."
sudo mkdir -p /opt/vault/data
cat <<EOF | sudo tee /etc/vault.d/vault.hcl
listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}
storage "file" {
  path = "/opt/vault/data"
}
disable_mlock = true
EOF

echo "[*] Creating Vault systemd service..."
sudo tee /etc/systemd/system/vault.service > /dev/null <<EOF
[Unit]
Description=HashiCorp Vault
After=network.target

[Service]
ExecStart=/usr/bin/vault server -config=/etc/vault.d/vault.hcl
ExecReload=/bin/kill -HUP $MAINPID
Restart=on-failure
LimitNOFILE=65536
User=root
Group=root
[Install]
WantedBy=multi-user.target
EOF

echo "[*] Enabling and starting Vault..."
sudo systemctl daemon-reexec
sudo systemctl daemon-reload
sudo systemctl enable vault
sudo systemctl start vault

echo "[*] Vault installed and running on 127.0.0.1:8200"
echo "[*] (You can forward this to 10.8.0.2 via socat if needed)"
