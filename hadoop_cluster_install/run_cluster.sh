#!/bin/bash

#start hadoop hdfs
$HADOOP_HOME/sbin/start-dfs.sh

#start yarn
$HADOOP_HOME/sbin/start-yarn.sh

#start hive metastore
$HIVE_HOME/bin/hive --service metastore &

#start hiveserver2
$HIVE_HOME/bin/hiveserver2 &

#start spark
$SPARK_HOME/sbin/start-all.sh