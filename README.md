# libvirt-vagrant-Installing-Tower-Cluster
This is to install tower cluster for Demo purposes only

##Background:
The Tower Cluster procedure is based on this link: https://www.ansible.com/blog/getting-started-installing-ansible-tower-cluster. Not for production deployment but should only use for Demo purposes to test and understand how to setup Ansible Tower cluster on your laptop that can be setup and tear down anytime/anywhere. This setup focuses on
 - Environment that is easy to maintain
 - Environment that is easy to use
 - Efficienct, because the overhead of maintaining demo environment is done by yourself!

##Assumption
1. This document assume that you have a working setup of vagrant + libvirt (KVM/Qemu) environment on your laptop.
2. That you have your tower trial license.

##Requirements:
1. vagrant 1.9.5 or higher
2. vagrant plugins
   * vagrant-libvirt
   * vagrant-hostmanager
   * vagrant-triggers
   * fog-libvirt

##Procedure
1. Download the code from :https://github.com/mikecali/libvirt-vagrant-Installing-Tower-Cluster
2. Vagrant up --provider=libvirt
3. Login to each vm host (3 vm) and take the ip address on eth0
4. Access the IP address from your browser of choice 
5. Enable your Tower using your trial license (do this on each node)
6. Test your cluster by envoking demo scm. Check the job status on each node.
7. Enjoy!  
- 
-
