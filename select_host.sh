#/bin/bash
dbnode=dbnode
if [ $HOSTNAME != $dbnode ]
then
    sudo /usr/bin/yum install ansible -y
else
    sudo /usr/bin/yum remove ansible -y
fi

