#!/bin/bash

image=$1
tag='latest'


if [ $1 = 0 ]
then
	echo "Please use image name as the first argument!"
	exit 1
fi

# founction for delete images
function docker_rmi()
{
	echo -e "\n\nsudo docker rmi sebge2/$1:$tag"
	sudo docker rmi sebge2/$1:$tag
}


# founction for build images
function docker_build()
{
	cd $1
	echo -e "\n\nsudo docker build -t sebge2/$1:$tag ."
	/usr/bin/time -f "real  %e" sudo docker build -t sebge2/$1:$tag .
	cd ..
}

echo -e "\ndocker rm -f slave1.krejcmat.com slave2.krejcmat.com master.krejcmat.com"
sudo docker rm -f slave1.krejcmat.com slave2.krejcmat.com master.krejcmat.com

sudo docker images >images.txt

#all image is based on dnsmasq. master and slaves are based on base image.
if [ $image == "hadoop-hbase-drill-master" ]
then
	docker_rmi hadoop-hbase-drill-master
	docker_build hadoop-hbase-drill-master
elif [ $image == "hadoop-hbase-drill-slave" ]
then
	docker_rmi hadoop-hbase-drill-slave
	docker_build hadoop-hbase-drill-slave
else
	echo "The image name is wrong!"
fi

echo -e "\nimages before build"
cat images.txt
rm images.txt

echo -e "\nimages after build"
sudo docker images
