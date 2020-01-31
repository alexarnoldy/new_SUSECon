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
ACTION=apply
###

DEPLOYorDESTROY="$(basename $0)"
[ $DEPLOYorDESTROY = cluster-destroy.sh ] && ACTION="destroy"

echo ""
echo "***IMPORTANT*** This script does not know the number of hosts you have"
echo "in your environment. Operating on the wrong hosts, too many hosts, "
echo "or hosts that don't exist can result in anything"
echo "from errors, to headaches, to an urgent desire to update to one's resume"
echo ""
echo "Enter the host numbers for deployment in formats of single number (i.e. 1),"
read -p "space separated list (i.e. 1 3), or range (i.e. 2..4): " HOSTS

case $HOSTS in
	*..*)
		eval '
		for EACH in {'"$HOSTS"'}; do 
			cd ${TF_DIR}; terraform show ${STATE_DIR}/${QEMU_HOST_PREFIX}${EACH}.tfstate | wc -l
			terraform ${ACTION} -state=${STATE_DIR}/${QEMU_HOST_PREFIX}${EACH}.tfstate -var libvirt_uri="qemu+ssh://${QEMU_USER}@${QEMU_HOST_PREFIX}${EACH}.${DOMAIN}/system"
		done
		'
		;;
	*)
		for EACH in $(echo ${HOSTS})
		do
			cd ${TF_DIR}; terraform ${ACTION} -state=${STATE_DIR}/${QEMU_HOST_PREFIX}${EACH}.tfstate -var libvirt_uri="qemu+ssh://${QEMU_USER}@${QEMU_HOST_PREFIX}${EACH}.${DOMAIN}/system"
		done
		;;
esac
