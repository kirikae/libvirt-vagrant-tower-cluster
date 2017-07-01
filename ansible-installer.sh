#/bin/bash
clusternode1=clusternode1.demo.com
if [ $HOSTNAME = $clusternode1 ]
then
    sh -x /home/vagrant/ansible-tower-install.sh
else
    echo "clusternode1 only"

fi
