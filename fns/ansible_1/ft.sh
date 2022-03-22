#!/bin/bash
LIST=/home/systemsupport/ansible/genlist/list

#vi /home/systemsupport/ansible/genlist/list
vi $LIST
cat $LIST >> /home/systemsupport/dlisovsky/lists/ansible_all_hosts
/home/systemsupport/ansible/genlist/gen_templ.py

#for HOSTNAME in $(cat /home/systemsupport/ansible/genlist/list);do
for HOSTNAME in $(cat $LIST);do

IPHOST=$(nslookup "$HOSTNAME"|grep -i address|tail -1|cut -d\  -f2-)
sed -i "/$HOSTNAME/d" /home/systemsupport/.ssh/known_hosts
sed -i "/$IPHOST/d" /home/systemsupport/.ssh/known_hosts
sed -i "$ a "$HOSTNAME",$(ssh-keyscan -t rsa "$IPHOST" 2>/dev/null)" /home/systemsupport/.ssh/known_hosts
done

cd /home/systemsupport/ansible

read -p '1.RHEL/OEL
2.ALT 
[1,2]: ' -n1 var
echo -e ""

if [ $var -eq '1' ]; then
	ansible-playbook firts_setting.yml -i small_inv.yml -b --ask-vault-pass
elif [ $var -eq '2' ];then
	ansible-playbook firts_setting.yml -i small_inv.yml -b -K --ask-vault-pass
fi

