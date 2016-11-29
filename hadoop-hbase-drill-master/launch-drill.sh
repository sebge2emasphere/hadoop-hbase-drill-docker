#!/bin/bash

/root/start-hbase.sh

echo "Start drill..."
/usr/local/drill/bin/drillbit.sh start
