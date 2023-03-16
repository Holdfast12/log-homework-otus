1. аудит, следящий за изменениями файла конфигурации nginx на машине web:

Само правило auditd
/etc/audit/rules.d/nginx.rules

Просмотр правил auditd
auditctl -l
grep monitor_nginx_conf /var/log/audit/audit.log

2. Все критичные логи с web должны собираться и локально и удаленно.

правило на пересылку крит-логов на машине web в файле /etc/rsyslog.d/crit.conf
*.crit @@rsyslog:514



Логи аудита должны также уходить на удаленную систему.



3. Все логи с nginx уходят на удаленный сервер, локально пишутся только критичные.
Это настроено в конфиге /etc/nginx/nginx.conf в секции http добавлением следующих строк:

access_log syslog:server=rsyslog:514,tag=nginx_access main;
error_log syslog:server=rsyslog:514,tag=nginx_error notice;
error_log /var/log/nginx/error.log crit;