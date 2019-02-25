#bin/bash
FILE=ansible-tower-setup-bundle-latest.el7.tar.gz
DIR=ansible-tower-setup-bundle-3.4.1-1.el7

sudo yum install wget -y

ls $FILE
if [ -f "$FILE" ];
then
  echo "no need"
else
  wget https://releases.ansible.com/ansible-tower/setup-bundle/ansible-tower-setup-bundle-latest.el7.tar.gz
fi
cp /tmp/vagrant /home/vagrant/.ssh/
chown vagrant:vagrant /home/vagrant/.ssh/*
chmod 600 /home/vagrant/.ssh/vagrant

if [ -f "$DIR" ]
then
  echo "no need"
else
  tar -xvf /home/vagrant/ansible-tower-setup-bundle-latest.el7.tar.gz
fi
cp /home/vagrant/inventory /home/vagrant/${DIR}/
sudo chown -R vagrant:vagrant /home/vagrant/ansible-tower*
sudo sed -i '/host_key_checking/a host_key_checking = False' /etc/ansible/ansible.cfg
setenforce 0
export ANSIBLE_HOST_KEY_CHECKING=False
sudo su vagrant /home/vagrant/${DIR}/setup.sh
