# cdh5
Docker image for Cloudera Hadoop components (CDH5)

Services included:
- Hive Metastore
- Hive Server
- MySQL(Metastore DB for Hive)
- Postgres
- Hue
- Zookeeper
- Yarn resource manager
- HDFS Namenode
- MapReduce History

Run the following script to run docker machine: 

The following script creates docker machine, docker network and setups required network configuration.
```
./build.sh $CLUSTER_NODES
```
The following dashboard links are useful

[http://hdfsnamenode.cdh5-local:50070](http://hdfsnamenode.cdh5-local:50070)

[http://hiveserver.cdh5-local:10002](http://hiveserver.cdh5-local:10002)

[http://yarnresourcemanager.cdh5-local:8088](http://yarnresourcemanager.cdh5-local:8088)

[http://mapreducehistory.cdh5-local:19888](http://mapreducehistory.cdh5-local:19888)
