# Installing HashiCorp Vault on Ubuntu

```bash
curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /etc/apt/trusted.gpg.d/hashicorp.gpg
echo "deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install vault
```

## Config file: `/etc/vault.d/vault.hcl`
```hcl
listener "tcp" {
  address     = "127.0.0.1:8200"
  tls_disable = 1
}
storage "file" {
  path = "/opt/vault/data"
}
```

## Forward traffic from 10.8.0.2 → 127.0.0.1:8200
```bash
socat TCP-LISTEN:8200,fork TCP:127.0.0.1:8200 &
```
