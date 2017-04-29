#!/bin/bash

echo $(w | cut -f1 -d' ' | uniq | wc -l) "logged in users:"
w -h | cut -f1 -d' ' | uniq | sort | uniq



