#!/bin/bash
/bin/cp -f /vagrant/log_rsyslog.conf /etc/rsyslog.conf
systemctl restart rsyslog