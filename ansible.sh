#!/bin/bash
dnf install -y epel-release
dnf install -y ansible
echo -en 'ANSIBLE_CONFIG="/vagrant/ansible.cfg"\n' >> /etc/environment
for env in $( cat /etc/environment ); do export $(echo $env | sed -e 's/"//g'); done