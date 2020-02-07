#!/bin/bash

#### Script is based on using a central set of SSH keys 
#### If using this with Terraform deployed cluster nodes, need to make sure the
#### keys used by the admin node are populated in the cluster nodes' ~/.ssh/authorized_keys file
#### If using this with a Terraform deployed admin node, need to forward the keys to the admin node

## Test to see if any clusters have been initialized from this admin node
echo "The following custer directories were found:"
sudo find / -name kubeadm-join.conf.d 2>/dev/null

############################################
# Circuit breaker for hands-off deployment #
############################################
eval $(ssh-agent)
ssh-add ~/.ssh/id_rsa

## Test to ensure SSH keys are available to form the cluster
if ! ssh-add -l 
	then 
	echo "SSH forwarded keys are not available."
	read -n1 -p "Is this host providing the cluster SSH keys? (y/n)" KEY_HOST
	case $KEY_HOST in
		y)
		echo "(Re)starting ssh-agent"
		kill ${SSH_AGENT_PID}
		eval "$(ssh-agent)"
		ssh-add
		;;
		*)
		echo "Ensure the host providing the cluster SSH keys has a valid ssh-agent running 
		(hint: try killing any running ssh-agent's then start a new one and ssh-add the cluster keys).
		Exiting due to lack of cluster SSH keys."
		exit
		;;
	esac	
#	else
#	read -n1 -p "Is at least one of the keys shown above the ones needed to form the cluster? (y/n)" KEYS 
#	case $KEYS in
#		y)
#		echo "Continuing to next step in forming the cluster"
#		;;
#		*)
#		echo "Exiting due to lack of cluster SSH keys."
#		exit
#		;;
#	esac	
fi


## Populates the known_hosts file with the FQDN of the cluster nodes
### To ssh with an alias or short name, create a .ssh/config entry for 
### each node where HOST points to the alias and HOSTNAME points to the FQDN
ssh-keyscan -H -f ~/.all_nodes > ~/.ssh/known_hosts


## Initialize a new cluster
### Set API_ENDPOINT to the FQDN of the load balancer VIP or of the master in case of a single master deployment
#API_ENDPOINT=master-0.caasp-susecon.lab
API_ENDPOINT=$(grep master ~/.all_nodes | head -1)
#CLUSTER_NAME=susecon
CLUSTER_NAME=$(grep master ~/.all_nodes | head -1 | awk -F. '{print$2}')

if [ -d "~/${CLUSTER_NAME}" ] 
then
	echo "Cluster is already initialized. Exiting"
	exit
fi

cd ~; skuba cluster init --control-plane $API_ENDPOINT $CLUSTER_NAME
cd $CLUSTER_NAME


## Bootstrap the cluster with the first master node listed in ~/.all_nodes
MASTER_FQDN=$(grep master ~/.all_nodes | head -1)
MASTER=$(echo $MASTER_FQDN | awk -F. '{print$1}')

skuba node bootstrap --user sles --sudo --target ${MASTER_FQDN} ${MASTER}

## Join the remaining master nodes to the cluster
### Will simply bypass in the case of a single master deployment
for MASTER_FQDN in `grep master ~/.all_nodes | tail -n+2`; do \
MASTER=`echo $MASTER_FQDN | awk -F. '{print$1}'`; \
skuba node join --role master --user sles --sudo \
--target $MASTER_FQDN $MASTER; \
done

## Join the worker nodes to the cluster
for WORKER_FQDN in `grep worker ~/.all_nodes`; do \
WORKER=`echo $WORKER_FQDN | awk -F. '{print$1}'`; \
skuba node join --role worker --user sles --sudo \
--target $WORKER_FQDN $WORKER; \
done


## Kill ssh-agent
kill ${SSH_AGENT_PID}



echo export KUBECONFIG=${HOME}/${CLUSTER_NAME}/admin.conf >> ~/.bashrc
#cat<<EOF>> ~/.bashrc
#set -o vi
#alias kgn="kubectl get nodes -o wide"
#alias kgd="kubectl get deployments -o wide"
#alias kgp="kubectl get pods -o wide"
#alias kgpa="kubectl get pods -o wide --all-namespaces"
#alias kaf="kubectl apply -f"
#EOF

. ~/.bashrc
cd ${HOME}/${CLUSTER_NAME}; skuba cluster status
kubectl get nodes -o wide



