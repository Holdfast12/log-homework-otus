#!/bin/bash
echo web-server > /etc/hostname
hostname web-server

yum install -y nginx
systemctl enable nginx --now

cat <<'EOT' > /etc/rsyslog.d/all.conf
*.* @@192.168.1.3:514
EOT

systemctl restart rsyslog