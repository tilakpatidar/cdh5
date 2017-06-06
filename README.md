# cdh5
Docker image for Cloudera Hadoop components (CDH5)

Services included:
- Hive Metastore
- Hive Server
- MySQL(Metastore DB for Hive)
- Postgressdfsd
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
