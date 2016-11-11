#!/bin/bash
root_rw.sh
ssh-keygen -t rsa -f /etc/ssh_host_rsa_key
ssh-keygen -t dsa -f /etc/ssh_host_dsa_key
ssh-keygen -t ecdsa -f /etc/ssh_host_ecdsa_key
sshd
