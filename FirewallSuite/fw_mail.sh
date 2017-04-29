#!/bin/bash

#HTTP Server

#Clear previous rules
iptables -F

#Allow SSH. Don't get locked out. In this dumb way at least.
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#Allow localhost
iptables -A INPUT -i lo -j ACCEPT

#Allow established connections
iptables -A INPUT -m state --state ESTABLISHED, RELATED -j ACCEPT

#######################

#Allow mail
iptables -A INPUT -p tcp --dport 143 -j ACCEPT
iptables -A INPUT -p tcp --dport 993 -j ACCEPT

#Graylog
iptables -A INPUT -p tcp --dport 9000 -j ACCEPT
iptables -A INPUT -p tcp --dport 9001 -j ACCEPT
iptables -A INPUT -p tcp --dport 9200 -j ACCEPT
iptables -A INPUT -p tcp --dport 9300 -j ACCEPT
iptables -A INPUT -p tcp --dport 9350 -j ACCEPT
iptables -A INPUT -p tcp --dport 27017 -j ACCEPT

#######################

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
