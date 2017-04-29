#!/bin/bash

logs=("/var/log/auth.log" "/var/log/secure" "/var/log/mail.log")

for log in "${logs[@]}"
do
    echo "======================Fails for $log====================="
    cat $log | grep fail
done 
