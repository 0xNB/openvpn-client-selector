#!/bin/bash

configs=$( sudo ls /etc/openvpn/client )
counter=1

#Ask the user which config to select

for config in $configs
do
	if [ "${config: -5}" == ".conf" ]
	then
		echo $counter\) ${config%.conf}
		counter=$((counter+1))
	fi
done

case $1 in
	"france")
	echo France config selected. Establishing connection.
	sudo openvpn --config /etc/openvpn/client/France.conf
	;;
	*)
	echo Unknown config selected.
	;;
esac
