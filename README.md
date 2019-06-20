# libvirt-vagrant-Installing-Tower-Cluster
This is to install tower cluster for Demo purposes only

## Background:
The Tower Cluster procedure is based on this link: https://www.ansible.com/blog/getting-started-installing-ansible-tower-cluster. Not for production deployment but should only use for Demo purposes to test and understand how to setup Ansible Tower cluster on your laptop that can be setup and tear down anytime/anywhere. This setup focuses on
 - Environment that is easy to maintain
 - Environment that is easy to use
 - Efficienct, because the overhead of maintaining demo environment is done by yourself!

## Assumption
1. This document assume that you have a working setup of vagrant + libvirt (KVM/Qemu) environment on your laptop.
2. That you have your tower trial license.

## Requirements:
1. vagrant 1.9.5 or higher
2. vagrant plugins
   * vagrant-libvirto
   
```bash
# To get latest version of vagrant-libvirt, do not install from the Fedora repos
sudo dnf --setopt install_weak_deps=0 --best install vagrant
# Deps for the vagrant-libvirt from the plugin repo
sudo dnf install libvirt-devel ruby-devel gcc 
# Install from the plugins
vagrant plugin install vagrant-libvirt
```

## Procedure
1. Download the code from :https://github.com/mikecali/libvirt-vagrant-Installing-Tower-Cluster
2. Vagrant up --provider=libvirt
3. Login to each vm host (3 vm) and take the ip address on eth0
4. Access the IP address from your browser of choice 
5. Enable your Tower using your trial license (do this on each node)
6. Test your cluster by invoking demo scm. Check the job status on each node.
7. Enjoy!  

## The Vagrantfile explained
The Vagrant file below will give you your 3x Tower Cluster nodes and 1x DBnode.
I have to load 3 small files because these is our key to building the VM purely using vagrant features.

- ansible-tower-install.sh - this scripts add packages that we need to build the nodes. This script is envoke once VM are setup.
- inventory - this is the updated inventory file that was created purposely with some tweaks.
- vagrant - the insecure vagrant key


~~~
Vagrant.configure("2") do |config|
# Define VMs with static private IP addresses, vcpu, memory and vagrant-box.
  boxes = [
    {
      :name => "clusternode1.demo.com",
      :box => "centos/7",
      :ram => 2096,
      :vcpu => 1,
      :ip => "192.168.29.2"
    },
    {
      :name => "clusternode2.demo.com",
      :box => "centos/7",
      :ram => 2096,
      :vcpu => 1,
      :ip => "192.168.29.3"
    },
    {
      :name => "clusternode3.demo.com",
      :box => "centos/7",
      :ram => 2096,
      :vcpu => 1,
      :ip => "192.168.29.4"
    },
    {
      :name => "dbnode.demo.com",
      :box => "centos/7",
      :ram => 1024,
      :vcpu => 1,
      :ip => "192.168.29.5"
    }
  ]
  # Provision each of the VMs.
  boxes.each do |opts|
    config.vm.define opts[:name] do |config|
      config.vm.synced_folder ".", "/vagrant", id: "vagrant-root", disabled: true
      config.ssh.insert_key = false
      config.vm.box = opts[:box]
      config.vm.box_version = opts[:version]
      config.vm.hostname = opts[:name]
      config.vm.provider :libvirt do |v|
        v.memory = opts[:ram]
        v.cpus = opts[:vcpu]
      end
    config.vm.network :private_network, ip: opts[:ip]
    config.vm.provision :file do |file|
        file.source     = './keys/vagrant'
        file.destination    = '/tmp/vagrant'
       end
    config.vm.provision :file do |file|
        file.source     = './inventory'
        file.destination    = '/home/vagrant/inventory'
       end
    config.vm.provision :file do |file|
        file.source     = './ansible-tower-install.sh'
        file.destination    = '/home/vagrant/ansible-tower-install.sh'
       end 
   config.vm.provision :shell, path: "bootstrap-node.sh"
   config.vm.provision :shell, path: "ansible-installer.sh"
   end
  end
end
~~~
 
## Things to remember: (all are scripted)
1. disable host_key_checking on ansible.cfg on your master node.  
2. disable firewalld
3. set selinux to permissive

NOTE: This is NOT good practice, and is done purely here to allow easier learning of Ansible Tower.
