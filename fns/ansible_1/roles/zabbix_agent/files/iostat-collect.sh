#!/bin/bash

# Script for iostat monitoring
# Author Lysov Andrey

/usr/bin/iostat -x 1 8 | grep -v -E "Device|dm-" | awk '{print $1" "$2" "$3" "$4" "$5" "$6" "$7" "$8" "$9" "$10" "$11" "$12" "$13" "$14}' > /tmp/disk.txt.tmp ; cp /tmp/disk.txt.tmp /tmp/disk.txt
echo 0
