#/bin/bash
TOWER1=tower1.example.com
if [ $HOSTNAME = $TOWER1 ]
then
    sh -x /home/vagrant/ansible-tower-install.sh
else
    echo "tower1 only"

fi
