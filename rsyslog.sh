#!/bin/bash
echo rsyslog-server > /etc/hostname
hostname rsyslog-server

firewall-cmd --permanent --add-port=514/{tcp,udp}
firewall-cmd --reload
