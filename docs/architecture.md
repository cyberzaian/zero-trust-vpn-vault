# Network Architecture

## Components:
- Ubuntu VPS: Hosts OpenVPN + Vault
- Vault listens on 127.0.0.1:8200 → forwarded to 10.8.0.2 via VPN
- Client connects to VPN → can access Vault + RDP

## Zero Trust Features:
- No public RDP or Vault access
- Vault secrets only accessible to VPN-authenticated clients
