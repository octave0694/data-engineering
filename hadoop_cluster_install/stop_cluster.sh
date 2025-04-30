#!/bin/bash

#stop spark
$SPARK_HOME/sbin/stop-all.sh

#stop yarn
$HADOOP_HOME/sbin/stop-yarn.sh

#start hadoop hdfs
$HADOOP_HOME/sbin/stop-dfs.sh
