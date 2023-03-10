#! /bin/bash 

sudo firewall-cmd --list-all-zones | less 

sudo firewall-cmd --zone=home --change-interface=ens224


# Set the firewall to only allow traffic on specified ports
firewall-cmd --zone=internal --remove-service=ssh --permanent
firewall-cmd --zone=internal --remove-service=dhcpv6-client --permanent
firewall-cmd --zone=internal --add-service=http --permanent
firewall-cmd --zone=internal --add-service=https --permanent
firewall-cmd --zone=internal --add-service=dns --permanent
firewall-cmd --zone=internal --add-port=22/tcp --permanent

# Reload the firewall rules
firewall-cmd --reload


# Set the default zone to drop packets
firewall-cmd --set-default-zone=drop

# Allow SSH traffic from a specific IP address or subnet
# firewall-cmd --zone=internal --add-service=ssh --source=192.168.54.0/24 --permanent

# Allow HTTP and HTTPS traffic
firewall-cmd --zone=public --add-service=http --permanent
firewall-cmd --zone=public --add-service=https --permanent

# Allow DNS traffic from a specific IP address or subnet
# firewall-cmd --zone=internal --add-service=dns --source=192.168.54.0/24 --permanent

# Reload the firewall rules
firewall-cmd --reload


#!/bin/bash

# Set the default zone to drop packets
firewall-cmd --set-default-zone=drop

# Allow incoming SSH traffic from the internal network
firewall-cmd --zone=internal --add-service=ssh --permanent

# Allow incoming HTTP and HTTPS traffic to the web server
firewall-cmd --zone=internal --add-service=http --permanent
firewall-cmd --zone=internal --add-service=https --permanent

# Allow incoming MySQL traffic from the web server
firewall-cmd --zone=internal --add-rich-rule='rule family="ipv4" source address="192.168.54.3" service name="mysql" accept' --permanent

# Allow incoming DNS traffic from the internal network
firewall-cmd --zone=internal --add-service=dns --permanent

# Allow incoming SFTP traffic from the backup server
# firewall-cmd --zone=internal --add-rich-rule='rule family="ipv4" source address="10.0.0.3" service name="sftp" accept' --permanent

# Allow incoming SSH traffic from the three internal Kali machines
firewall-cmd --zone=internal --add-rich-rule='rule family="ipv4" source address="192.168.54.111" service name="ssh" accept' --permanent

# Reload the firewall rules
firewall-cmd --reload
