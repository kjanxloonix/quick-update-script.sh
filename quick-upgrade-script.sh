#!/bin/bash

green="\033[1;32m"
red="\033[1;31m"
clean="\033[0m"

comm_snap=(
	'apt-get install -f'
	'apt-get update'
	'apt-get upgrade'
	'apt-get dist-upgrade'
	'apt-get autoremove'
	'apt-get autoclean'
	'snap refresh'
)

comm_nosnap=(
	'apt-get install -f'
	'apt-get update'
	'apt-get upgrade'
	'apt-get dist-upgrade'
	'apt-get autoremove'
	'apt-get autoclean'
)

comm=()
 
if dpkg -s snapd 2> /dev/null;
then
	comm=("${comm_snap[@]}");
else
	comm=("${comm_nosnap[@]}");
fi


for i in "${comm[@]}"; do
	printf "\n${green} $i${clean}\n"
	$i
	int_code=$?
	if [[ $int_code != 0 ]]; then
		printf "\n==>${red}Interruption: ErrorCode:${clean} $int_code\n\n"
		exit $int_code
	fi
done

printf "\n==>${red}Finished updating succesfully.${clean}\n\n"
exit 0
