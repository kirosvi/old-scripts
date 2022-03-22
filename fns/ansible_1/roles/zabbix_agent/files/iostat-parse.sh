#!/bin/bash

# Script for disk monitoring
# Author Lysov Andrey

NUBMER=100500
DISK=$2
METRIC=$3

case "$3" in
"rrqm/s")
        NUMBER=2
;;
"wrqm/s")
        NUMBER=3
;;
"r/s")
        NUMBER=4
;;
"w/s")
        NUMBER=5
;;
"rkB/s")
        NUMBER=6
;;
"wkB/s")
        NUMBER=7
;;
"avgrq-sz")
        NUMBER=8
;;
"avgqu-sz")
        NUMBER=9
;;
"await")
        NUMBER=10
;;
"r_await")
        NUMBER=11
;;
"w_await")
        NUMBER=12
;;
"svctm")
        NUMBER=13
;;
"util")
        NUMBER=14
;;
esac

cat /tmp/disk.txt | grep $DISK | tail -n +2 | tr -s ' ' | cut -f$NUMBER -d' ' | awk '{ s += $1 }  END { print s/NR }' |  cut -d. -f1
(END)
