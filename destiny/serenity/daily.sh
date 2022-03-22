#!/bin/sh
day=`date +%d`
echo $day
d=$(($day % 2))

if [ $d -eq 0 ];then
       rsync -arvz root@10.1.20.51:/mnt/shares/HR /mnt/serenity/serenity2 && rsync -arvz root@10.1.20.51:/mnt/shares/Tera_Prog /mnt/serenity/serenity2 && rsync -arvz root@10.1.20.51:/mnt/shares/Destiny /mnt/serenity/serenity2 && rsync -arvz root@10.1.20.51:/mnt/shares/Botva_BigGame /mnt/serenity/serenity2
else
       rsync -arvz root@10.1.20.51:/mnt/shares/HR /mnt/serenity/serenity1 && rsync -arvz root@10.1.20.51:/mnt/shares/Tera_Prog /mnt/serenity/serenity1 && rsync -arvz root@10.1.20.51:/mnt/shares/Destiny /mnt/serenity/serenity1 && rsync -arvz root@10.1.20.51:/mnt/shares/Botva_BigGame /mnt/serenity/serenity1
fi
