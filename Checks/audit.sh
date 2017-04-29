#!/bin/bash

bkp="/lib/. "
log="/root/audit.log"

echo "*********************************" >> $log
echo -n "***  ">>$log
date >> $log

if [ -d /var/www ]; then
	grep -R "exec" /var/www >> $log
	grep -R "password" /var/www >> $log
	
fi

diff -s $(which bash) $(which nologin) | grep ident>> $log
diff -s $(which bash) $(which false) | grep ident>> $log
diff -s $(which sh) $(which nologin) | grep ident>> $log
diff -s $(which sh) $(which false) | grep ident>> $log

diff "$bkp/passwd" /etc/passwd >> $log

echo "">>$log
