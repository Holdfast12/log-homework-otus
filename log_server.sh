#!/bin/bash
echo log-server > /etc/hostname
hostname log-server

sed -i 's/^#$ModLoad imudp/$ModLoad imudp/g' /etc/rsyslog.conf
sed -i 's/^#$UDPServerRun 514/$UDPServerRun 514/g' /etc/rsyslog.conf
sed -i 's/^#$ModLoad imtcp/$ModLoad imtcp/g' /etc/rsyslog.conf
sed -i 's/^#$InputTCPServerRun 514/$InputTCPServerRun 514/g' /etc/rsyslog.conf

cat <<'EOT' >> /etc/rsyslog.conf
$template RemoteLogs,"/var/log/rsyslog/%HOSTNAME%/%PROGRAMNAME%.log"
*.* ?RemoteLogs
& ~
EOT

systemctl restart rsyslog
