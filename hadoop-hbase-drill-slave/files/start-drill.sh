echo -e "\nstart drill..."
/usr/local/drill/bin/drillbit.sh start

sleep 20

echo -e "\nenabling hbase on drill..."
curl -X POST -H "Content-Type: application/json" -d '{"name":"hbase", "config":{ "type": "hbase", "config": { "hbase.zookeeper.quorum": "localhost", "hbase.zookeeper.property.clientPort": "2181" }, "size.calculator.enabled": false, "enabled": true}}' http://localhost:8047/storage/hbase.json >> /dev/null


