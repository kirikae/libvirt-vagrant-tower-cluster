#bin/bash
file=ansible-tower-setup-bundle-latest.el7.tar.gz
directory=ansible-tower-setup-bundle-3.1.3-1.el7

sudo yum install wget -y

ls $file
if [ -f "$file" ];
then
  echo "no need"
else
  wget https://releases.ansible.com/ansible-tower/setup-bundle/ansible-tower-setup-bundle-latest.el7.tar.gz
fi
cp /tmp/vagrant /home/vagrant/.ssh/
chown vagrant:vagrant /home/vagrant/.ssh/*
chmod 600 /home/vagrant/.ssh/vagrant

if [ -f "$directory" ]
then
  echo "no need"
else
  tar -xvf /home/vagrant/ansible-tower-setup-bundle-latest.el7.tar.gz
fi
cp /home/vagrant/inventory /home/vagrant/ansible-tower-setup-bundle-3.1.3-1.el7/
sudo chown -R vagrant:vagrant /home/vagrant/ansible-tower*
sudo sed -i '/host_key_checking/a host_key_checking = False' /etc/ansible/ansible.cfg
sudo mkdir /var/log/tower
sudo chown -R awx:awx /var/log/tower
setenforce 0
export ANSIBLE_HOST_KEY_CHECKING=False
sudo su vagrant /home/vagrant/ansible-tower-setup-bundle-3.1.3-1.el7/setup.sh
