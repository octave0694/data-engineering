#### Commandes HADOOP
`$HADOOP_HOME/sbin/start-dfs.sh`: Démarrer le cluster hadoop

`$HADOOP_HOME/sbin/stop-dfs.sh`: Arreter le cluster hadoop

#### Commandes YARN
`$HADOOP_HOME/sbin/start-yarn.sh`: Démarrer yarn

`$HADOOP_HOME/sbin/stop-yarn.sh`: Arreter yarn

`yarn node --list`: Afficher les noeuds yarn

`yarn logs -applicationId`: Afficher les logs aggrégées d'une application lancée sur yarn


#### Commandes HIVE
`$HIVE_HOME/bin/hive --service metastore &`: Démarrer le métastore hive en background

`$HIVE_HOME/bin/hiveserver2 &`: Démarrer hiveserver 2 en background

#### Commandes SPARK
`$SPARK_HOME/sbin/start-all.sh`: Démarrer le cluster spark

`$SPARK_HOME/sbin/stop-all.sh`: Arreter le cluster spark

`$SPARK_HOME/sbin/start-history-server.sh`: Démarrer le history-server

`$SPARK_HOME/sbin/stop-history-server.sh`: Arreter le history-server

`spark-shell --master spark://master:7077 --name "test" --conf spark.driver.cores=2`: Lancer spark-shell sur le master

`spark-sql --master spark://master:7077 --name "test" --conf spark.driver.cores=2`: Lancer spark-sql sur le mster

`spark-shell --master yarn --deploy-mode client`: Lancer spark-shell en mode client sur yarn


#### Autres
`ps aux | grep <process-name>`

`kill -9 <process_id>`

#### Interfaces web
* HDFS => http://192.168.44.140:9870/
* YARN UI => http://192.168.44.140:8088/
* YARN UI2 => http://192.168.44.140:8088/ui2
* HIVE SERVER UI => http://192.168.44.140:10002/
* SPARK MASTER => http://192.168.44.140:8080/
* SPARK HISTORY SERVER => http://192.168.44.140:18080/