#!/bin/bash

# run N slave containers
tag=$1
N=$2

if [ $# != 2  ]
then
	echo "Set first parametar as image version tag(e.g. 0.1) and second as number of nodes"
	exit 1
fi

# delete old master container and start new master container
sudo docker rm -f master.krejcmat.com &> /dev/null
echo "start master container..."
sudo docker run -d -t --restart=always --dns 127.0.0.1 -P --name master.krejcmat.com -h master.krejcmat.com -w /root sebge2/hadoop-hbase-drill-master:$tag&> /dev/null

# get the IP address of master container
FIRST_IP=$(docker inspect --format="{{.NetworkSettings.IPAddress}}" master.krejcmat.com)

# delete old slave containers and start new slave containers
i=1
while [ $i -le $N ]
do
	sudo docker rm -f slave$i.krejcmat.com &> /dev/null
	echo "start slave$i container..."
	sudo docker run -d -t --restart=always --dns 127.0.0.1 -P --name slave$i.krejcmat.com -h slave$i.krejcmat.com -e JOIN_IP=$FIRST_IP sebge2/hadoop-hbase-drill-slave:$tag &> /dev/null
	((i++))
done


echo "start drill master container..."
sudo docker exec -it master.krejcmat.com /bin/sh -c  "/root/start-drill.sh"


i=1
while [ $i -le $N ]
do
	echo "start drill slave$i container..."
	sudo docker exec -it slave$i.krejcmat.com /bin/sh -c  "/root/start-drill.sh"
	((i++))
done
