#!/bin/bash
set -euxo pipefail

apt-get update -y
apt-get install -y net-tools zip curl jq tree unzip wget siege apt-transport-https ca-certificates software-properties-common gnupg lsb-release

cd /tmp
curl -L https://github.com/hashicorp/demo-consul-101/releases/download/v0.0.5/dashboard-service_linux_amd64.zip -o dashboard-service.zip
unzip -o dashboard-service.zip
rm -f dashboard-service.zip

mv dashboard-service_linux_amd64 /usr/bin/dashboard-service
chmod 755 /usr/bin/dashboard-service
chown ubuntu:ubuntu /usr/bin/dashboard-service

cat > /etc/systemd/system/dashboard-api.service <<EOF
[Unit]
Description=Dashboard API service
After=network.target

[Service]
Environment=PORT=9002
Environment=COUNTING_SERVICE_URL=http://${counting_private_ip}:9003
ExecStart=/usr/bin/dashboard-service
User=ubuntu
Group=ubuntu
Restart=always
RestartSec=5

[Install]
WantedBy=multi-user.target
EOF

systemctl daemon-reload
systemctl enable dashboard-api.service
systemctl start dashboard-api.service
systemctl status dashboard-api.service --no-pager || true
ss -ltnp | grep 9002 || true