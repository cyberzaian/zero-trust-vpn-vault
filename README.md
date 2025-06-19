# 🔒 Zero Trust VPN Gateway with HashiCorp Vault

This project implements a Zero Trust remote access model using:
- 🌐 OpenVPN: For encrypted tunneling
- 🔐 HashiCorp Vault: For secure authentication and secrets management

## 📌 Objective
Secure RDP access to internal servers via a VPN gateway, with access control and secret distribution handled by Vault.

## 🧰 What I Built
✅ Set up OpenVPN on an Ubuntu VPS  
✅ Installed and configured HashiCorp Vault on the same server  
✅ Vault is only accessible inside VPN (e.g., 10.8.0.2)  
✅ Used Vault to store API keys and secrets for other apps  
✅ Accessed Vault from another device connected to VPN using root token  

## 🔐 Architecture
```
[ Admin Laptop ]
   10.8.0.3
       |
   [ VPN Tunnel ]
       |
[ Ubuntu VPS ]
   - OpenVPN Server (10.8.0.1)
   - HashiCorp Vault (10.8.0.2)
       |
[ Windows Server ]
   - RDP IP: 10.8.0.10
```
