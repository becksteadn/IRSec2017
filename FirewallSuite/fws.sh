#!/bin/bash

if [$1 = "block"]; then
    iptables -A INPUT -s $2 -j LOGDROP
elif [$1 = "serv"];then
    iptables -A -p tcp --dport $2 -m state --state NEW, ESTABLISHED -j ACCEPT
    iptables -A -p tcp --sport $2 -m state --state ESTABLISHED -j ACCEPT
elif [$1 = "status"]; then
    iptables -L -n -v --line-numbers
elif [$1 = "impdeny"]; then
    
fi
