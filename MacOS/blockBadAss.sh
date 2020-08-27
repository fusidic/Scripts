#!/bin/bash
# Author:	Fusidic
# Date:		2020-06-11

if [ "$1" == "" ]
then
	echo -e "[ERROR] MISSING ARGS\n"
	echo -e "Usage:
	./blockBadAss.sh [ACTION]

Actions:
	drop		block it
	pass		let it go
	"
elif [ "$1" == "drop" ]
then
	ssh admin@192.168.1.1 "/usr/sbin/iptables -I INPUT -s 192.168.1.92 -j DROP"
	ssh admin@192.168.1.1 "/usr/sbin/iptables -L | grep DESKTOP"
	if [ $? -ne 0 ]
	then
		echo "Ops, that did't work man"
	else
		echo "Feels bad man"
	fi
elif [ "$1" == "pass" ]
then
	ssh admin@192.168.1.1 "/usr/sbin/iptables -D INPUT -s 192.168.1.92 -j DROP"
	ssh admin@192.168.1.1 "/usr/sbin/iptables -L | grep DESKTOP"
	if [ $? -ne 0 ]
	then
		echo "Okay, show some kindness."
	fi
else
	echo "BADASS"
fi