#!/bin/bash
###get interfaces in active bonding
array=()
while read line; do
  array+=( "$line" )
done < <( cat /proc/net/bonding/bond0 | grep "Slave In" | cut -d" " -f3)

#####cp old ifcfg-* in bonding to bak and create new ifcfg-*
for item in "${array[@]}"; do
        echo "$item"

        cp /etc/sysconfig/network-scripts/ifcfg-$item /etc/sysconfig/network-scripts/old.ifcfg-$item
echo 'TYPE=Ethernet
BOOTPROTO=none
DEVICE=$item
ONBOOT=yes
MASTER=bond0
SLAVE=yes
NM_CONTROLLED=no
IPV6INIT=no
MTU=9216' > /etc/sysconfig/network-scripts/ifcfg-$item

done

cp /etc/sysconfig/network-scripts/ifcfg-bond0 /etc/sysconfig/network-scripts/old.ifcfg-bond0


#####create new ifcfg-bond0
echo 'DEVICE=bond0
NAME=bond0
TYPE=Bond
BONDING_MASTER=yes
BOOTPROTO=none
ONBOOT=yes
USERCTL=no
MTU=9216
DEFROUTE=no
NM_CONTROLLED=no
IPV6INIT=no
BONDING_OPTS="mode=802.3ad lacp_rate=1 miimon=100 xmit_hash_policy=layer3+4"' > /etc/sysconfig/network-scripts/ifcfg-bond0

########  rewrite all VLAN iface
cd /etc/sysconfig/network-scripts/
for i in $( ls -l ifcfg-bond0.* );do
        if [ -f "$i" ];then
                echo "File exist!"
                cp $i old.$i
                cat old.$i | grep -i -E "DEVICE|VLAN_ID|IPADDR|PREFIX|MASK|GATEWAY" > $i
echo 'BOOTPROTO=none
ONBOOT=yes
VLAN=yes
NM_CONTROLLED=no
IPV6INIT=no
USERCTL=no
MTU=1500' >> $i

        fi
done



###rewrite confi in defined list of vlan iface
#list="67 503 504"
### disable IPV6 on all VLAN iface
#for i in $list; do
#
#        if [ -f "ifcfg-bond0.$i" ];then
#                echo "File exist!"
#        cp ifcfg-bond0.$i old.ifcfg-bond0.$i
#        #cat ifcfg-bond0.67 |sed '/IPV6_/d' | sed '/IPV6INIT=yes/IPV6INIT=no/'
#               cat old.ifcfg-bond0.$i | grep -i -E "DEVICE|VLAN_ID|IPADDR|PREFIX|MASK|GATEWAY" > ifcfg-bond0.$i
#echo 'BOOTPROTO=none
#ONBOOT=yes
#VLAN=yes
#NM_CONTROLLED=no
#IPV6INIT=no
#USERCTL=no
#MTU=1500' >>  ifcfg-bond0.$i
#                
#        fi
#done 
