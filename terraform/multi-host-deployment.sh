#!/bin/bash

## Script to deploy CaaSP clusters via Terraform across a set group of KVM hosts

echo "Enter the host numbers for deployment in formats of single number (i.e. 1),"
#read -p "comma separated list (i.e. 1,3), or range (i.e. 2..4): " HOSTS
read -p "space separated list (i.e. 1 3), or range (i.e. 2..4): " HOSTS

case $HOSTS in
	*..*)
		eval '
		for EACH in {'"$HOSTS"'}; do
			echo "terraform apply -state=state/infra${EACH}.tfstate -var libvirt_uri="qemu+ssh://admin@infra${EACH}.susecon.local/system""
		done
		'
		;;
	*)
		for EACH in $(echo ${HOSTS})
		do
			echo "terraform apply -state=state/infra${EACH}.tfstate -var libvirt_uri="qemu+ssh://admin@infra${EACH}.susecon.local/system""
		done
		;;
esac
