#!/bin/bash

#HTTP Server

#Clear previous rules
iptables -F

#Allow SSH. Don't get locked out. In this dumb way at least.
iptables -A INPUT -p tcp --dport 22 -j ACCEPT

#Allow localhost
iptables -A INPUT -i lo -j ACCEPT
#iptables -A INPUT -s localhost -j ACCEPT
#iptables -A OUTPUT -s localhost -j ACCEPT

#Allow established connections
iptables -A INPUT -m state --state ESTABLISHED, RELATED -j ACCEPT

#######################

#Allow HTTP
iptables -A INPUT -p tcp --dport 80 -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 80 -j ACCEPT
iptables -A INPUT -p tcp --dport 443 -j ACCEPT
#iptables -A OUTPUT -p tcp --sport 443 -j ACCEPT

#Allow SQL traffic from MySQL Server
SQLSERV="x.x.x.x"
if [$SQLSERV = "x.x.x.x"]; then
    read "SQL server is set to 'x.x.x.x'. You should probably change this."
fi
iptables -A OUTPUT -p tcp --src "$SQLSERV" --sport 3306 -j ACCEPT

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
