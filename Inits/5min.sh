#!/bin/bash

# Argument 1 - name of interface to flicker
# audit.sh must be in root directory


BkpDir="/lib/. "

mkdir -p "$BkpDir"

echo
echo "\"$1\" going down"
ifconfig $1 down

echo
echo "Backing up etc..."
tar cpf "$BkpDir/etc.tar" /etc 2>/dev/null &
echo "Backing up binaries..."
tar cpf "$BkpDir/bins" /bin /sbin /usr/bin /usr/sbin &
echo "Backing up passwd..."
cp /etc/passwd "$BkpDir/"
echo "Taking snapshot of running services"
service --status-all >"$BkpDir/services"
echo "Taking snapshot of running processes"
ps -aufx >"$BkpDir/procs"
echo "Done... All files stored in \"$BkpDir/\""
echo

ifconfig $1 up
echo "\"$1\" is up"

echo
echo "Changing root password"
echo "root:ChangeME!" | chpasswd

echo
echo "Creating cronjob for audit"
crontab -l 2>/dev/null > tmpcron
echo "5 * * * * /root/audit.sh" >> tmpcron
crontab tmpcron
rm tmpcron
echo
echo "Here are your crontabs:"
crontab -l

echo
echo "set up firewall rules, move wget and curl, secure logs (chatter -R +A /var/log ???)"
