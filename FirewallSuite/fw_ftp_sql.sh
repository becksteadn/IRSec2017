#!/bin/bash

#HTTP Server

#Clear previous rules
iptables -F

#Allow SSH. Don't get locked out. Not in this dumb way at least.
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#Allow localhost
iptables -A INPUT -i lo -j ACCEPT

#Allow established connections
iptables -A INPUT -m state --state ESTABLISHED, RELATED -j ACCEPT

##########################

#SQL
iptables -A OUTPUT -p tcp --dport 3306 -j ACCEPT #from sql
iptables -A INPUT -p tcp --sport 3306 -j ACCEPT #to sql

#FTP
modprobe ip_conntrack_ftp #This does something
iptables -A INPUT -p tcp --dport 21 -j ACCEPT
iptables -A OUTPUT -p tcp --sport 21 -j ACCEPT
iptables -A INPUT -p tcp --dport 20 -m state --state ESTABLISHED -j ACCEPT
iptables -A OUTPUT -p tcp -m state --state ESTABLISHED,RELATED --sport 20 -j ACCEPT

##########################

#Deny suspicious outgoing activity
iptables -A OUTPUT -p tcp --dport 22 -j DENY #Don't ssh out to other machines
iptables -A OUTPUT -p tcp --dport 80 -j DENY #No web
iptables -A OUTPUT -p tcp --dport 443 -j DENY #No secure web

#Deny everything else
iptables -P INPUT DROP
iptables -P FORWARD DROP

#Don't kill it all just yet
iptables -P OUTPUT ACCEPT

iptables -L -n -v --line-numbers
