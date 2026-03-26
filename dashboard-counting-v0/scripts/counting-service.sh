#!/bin/bash
set -euxo pipefail

apt-get update -y
apt-get install -y net-tools zip curl jq tree unzip wget siege apt-transport-https ca-certificates software-properties-common gnupg lsb-release

cd /tmp
curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/counting-service_linux_amd64.zip -o counting-service.zip
unzip -o counting-service.zip
rm -f counting-service.zip

mv counting-service_linux_amd64 /usr/bin/counting-service
chmod 755 /usr/bin/counting-service
chown ubuntu:ubuntu /usr/bin/counting-service

cat > /etc/systemd/system/counting-api.service <<'EOF'
[Unit]
Description=Counting API service
After=network.target

[Service]
Environment=PORT=9003
ExecStart=/usr/bin/counting-service
User=ubuntu
Group=ubuntu
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable counting-api.service
systemctl start counting-api.service
systemctl status counting-api.service --no-pager || true
ss -ltnp | grep 9003 || true