#!/bin/bash

configs=$( sudo ls /etc/openvpn/client | grep .conf)
counter=0

#Ask the user which config to select

for config in $configs
do
	if [ "${config: -5}" == ".conf" ]
	then
		echo $counter\) ${config%.conf}
		counter=$((counter+1))
	fi
done

arr=($configs)
re='^[0-9]+$'

read -p "Select an openvpn server to connect to: " selection
echo
if [ "$selection" = "" ] || ! [[ $selection =~ $re ]]
then
        echo Not a number, exiting.
        exit 1
elif [ "$selection" -gt "$((${#arr[@]} - 1))" ] || [ "$selection" -lt 0 ]
then
	echo Selection out of range, exiting
	exit 1
fi
echo ${arr[$selection]%.conf} selected, establishing connection with config file ${arr[$selection]}
sudo openvpn --config /etc/openvpn/client/${arr[$selection]}
