#/bin/bash
DBNODE=db
if [ $HOSTNAME != $DBNODE ]
then
    sudo /usr/bin/yum install ansible -y
else
    sudo /usr/bin/yum remove ansible -y
fi

