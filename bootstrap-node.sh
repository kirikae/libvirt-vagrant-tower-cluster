#/bin/sh
rm -rf /etc/yum.repos.d/epel*
yum clean all
rpm --import https://www.elrepo.org/RPM-GPG-KEY-elrepo.org
rpm -e epel-release 
rpm -ivh http://www.elrepo.org/elrepo-release-7.0-2.el7.elrepo.noarch.rpm
rpm -ivh https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
yum clean all
sudo sh -x /tmp/select_host.sh
sudo yum repolist
systemctl stop firewalld
systemctl disable firewalld
setenforce 0
# configure hosts file for our internal network defined by Vagrantfile
sed -i '/192/d' /etc/hosts
sed -i '/vagrant/d' /etc/hosts
cat >> /etc/hosts <<-EOL
# vagrant environment nodes
192.168.29.2  clusternode1.demo.com
192.168.29.3  clusternode2.demo.com
192.168.29.4  clusternode3.demo.com
192.168.29.5  dbnode.demo.com

