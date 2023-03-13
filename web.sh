#!/bin/bash

yum install -y nginx
systemctl enable nginx --now

#Логи аудита должны также уходить на удаленную систему
cat <<'EOT' > /etc/rsyslog.d/audit.conf
$ModLoad imfile
$InputFileName /var/log/audit/audit.log
$InputFileTag tag_audit_log:
$InputFileStateFile audit_log
$InputFileSeverity info
$InputFileFacility local6
$InputRunFileMonitor
*.* @@192.168.1.3:514
EOT


systemctl restart rsyslog