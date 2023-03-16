#!/bin/bash
dnf install -y nginx
/bin/cp -f /vagrant/web_nginx.conf /etc/nginx/nginx.conf
systemctl enable nginx --now


# добавление правила аудита файла конфигурации nginx
cat <<'EOT' >> /etc/audit/rules.d/nginx.rules
-D
-b 8192
-f 1
-w /etc/nginx/nginx.conf -p wa -k monitor_nginx_conf
-w /etc/nginx/conf.d/ -p wa -k monitor_nginx_conf

EOT
service auditd restart

cat <<'EOT' > /etc/rsyslog.d/crit.conf
*.crit @@rsyslog:514

EOT

cat <<'EOT' > /etc/rsyslog.d/audit.conf
$ModLoad imfile
$InputFileName /var/log/audit/audit.log
$InputFileTag tag_audit_log:
$InputFileStateFile audit_log
$InputFileSeverity info
$InputFileFacility local6
$InputRunFileMonitor

*.* @@rsyslog:514

EOT

systemctl restart rsyslog