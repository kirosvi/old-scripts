#!/bin/bash
hosts_name=$(cat ./list | awk '{print $2}')
array=()
n=1
w1=1
w2=2
w3=3
for i in $hosts_name
   do
   host_status="Unknown"
   host_ip=$(cat ./list | grep -w "$i" | awk '{print $1}')
   y=$n$w1
   array[$y]="$i"
   ((y++))
   array[$y]="$host_ip"
   ((y++))
   array[$y]="$host_status"
   ((n++))
done
let "leight = ${#array[@]} / 3"
echo -en "\E[2J"
while ( [ "$B" != "q" ] ) do
    echo -en "\E[2J"
    for (( mx=1 ; mx<=$leight; mx++ )) do
        n1=$mx$w1
        n2=$mx$w2
        n3=$mx$w3
        echo  "Host     ${array[$n1]}   with ip ${array[$n2]}   has status is:  ${array[$n3]}"
    done
    for (( mx=1 ; mx<=$leight; mx++ )) do
        n1=$mx$w1
        n2=$mx$w2
        n3=$mx$w3
        ping -c 1 ${array[$n2]} &> /dev/null

        if [ $? -ne 0 ]; then
            array[$n3]="Failed! Connection is lost!"
        else
            array[$n3]=OK
        fi
    done
sleep 5
done
