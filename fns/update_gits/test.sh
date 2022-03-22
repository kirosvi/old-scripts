#!/bin/bash

ANS_DIR=~/ansible
INV_DIR=$ANS_DIR/inventory
array=()

function lane() {
	cl=$(stty size |cut -d " " -f2)
	python -c "print '-'*$cl";
}


while IFS=  read -r -d $'\0'; do
    array+=("$REPLY")
done < <(find  $ANS_DIR/roles/ -maxdepth 1 -type d -print0)
#echo ${!array[@]}

array[0]="$INV_DIR"

lane

for i in ${array[@]}; do
	echo $i
	cd $i
	git pull
	lane
done

