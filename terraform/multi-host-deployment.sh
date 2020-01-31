#!/bin/bash

## Script to deploy CaaSP clusters via Terraform across a set group of KVM hosts

###
Variables
###
TF_DIR=/home/admin/new_SUSECon/terraform
STATE_DIR=/home/admin/new_SUSECon/terraform/state
QEMU_USER=admin
QEMU_HOST_PREFIX=infra
DOMAIN=susecon.local
echo "***IMPORTANT*** This script does not know the number of hosts you have"
echo "in your environment. Calling on the wrong hosts, too many hosts, or"
echo "hosts that don't exist will cause various kinds of errors and/or headaches."
echo ""
echo "Enter the host numbers for deployment in formats of single number (i.e. 1),"
#read -p "comma separated list (i.e. 1,3), or range (i.e. 2..4): " HOSTS
read -p "space separated list (i.e. 1 3), or range (i.e. 2..4): " HOSTS

case $HOSTS in
	*..*)
		eval '
		for EACH in {'"$HOSTS"'}; do
			echo "cd ${TF_DIR}; terraform apply -state=${STATE_DIR}/${QEMU_HOST_PREFIX}${EACH}.tfstate -var libvirt_uri="qemu+ssh://${QEMU_USER}@${QEMU_HOST_PREFIX}${EACH}.${DOMAIN}/system""
		done
		'
		;;
	*)
		for EACH in $(echo ${HOSTS})
		do
			echo "cd ${TF_DIR}; terraform apply -state=${STATE_DIR}/${QEMU_HOST_PREFIX}${EACH}.tfstate -var libvirt_uri="qemu+ssh://${QEMU_USER}@${QEMU_HOST_PREFIX}${EACH}.${DOMAIN}/system""
		done
		;;
esac
