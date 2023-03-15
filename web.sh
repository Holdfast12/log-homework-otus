#!/bin/bash
dnf install -y nginx
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