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
ACTION="apply -auto-approve"
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
		[ $ACTION = destroy ] || func_terraform_check_state () 
		eval '
		for EACH in {'"$HOSTS"'}
		do 
			func_terraform_action ()
		done
		'
		;;
	*)
		for EACH in $(echo ${HOSTS})
		do
			func_terraform_action ()
		done
		;;
esac

func_terraform_check_state () {
		cd ${TF_DIR}
		STATE=$(terraform show ${STATE_DIR}/${QEMU_HOST_PREFIX}${EACH}.tfstate | wc -l)
		if (( $STATE=1 ))
		then
			echo "###   Beginning the deployment of ${QEMU_HOST_PREFIX}${EACH}   ###"
			sleep 2
		
		else
			echo "!!CAUTION!!!!CAUTION!!!!CAUTION!!!!CAUTION!!!!CAUTION!!"
			echo "   ${HOSTS} seems to be at least partially deployed    "
			echo "       Press y to continue deployment       "	
			read -n1 -p "  Any other key to skip ${QEMU_HOST_PREFIX}${EACH} deployment " CONTINUE
			case $CONTINUE in
				y) 
					echo "Continuing deployment of ${QEMU_HOST_PREFIX}${EACH}..."
					sleep 2
					;;
				*)
					echo "Skipping deployment of ${QEMU_HOST_PREFIX}${EACH}"	
					exit
					;;
			esac
		fi
}

func_terraform_action () {
			cd ${TF_DIR}; terraform ${ACTION} -state=${STATE_DIR}/${QEMU_HOST_PREFIX}${EACH}.tfstate -var libvirt_uri="qemu+ssh://${QEMU_USER}@${QEMU_HOST_PREFIX}${EACH}.${DOMAIN}/system"
}
